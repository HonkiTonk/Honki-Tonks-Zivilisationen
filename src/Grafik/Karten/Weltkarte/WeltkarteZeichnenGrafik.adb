pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;
with Sf.Graphics.Color;

with EinheitenDatentypen; use EinheitenDatentypen;
with KartengrundDatentypen; use KartengrundDatentypen;
with KartenVerbesserungDatentypen; use KartenVerbesserungDatentypen;
with EinheitenKonstanten;
with TextaccessVariablen;
with ZeitKonstanten;
with KartenKonstanten;
with GrafikKonstanten;

with LeseEinheitenGebaut;
with LeseKarten;
with LeseStadtGebaut;

with EinheitSuchen;
with StadtSuchen;
with ObjekteZeichnenSFML;
with EingeleseneTexturenSFML;
with KartenspritesZeichnenSFML;
with FarbgebungSFML;
with TextberechnungenBreiteSFML;
with RasseneinstellungenSFML;
with TextberechnungenHoeheSFML;
with BerechnungenKarteSFML;
with Kartenkoordinatenberechnungssystem;
with GrafikEinstellungenSFML;

package body WeltkarteZeichnenGrafik is

   procedure KartenfeldZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      DurchsichtigkeitExtern : in Sf.sfUint8)
   is begin
      
      AktuellerKartengrund := LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern);
      BasisKartengrund := LeseKarten.BasisGrund (KoordinatenExtern => KoordinatenExtern);
      
      -- Den aktuellen Grund auch durchsichtig gestalten wenn er nicht dem Basisgrund entspricht, um den Grund darunter sichtbar zu machen? äöü
      if
        AktuellerKartengrund = BasisKartengrund
      then
         null;
         
      else
         case
           KartenspritesZeichnenSFML.SpriteGezeichnetKartenfeld (TexturAccessExtern     => EingeleseneTexturenSFML.KartenfelderAccess (BasisKartengrund),
                                                                 PositionExtern         => PositionExtern,
                                                                 DurchsichtigkeitExtern => DurchsichtigkeitExtern)
         is
            when True =>
               null;
            
            when False =>
               ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern => BerechnungenKarteSFML.KartenfelderAbmessung,
                                                     PositionExtern  => PositionExtern,
                                                     FarbeExtern     => FarbgebungSFML.FarbeKartenfeldErmitteln (GrundExtern => BasisKartengrund));
         end case;
      end if;
      
      case
        KartenspritesZeichnenSFML.SpriteGezeichnetKartenfeld (TexturAccessExtern     => EingeleseneTexturenSFML.KartenfelderAccess (AktuellerKartengrund),
                                                              PositionExtern         => PositionExtern,
                                                              DurchsichtigkeitExtern => DurchsichtigkeitExtern)
      is
         when True =>
            null;
            
         when False =>
            ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern => BerechnungenKarteSFML.KartenfelderAbmessung,
                                                  PositionExtern  => PositionExtern,
                                                  FarbeExtern     => FarbgebungSFML.FarbeKartenfeldErmitteln (GrundExtern => AktuellerKartengrund));
      end case;
      
   end KartenfeldZeichnen;
   
   
   
   procedure FlussZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      KartenfeldFluss := LeseKarten.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenfeldFluss
      is
         when KartengrundDatentypen.Leer_Fluss_Enum =>
            return;
            
         when others =>
            null;
      end case;
      
      case
        KartenspritesZeichnenSFML.SpriteGezeichnetKartenfeld (TexturAccessExtern     => EingeleseneTexturenSFML.KartenflussAccess (KartenfeldFluss),
                                                              PositionExtern         => PositionExtern,
                                                              DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig)
      is
         when True =>
            null;
            
         when False =>
            ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern => (BerechnungenKarteSFML.KartenfelderAbmessung.x, BerechnungenKarteSFML.KartenfelderAbmessung.y / 5.00),
                                                  PositionExtern  => (PositionExtern.x, PositionExtern.y + 0.40 * BerechnungenKarteSFML.KartenfelderAbmessung.y),
                                                  FarbeExtern     => FarbgebungSFML.FarbeFlussErmitteln (FlussExtern => KartenfeldFluss));
      end case;
      
   end FlussZeichnen;
   
   
   
   procedure RessourceZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      KartenfeldRessource := LeseKarten.Ressource (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenfeldRessource
      is
         when KartengrundDatentypen.Leer_Ressource_Enum =>
            return;
            
         when others =>
            null;
      end case;
      
      case
        KartenspritesZeichnenSFML.SpriteGezeichnetKartenfeld (TexturAccessExtern     => EingeleseneTexturenSFML.KartenressourceAccess (KartenfeldRessource),
                                                              PositionExtern         => PositionExtern,
                                                              DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig)
      is
         when True =>
            null;
            
         when False =>
            ObjekteZeichnenSFML.KreisZeichnen (RadiusExtern   => BerechnungenKarteSFML.KartenfelderAbmessung.x / 3.00,
                                               PositionExtern => PositionExtern,
                                               FarbeExtern    => Sf.Graphics.Color.sfBlack);
      end case;
      
   end RessourceZeichnen;
   
   
   
   procedure WegZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Wegfeld := LeseKarten.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        Wegfeld
      is
         when KartenVerbesserungDatentypen.Leer_Weg_Enum =>
            return;
            
         when others =>
            null;
      end case;
      
      case
        KartenspritesZeichnenSFML.SpriteGezeichnetKartenfeld (TexturAccessExtern     => EingeleseneTexturenSFML.WegeAccess (Wegfeld),
                                                              PositionExtern         => PositionExtern,
                                                              DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig)
      is
         when True =>
            null;
            
         when False =>
            ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern => (BerechnungenKarteSFML.KartenfelderAbmessung.x, BerechnungenKarteSFML.KartenfelderAbmessung.y / 2.00),
                                                  PositionExtern  => (PositionExtern.x, PositionExtern.y + 0.80 * BerechnungenKarteSFML.KartenfelderAbmessung.y),
                                                  FarbeExtern     => Sf.Graphics.Color.sfRed);
      end case;
      
   end WegZeichnen;
   
   
   
   procedure VerbesserungZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Verbesserungsfeld := LeseKarten.Verbesserung (KoordinatenExtern => KoordinatenExtern);
      
      case
        Verbesserungsfeld
      is
         when KartenVerbesserungDatentypen.Leer_Verbesserung_Enum =>
            return;
            
         when KartenVerbesserungDatentypen.Karten_Verbesserung_Städte_Enum =>
            if
              KoordinatenExtern.EAchse = EbeneExtern
            then
               StadtnameAnzeigen (KoordinatenExtern => KoordinatenExtern,
                                  PositionExtern    => PositionExtern);
               
            else
               null;
            end if;
               
         when others =>
            null;
      end case;
      
      case
        KartenspritesZeichnenSFML.SpriteGezeichnetKartenfeld (TexturAccessExtern     => EingeleseneTexturenSFML.VerbesserungenAccess (Verbesserungsfeld),
                                                              PositionExtern         => PositionExtern,
                                                              DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig)
      is
         when True =>
            null;
            
         when False =>
            ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern => (BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.00, BerechnungenKarteSFML.KartenfelderAbmessung.y / 2.00),
                                                  PositionExtern  => PositionExtern,
                                                  FarbeExtern     => Sf.Graphics.Color.sfCyan);
      end case;
      
   end VerbesserungZeichnen;
   
   
   
   procedure AnzeigeEinheit
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      EinheitRasseNummer := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern,
                                                                             LogikGrafikExtern => False);
      
      case
        EinheitRasseNummer.Nummer
      is
         when EinheitenKonstanten.LeerNummer =>
            return;
            
         when others =>
            EinheitID := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummer);
      end case;
            
      if
        EinheitRasseNummer.Rasse = RasseEinheitExtern.Rasse
        and
          (EinheitRasseNummer.Nummer = RasseEinheitExtern.Nummer
           or
             True = EinheitSuchen.TransporterladungSuchen (TransporterExtern   => EinheitRasseNummer,
                                                           LadungsnummerExtern => RasseEinheitExtern.Nummer))
      then
         if
           Clock - StartzeitBlinkintervall > ZeitKonstanten.Blinkintervall
         then
            AusgewählteEinheitAnzeigen := not AusgewählteEinheitAnzeigen;
            StartzeitBlinkintervall := Clock;
            
         else
            null;
         end if;
         
         case
           AusgewählteEinheitAnzeigen
         is
            when True =>
               null;
               
            when False =>
               return;
         end case;
         
      else
         null;
      end if;
      
      case
        KartenspritesZeichnenSFML.SpriteGezeichnetKartenfeld (TexturAccessExtern     => EingeleseneTexturenSFML.EinheitenAccess (RasseEinheitExtern.Rasse, EinheitID),
                                                              PositionExtern         => PositionExtern,
                                                              DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig)
      is
         when True =>
            null;
            
         when others =>
            ObjekteZeichnenSFML.PolygonZeichnen (RadiusExtern      => BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.80,
                                                 PositionExtern    => PositionExtern,
                                                 AnzahlEckenExtern => 4,
                                                 FarbeExtern       => RasseneinstellungenSFML.RassenFarbenRahmen (EinheitRasseNummer.Rasse));
      end case;
      
   end AnzeigeEinheit;
   
   
   
   procedure AnzeigeFeldbesitzer
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      AktuelleRasse := LeseKarten.RasseBelegtGrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        AktuelleRasse
      is
         when RassenDatentypen.Keine_Rasse_Enum =>
            null;
            
         when others =>
            RahmenBesetztesFeld (KoordinatenExtern => KoordinatenExtern,
                                 PositionExtern    => PositionExtern,
                                 RasseExtern       => AktuelleRasse);
      end case;
            
   end AnzeigeFeldbesitzer;
   
   
   
   procedure RahmenBesetztesFeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      ObjekteZeichnenSFML.RahmenteilZeichnen (PositionExtern => PositionExtern,
                                              FarbeExtern    => RasseneinstellungenSFML.RassenFarben (RasseExtern),
                                              GrößeExtern    => BerechnungenKarteSFML.KartenfelderAbmessung);
      
      UmgebungSchleife:
      for UmgebungSchleifenwert in UmgebungArray'Range loop
         
         KartenWertRahmen := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                    ÄnderungExtern    => Umgebung (UmgebungSchleifenwert),
                                                                                                    LogikGrafikExtern => False);
               
         if
           KartenWertRahmen.XAchse = KartenKonstanten.LeerXAchse
         then
            RahmenZeichnen (WelcheRichtungExtern => UmgebungSchleifenwert,
                            PositionExtern       => PositionExtern,
                            RasseExtern          => RasseExtern);
                     
         elsif
           RasseExtern /= LeseKarten.RasseBelegtGrund (KoordinatenExtern => KartenWertRahmen)
         then
            RahmenZeichnen (WelcheRichtungExtern => UmgebungSchleifenwert,
                            PositionExtern       => PositionExtern,
                            RasseExtern          => RasseExtern);

         else
            null;
         end if;
            
      end loop UmgebungSchleife;
      
   end RahmenBesetztesFeld;



   procedure RahmenZeichnen
     (WelcheRichtungExtern : in Umgebung_Enum;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
            
      case
        WelcheRichtungExtern
      is
         when Norden =>
            Rahmengröße := (BerechnungenKarteSFML.KartenfelderAbmessung.x, DickeRahmen);
            Rahmenposition := PositionExtern;
         
         when Westen =>
            Rahmengröße := (DickeRahmen, BerechnungenKarteSFML.KartenfelderAbmessung.y);
            Rahmenposition := PositionExtern;
         
         when Osten =>
            Rahmengröße := (DickeRahmen, BerechnungenKarteSFML.KartenfelderAbmessung.y);
            Rahmenposition := (PositionExtern.x + BerechnungenKarteSFML.KartenfelderAbmessung.x - DickeRahmen, PositionExtern.y);
         
         when Süden =>
            Rahmengröße := (BerechnungenKarteSFML.KartenfelderAbmessung.x, DickeRahmen);
            Rahmenposition := (PositionExtern.x, PositionExtern.y + BerechnungenKarteSFML.KartenfelderAbmessung.y - DickeRahmen);
      end case;
      
      ObjekteZeichnenSFML.RahmenteilZeichnen (PositionExtern => Rahmenposition,
                                              FarbeExtern    => RasseneinstellungenSFML.RassenFarbenRahmen (RasseExtern),
                                              GrößeExtern    => Rahmengröße);
      
   end RahmenZeichnen;
   
   
   
   procedure StadtnameAnzeigen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
            
      StadtRasseNummer := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern);
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteAccess,
                                         str  => To_Wide_Wide_String (Source => LeseStadtGebaut.Name (StadtRasseNummerExtern => StadtRasseNummer)));
      
      Textposition.x := PositionExtern.x - TextberechnungenBreiteSFML.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.KarteAccess) + 0.50 * BerechnungenKarteSFML.KartenfelderAbmessung.x;
      Textposition.y := PositionExtern.y - TextberechnungenHoeheSFML.Zeilenabstand;
      
      -- Später noch einen Rahmen um den Namen bauen. äöü
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteAccess,
                                    position => Textposition);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.KarteAccess);
      
   end StadtnameAnzeigen;

end WeltkarteZeichnenGrafik;
