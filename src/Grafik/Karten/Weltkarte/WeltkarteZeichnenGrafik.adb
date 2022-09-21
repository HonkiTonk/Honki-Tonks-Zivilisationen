pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf; use Sf;
with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with EinheitenDatentypen; use EinheitenDatentypen;
with KartengrundDatentypen; use KartengrundDatentypen;
with KartenverbesserungDatentypen; use KartenverbesserungDatentypen;
with EinheitenKonstanten;
with TextaccessVariablen;
with ZeitKonstanten;
with KartenKonstanten;
with GrafikKonstanten;

with LeseEinheitenGebaut;
with LeseWeltkarte;
with LeseStadtGebaut;

with EinheitSuchenLogik;
with StadtSuchenLogik;
with ObjekteZeichnenGrafik;
with EingeleseneTexturenGrafik;
with KartenspritesZeichnenGrafik;
with FarbgebungGrafik;
with TextberechnungenBreiteGrafik;
with RasseneinstellungenGrafik;
with TextberechnungenHoeheGrafik;
with KartenberechnungenGrafik;
with KartenkoordinatenberechnungssystemLogik;
with EinstellungenGrafik;

-- Man könnte die Prüfungen in KartenspritesZeichnenGrafik hierher verschieben und dann entsprechend Prozeduren nutzen, aber dann benötige ich mehr Prüfungen und ob es das wirklich bringt? äöü
package body WeltkarteZeichnenGrafik is
   
   procedure EbeneZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      TransparentsExtern : in Sf.sfUint8)
   is begin
      
      WeltkarteZeichnenGrafik.KartenfeldZeichnen (KoordinatenExtern      => KoordinatenExtern,
                                                  PositionExtern         => PositionExtern,
                                                  DurchsichtigkeitExtern => TransparentsExtern);
      
      WeltkarteZeichnenGrafik.RessourceZeichnen (KoordinatenExtern => KoordinatenExtern,
                                                 PositionExtern    => PositionExtern);
      
      WeltkarteZeichnenGrafik.FlussZeichnen (KoordinatenExtern => KoordinatenExtern,
                                             PositionExtern    => PositionExtern);
      
      WeltkarteZeichnenGrafik.WegZeichnen (KoordinatenExtern => KoordinatenExtern,
                                           PositionExtern    => PositionExtern);
      
      WeltkarteZeichnenGrafik.VerbesserungZeichnen (KoordinatenExtern => KoordinatenExtern,
                                                    EbeneExtern       => KoordinatenExtern.EAchse,
                                                    PositionExtern    => PositionExtern);
      
      WeltkarteZeichnenGrafik.AnzeigeEinheit (KoordinatenExtern  => KoordinatenExtern,
                                              RasseEinheitExtern => EinheitRasseNummerExtern,
                                              PositionExtern     => PositionExtern);
      
      WeltkarteZeichnenGrafik.AnzeigeFeldbesitzer (KoordinatenExtern => KoordinatenExtern,
                                                   PositionExtern    => PositionExtern);
      
   end EbeneZeichnen;
   
   

   procedure KartenfeldZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      DurchsichtigkeitExtern : in Sf.sfUint8)
   is begin
      
      AktuellerKartengrund := LeseWeltkarte.AktuellerGrund (KoordinatenExtern => KoordinatenExtern);
      BasisKartengrund := LeseWeltkarte.BasisGrund (KoordinatenExtern => KoordinatenExtern);
      
      if
        AktuellerKartengrund = BasisKartengrund
      then
         GrundGleich := True;
         
      else
         GrundGleich := False;
         
         case
           KartenspritesZeichnenGrafik.SpriteGezeichnetKartenfeld (TexturAccessExtern     => EingeleseneTexturenGrafik.KartenfelderAccess (BasisKartengrund),
                                                                   PositionExtern         => PositionExtern,
                                                                   DurchsichtigkeitExtern => DurchsichtigkeitExtern)
         is
            when True =>
               null;
            
            when False =>
               Farbe := FarbgebungGrafik.FarbeKartenfeldErmitteln (GrundExtern => BasisKartengrund);
               Farbe.a := DurchsichtigkeitExtern;
               ObjekteZeichnenGrafik.RechteckZeichnen (AbmessungExtern => KartenberechnungenGrafik.KartenfelderAbmessung,
                                                       PositionExtern  => PositionExtern,
                                                       FarbeExtern     => Farbe);
         end case;
      end if;
      
      if
        GrundGleich = False
        and
          DurchsichtigkeitExtern = GrafikKonstanten.Undurchsichtig
      then
         Durchsichtigkeit := GrafikKonstanten.VerschiedenerGrundtransparents;
         
      else
         Durchsichtigkeit := DurchsichtigkeitExtern;
      end if;
      
      case
        KartenspritesZeichnenGrafik.SpriteGezeichnetKartenfeld (TexturAccessExtern     => EingeleseneTexturenGrafik.KartenfelderAccess (AktuellerKartengrund),
                                                                PositionExtern         => PositionExtern,
                                                                DurchsichtigkeitExtern => Durchsichtigkeit)
      is
         when True =>
            null;
            
         when False =>
            Farbe := FarbgebungGrafik.FarbeKartenfeldErmitteln (GrundExtern => AktuellerKartengrund);
            Farbe.a := Durchsichtigkeit;
            ObjekteZeichnenGrafik.RechteckZeichnen (AbmessungExtern => KartenberechnungenGrafik.KartenfelderAbmessung,
                                                    PositionExtern  => PositionExtern,
                                                    FarbeExtern     => Farbe);
      end case;
      
   end KartenfeldZeichnen;
   
   
   
   procedure FlussZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      KartenfeldFluss := LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenfeldFluss
      is
         when KartengrundDatentypen.Leer_Fluss_Enum =>
            return;
            
         when others =>
            null;
      end case;
      
      case
        KartenspritesZeichnenGrafik.SpriteGezeichnetKartenfeld (TexturAccessExtern     => EingeleseneTexturenGrafik.KartenflussAccess (KartenfeldFluss),
                                                                PositionExtern         => PositionExtern,
                                                                DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig)
      is
         when True =>
            null;
            
         when False =>
            ObjekteZeichnenGrafik.RechteckZeichnen (AbmessungExtern => (KartenberechnungenGrafik.KartenfelderAbmessung.x, KartenberechnungenGrafik.KartenfelderAbmessung.y / 5.00),
                                                    PositionExtern  => (PositionExtern.x, PositionExtern.y + 0.40 * KartenberechnungenGrafik.KartenfelderAbmessung.y),
                                                    FarbeExtern     => FarbgebungGrafik.FarbeFlussErmitteln (FlussExtern => KartenfeldFluss));
      end case;
      
   end FlussZeichnen;
   
   
   
   procedure RessourceZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      KartenfeldRessource := LeseWeltkarte.Ressource (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenfeldRessource
      is
         when KartengrundDatentypen.Leer_Ressource_Enum =>
            return;
            
         when others =>
            null;
      end case;
      
      case
        KartenspritesZeichnenGrafik.SpriteGezeichnetKartenfeld (TexturAccessExtern     => EingeleseneTexturenGrafik.KartenressourceAccess (KartenfeldRessource),
                                                                PositionExtern         => PositionExtern,
                                                                DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig)
      is
         when True =>
            null;
            
         when False =>
            ObjekteZeichnenGrafik.KreisZeichnen (RadiusExtern   => KartenberechnungenGrafik.KartenfelderAbmessung.x / 3.00,
                                                 PositionExtern => PositionExtern,
                                                 FarbeExtern    => Sf.Graphics.Color.sfBlack);
      end case;
      
   end RessourceZeichnen;
   
   
   
   procedure WegZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Wegfeld := LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        Wegfeld
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            return;
            
         when others =>
            null;
      end case;
      
      case
        KartenspritesZeichnenGrafik.SpriteGezeichnetKartenfeld (TexturAccessExtern     => EingeleseneTexturenGrafik.WegeAccess (Wegfeld),
                                                                PositionExtern         => PositionExtern,
                                                                DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig)
      is
         when True =>
            null;
            
         when False =>
            ObjekteZeichnenGrafik.RechteckZeichnen (AbmessungExtern => (KartenberechnungenGrafik.KartenfelderAbmessung.x, KartenberechnungenGrafik.KartenfelderAbmessung.y / 2.00),
                                                    PositionExtern  => (PositionExtern.x, PositionExtern.y + 0.80 * KartenberechnungenGrafik.KartenfelderAbmessung.y),
                                                    FarbeExtern     => Sf.Graphics.Color.sfRed);
      end case;
      
   end WegZeichnen;
   
   
   
   procedure VerbesserungZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Verbesserungsfeld := LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern);
      
      case
        Verbesserungsfeld
      is
         when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
            return;
            
         when KartenverbesserungDatentypen.Karten_Verbesserung_Städte_Enum =>
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
        KartenspritesZeichnenGrafik.SpriteGezeichnetKartenfeld (TexturAccessExtern     => EingeleseneTexturenGrafik.VerbesserungenAccess (Verbesserungsfeld),
                                                                PositionExtern         => PositionExtern,
                                                                DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig)
      is
         when True =>
            null;
            
         when False =>
            ObjekteZeichnenGrafik.RechteckZeichnen (AbmessungExtern => (KartenberechnungenGrafik.KartenfelderAbmessung.x / 2.00, KartenberechnungenGrafik.KartenfelderAbmessung.y / 2.00),
                                                    PositionExtern  => PositionExtern,
                                                    FarbeExtern     => Sf.Graphics.Color.sfCyan);
      end case;
      
   end VerbesserungZeichnen;
   
   
   
   procedure AnzeigeEinheit
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      EinheitRasseNummer := EinheitSuchenLogik.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern,
                                                                                  LogikGrafikExtern => False);
      
      case
        EinheitRasseNummer.Nummer
      is
         when EinheitenKonstanten.LeerNummer =>
            return;
            
         when others =>
            EinheitID := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummer);
      end case;
      
      case
        EinheitID
      is
         when EinheitenKonstanten.LeerID =>
            return;
            
         when others =>
            null;
      end case;
            
      if
        EinheitRasseNummer.Rasse = RasseEinheitExtern.Rasse
        and
          (EinheitRasseNummer.Nummer = RasseEinheitExtern.Nummer
           or
             True = EinheitSuchenLogik.TransporterladungSuchen (TransporterExtern   => EinheitRasseNummer,
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
        KartenspritesZeichnenGrafik.SpriteGezeichnetKartenfeld (TexturAccessExtern     => EingeleseneTexturenGrafik.EinheitenAccess (RasseEinheitExtern.Rasse, EinheitID),
                                                                PositionExtern         => PositionExtern,
                                                                DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig)
      is
         when True =>
            null;
            
         when others =>
            ObjekteZeichnenGrafik.PolygonZeichnen (RadiusExtern      => KartenberechnungenGrafik.KartenfelderAbmessung.x / 2.80,
                                                   PositionExtern    => PositionExtern,
                                                   AnzahlEckenExtern => 4,
                                                   FarbeExtern       => RasseneinstellungenGrafik.RassenfarbenRahmen (EinheitRasseNummer.Rasse));
      end case;
      
   end AnzeigeEinheit;
   
   
   
   procedure AnzeigeFeldbesitzer
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      AktuelleRasse := LeseWeltkarte.RasseBelegtGrund (KoordinatenExtern => KoordinatenExtern);
      
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
      
      ObjekteZeichnenGrafik.RahmenteilZeichnen (PositionExtern => PositionExtern,
                                                FarbeExtern    => RasseneinstellungenGrafik.Rassenfarben (RasseExtern),
                                                GrößeExtern    => KartenberechnungenGrafik.KartenfelderAbmessung);
      
      UmgebungSchleife:
      for UmgebungSchleifenwert in UmgebungArray'Range loop
         
         KartenWertRahmen := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                         ÄnderungExtern    => Umgebung (UmgebungSchleifenwert),
                                                                                                         LogikGrafikExtern => False);
               
         if
           KartenWertRahmen.XAchse = KartenKonstanten.LeerXAchse
         then
            RahmenZeichnen (WelcheRichtungExtern => UmgebungSchleifenwert,
                            PositionExtern       => PositionExtern,
                            RasseExtern          => RasseExtern);
                     
         elsif
           RasseExtern /= LeseWeltkarte.RasseBelegtGrund (KoordinatenExtern => KartenWertRahmen)
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
     (WelcheRichtungExtern : in KartenDatentypen.Himmelsrichtungen_Enum;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
            
      case
        WelcheRichtungExtern
      is
         when KartenDatentypen.Norden_Enum =>
            Rahmengröße := (KartenberechnungenGrafik.KartenfelderAbmessung.x, DickeRahmen);
            Rahmenposition := PositionExtern;
         
         when KartenDatentypen.Westen_Enum =>
            Rahmengröße := (DickeRahmen, KartenberechnungenGrafik.KartenfelderAbmessung.y);
            Rahmenposition := PositionExtern;
         
         when KartenDatentypen.Osten_Enum =>
            Rahmengröße := (DickeRahmen, KartenberechnungenGrafik.KartenfelderAbmessung.y);
            Rahmenposition := (PositionExtern.x + KartenberechnungenGrafik.KartenfelderAbmessung.x - DickeRahmen, PositionExtern.y);
         
         when KartenDatentypen.Süden_Enum =>
            Rahmengröße := (KartenberechnungenGrafik.KartenfelderAbmessung.x, DickeRahmen);
            Rahmenposition := (PositionExtern.x, PositionExtern.y + KartenberechnungenGrafik.KartenfelderAbmessung.y - DickeRahmen);
      end case;
      
      ObjekteZeichnenGrafik.RahmenteilZeichnen (PositionExtern => Rahmenposition,
                                                FarbeExtern    => RasseneinstellungenGrafik.RassenfarbenRahmen (RasseExtern),
                                                GrößeExtern    => Rahmengröße);
      
   end RahmenZeichnen;
   
   
   
   procedure StadtnameAnzeigen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
            
      StadtRasseNummer := StadtSuchenLogik.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern);
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteAccess,
                                         str  => To_Wide_Wide_String (Source => LeseStadtGebaut.Name (StadtRasseNummerExtern => StadtRasseNummer)));
      
      Sf.Graphics.Text.setScale (text  => TextaccessVariablen.KarteAccess,
                                 scale => (0.70, 0.70));
      
      Textposition.x := PositionExtern.x - TextberechnungenBreiteGrafik.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.KarteAccess) + 0.50 * KartenberechnungenGrafik.KartenfelderAbmessung.x;
      Textposition.y := PositionExtern.y - TextberechnungenHoeheGrafik.ZeilenabstandVariabel;
      
      -- Später noch einen Rahmen um den Namen bauen. äöü
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteAccess,
                                    position => Textposition);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessVariablen.KarteAccess);
      
   end StadtnameAnzeigen;

end WeltkarteZeichnenGrafik;
