pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics;
with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;
with Sf.Graphics.Color;

with KartenRecords; use KartenRecords;
with EinheitenDatentypen; use EinheitenDatentypen;
with KartengrundDatentypen; use KartengrundDatentypen;
with KartenVerbesserungDatentypen; use KartenVerbesserungDatentypen;
with EinheitenKonstanten;
with KartenKonstanten;
with TextaccessVariablen;
with ZeitKonstanten;
with GrafikRecordKonstanten;
with Views;

with LeseKarten;
with LeseEinheitenGebaut;
with LeseStadtGebaut;

with Kartenkoordinatenberechnungssystem;
with EinheitSuchen;
with StadtSuchen;
with BerechnungenKarteSFML;
with ObjekteZeichnenSFML;
with GrafikEinstellungenSFML;
with EingeleseneTexturenSFML;
with KartenspritesZeichnenSFML;
with FarbgebungSFML;
with TextberechnungenBreiteSFML;
with RasseneinstellungenSFML;
with ViewsEinstellenSFML;
with TextberechnungenHoeheSFML;

package body WeltkarteSFML is
   
   procedure Weltkarte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => Views.KartenviewAccess,
                                          GrößeExtern          => (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x, GrafikEinstellungenSFML.AktuelleFensterAuflösung.y),
                                          AnzeigebereichExtern => GrafikRecordKonstanten.KarteAnzeigebereich);
      
      SichtbereichAnfangEnde := BerechnungenKarteSFML.SichtbereichKarteBerechnen (RasseExtern => EinheitRasseNummerExtern.Rasse);
      
      YMultiplikator := 0.00;
      CursorKoordinatenAlt := SpielVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).KoordinatenAlt;
            
      YAchseSchleife:
      for YAchseSchleifenwert in SichtbereichAnfangEnde (1) .. SichtbereichAnfangEnde (2) loop
         
         XMultiplikator := 0.00;
         
         XAchseSchleife:
         for XAchseSchleifenwert in SichtbereichAnfangEnde (3) .. SichtbereichAnfangEnde (4) loop
            
            KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => CursorKoordinatenAlt,
                                                                                                 ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                 LogikGrafikExtern => False);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              True = LeseKarten.Sichtbar (KoordinatenExtern => KartenWert,
                                          RasseExtern       => EinheitRasseNummerExtern.Rasse)
            then
               -- Die Position durchzureichen bedeutet auch gleichzeitig den aktuellen Multiplikator mit durchzureichen!
               Position.x := XMultiplikator * BerechnungenKarteSFML.KartenfelderAbmessung.x;
               Position.y := YMultiplikator * BerechnungenKarteSFML.KartenfelderAbmessung.y;
               
               IstSichtbar (KoordinatenExtern  => KartenWert,
                            RasseEinheitExtern => EinheitRasseNummerExtern,
                            PositionExtern     => Position);
               
            else
               null;
            end if;
            
            XMultiplikator := XMultiplikator + 1.00;
                          
         end loop XAchseSchleife;
         
         YMultiplikator := YMultiplikator + 1.00;
         
      end loop YAchseSchleife;
            
   end Weltkarte;
   
   
   
   procedure IstSichtbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
            
      -- Landschaft
      KartenfeldZeichnen (KoordinatenExtern => KoordinatenExtern,
                          PositionExtern    => PositionExtern);
      
      RessourceZeichnen (KoordinatenExtern => KoordinatenExtern,
                         PositionExtern    => PositionExtern);
      
      FlussZeichnen (KoordinatenExtern => KoordinatenExtern,
                     PositionExtern    => PositionExtern);
      
      WegZeichnen (KoordinatenExtern => KoordinatenExtern,
                   PositionExtern    => PositionExtern);
      
      VerbesserungZeichnen (KoordinatenExtern => KoordinatenExtern,
                            PositionExtern    => PositionExtern);
      -- Landschaft
      
      
      
      AnzeigeEinheit (KoordinatenExtern  => KoordinatenExtern,
                      RasseEinheitExtern => RasseEinheitExtern,
                      PositionExtern     => PositionExtern);
      
      AnzeigeFeldbesitzer (KoordinatenExtern => KoordinatenExtern,
                           PositionExtern    => PositionExtern);
                  
   end IstSichtbar;
   
   
   
   procedure KartenfeldZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      AktuellerKartengrund := LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern);
      BasisKartengrund := LeseKarten.BasisGrund (KoordinatenExtern => KoordinatenExtern);
      
      if
        AktuellerKartengrund = BasisKartengrund
      then
         null;
         
      else
         case
           KartenspritesZeichnenSFML.SpriteGezeichnetKartenfeld (SpriteAccesExtern  => SpriteAccess,
                                                                 TexturAccessExtern => EingeleseneTexturenSFML.KartenfelderAccess (BasisKartengrund),
                                                                 PositionExtern     => PositionExtern)
         is
            when True =>
               null;
            
            when False =>
               ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => BerechnungenKarteSFML.KartenfelderAbmessung,
                                                     PositionExtern       => PositionExtern,
                                                     FarbeExtern          => FarbgebungSFML.FarbeKartenfeldErmitteln (GrundExtern => BasisKartengrund),
                                                     RechteckAccessExtern => RechteckAccess);
         end case;
      end if;
      
      case
        KartenspritesZeichnenSFML.SpriteGezeichnetKartenfeld (SpriteAccesExtern  => SpriteAccess,
                                                              TexturAccessExtern => EingeleseneTexturenSFML.KartenfelderAccess (AktuellerKartengrund),
                                                              PositionExtern     => PositionExtern)
      is
         when True =>
            null;
            
         when False =>
            ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => BerechnungenKarteSFML.KartenfelderAbmessung,
                                                  PositionExtern       => PositionExtern,
                                                  FarbeExtern          => FarbgebungSFML.FarbeKartenfeldErmitteln (GrundExtern => AktuellerKartengrund),
                                                  RechteckAccessExtern => RechteckAccess);
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
        KartenspritesZeichnenSFML.SpriteGezeichnetKartenfeld (SpriteAccesExtern  => SpriteAccess,
                                                              TexturAccessExtern => EingeleseneTexturenSFML.KartenflussAccess (KartenfeldFluss),
                                                              PositionExtern     => PositionExtern)
      is
         when True =>
            null;
            
         when False =>
            ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (BerechnungenKarteSFML.KartenfelderAbmessung.x, BerechnungenKarteSFML.KartenfelderAbmessung.y / 5.00),
                                                  PositionExtern       => (PositionExtern.x, PositionExtern.y + 0.40 * BerechnungenKarteSFML.KartenfelderAbmessung.y),
                                                  FarbeExtern          => FarbgebungSFML.FarbeFlussErmitteln (FlussExtern => KartenfeldFluss),
                                                  RechteckAccessExtern => RechteckAccess);
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
        KartenspritesZeichnenSFML.SpriteGezeichnetKartenfeld (SpriteAccesExtern  => SpriteAccess,
                                                              TexturAccessExtern => EingeleseneTexturenSFML.KartenressourceAccess (KartenfeldRessource),
                                                              PositionExtern     => PositionExtern)
      is
         when True =>
            null;
            
         when False =>
            ObjekteZeichnenSFML.KreisZeichnen (RadiusExtern      => BerechnungenKarteSFML.KartenfelderAbmessung.x / 3.00,
                                               PositionExtern    => PositionExtern,
                                               FarbeExtern       => Sf.Graphics.Color.sfBlack,
                                               KreisAccessExtern => KreisAccess);
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
        KartenspritesZeichnenSFML.SpriteGezeichnetKartenfeld (SpriteAccesExtern  => SpriteAccess,
                                                              TexturAccessExtern => EingeleseneTexturenSFML.WegeAccess (Wegfeld),
                                                              PositionExtern     => PositionExtern)
      is
         when True =>
            null;
            
         when False =>
            ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (BerechnungenKarteSFML.KartenfelderAbmessung.x, BerechnungenKarteSFML.KartenfelderAbmessung.y / 2.00),
                                                  PositionExtern       => (PositionExtern.x, PositionExtern.y + 0.80 * BerechnungenKarteSFML.KartenfelderAbmessung.y),
                                                  FarbeExtern          => Sf.Graphics.Color.sfRed,
                                                  RechteckAccessExtern => RechteckAccess);
      end case;
      
   end WegZeichnen;
   
   
   
   procedure VerbesserungZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Verbesserungsfeld := LeseKarten.Verbesserung (KoordinatenExtern => KoordinatenExtern);
      
      case
        Verbesserungsfeld
      is
         when KartenVerbesserungDatentypen.Leer_Verbesserung_Enum =>
            return;
            
         when KartenVerbesserungDatentypen.Karten_Verbesserung_Städte_Enum =>
            StadtnameAnzeigen (KoordinatenExtern => KoordinatenExtern,
                               PositionExtern    => PositionExtern);
            
         when others =>
            null;
      end case;
      
      case
        KartenspritesZeichnenSFML.SpriteGezeichnetKartenfeld (SpriteAccesExtern  => SpriteAccess,
                                                              TexturAccessExtern => EingeleseneTexturenSFML.VerbesserungenAccess (Verbesserungsfeld),
                                                              PositionExtern     => PositionExtern)
      is
         when True =>
            null;
            
         when False =>
            ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.00, BerechnungenKarteSFML.KartenfelderAbmessung.y / 2.00),
                                                  PositionExtern       => PositionExtern,
                                                  FarbeExtern          => Sf.Graphics.Color.sfCyan,
                                                  RechteckAccessExtern => RechteckAccess);
      end case;
      
   end VerbesserungZeichnen;
   
   
   
   procedure AnzeigeEinheit
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      EinheitRasseNummer := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern);
      
      if
        EinheitRasseNummer.Nummer = EinheitenKonstanten.LeerNummer
      then
         return;
      
      elsif
        LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummer) /= EinheitenKonstanten.LeerWirdTransportiert
        and
          (EinheitRasseNummer.Rasse /= RasseEinheitExtern.Rasse
           or
             EinheitRasseNummer.Nummer /= RasseEinheitExtern.Nummer)
      then
         EinheitRasseNummer.Nummer := LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummer);
         
      else
         null;
      end if;
      
      EinheitID := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummer);
      
      if
        EinheitRasseNummer.Rasse = RasseEinheitExtern.Rasse
        and
          EinheitRasseNummer.Nummer = RasseEinheitExtern.Nummer
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
               if
                 True = KartenspritesZeichnenSFML.SpriteGezeichnetKartenfeld (SpriteAccesExtern  => SpriteAccess,
                                                                              TexturAccessExtern => EingeleseneTexturenSFML.EinheitenAccess (RasseEinheitExtern.Rasse, EinheitID),
                                                                              PositionExtern     => PositionExtern)
               then
                  null;
                  
               else
                  ObjekteZeichnenSFML.PolygonZeichnen (RadiusExtern        => BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.80,
                                                       PositionExtern      => PositionExtern,
                                                       AnzahlEckenExtern   => 4,
                                                       FarbeExtern         => RasseneinstellungenSFML.RassenFarbenRahmen (EinheitRasseNummer.Rasse),
                                                       PolygonAccessExtern => PolygonAccess);
               end if;
               
            when False =>
               return;
         end case;
         
      else
         if
           True = KartenspritesZeichnenSFML.SpriteGezeichnetKartenfeld (SpriteAccesExtern  => SpriteAccess,
                                                                        TexturAccessExtern => EingeleseneTexturenSFML.EinheitenAccess (RasseEinheitExtern.Rasse, EinheitID),
                                                                        PositionExtern     => PositionExtern)
         then
            null;
            
         else
            ObjekteZeichnenSFML.PolygonZeichnen (RadiusExtern        => BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.80,
                                                 PositionExtern      => PositionExtern,
                                                 AnzahlEckenExtern   => 4,
                                                 FarbeExtern         => RasseneinstellungenSFML.RassenFarbenRahmen (EinheitRasseNummer.Rasse),
                                                 PolygonAccessExtern => PolygonAccess);
         end if;
      end if;
      
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
      
      Sf.Graphics.RectangleShape.setSize (shape => RechteckBelegtesFeldAccess,
                                          size  => BerechnungenKarteSFML.KartenfelderAbmessung);
      Sf.Graphics.RectangleShape.setPosition (shape    => RechteckBelegtesFeldAccess,
                                              position => PositionExtern);
      Sf.Graphics.RectangleShape.setFillColor (shape => RechteckBelegtesFeldAccess,
                                               color => RasseneinstellungenSFML.RassenFarben (RasseExtern));
      
      Sf.Graphics.RenderWindow.drawRectangleShape (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                   object       => RechteckBelegtesFeldAccess);
      
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
      
      Sf.Graphics.RectangleShape.setFillColor (shape => RechteckRahmenAccess,
                                               color => RasseneinstellungenSFML.RassenFarbenRahmen (RasseExtern));
      
      case
        WelcheRichtungExtern
      is
         when Norden =>
            Sf.Graphics.RectangleShape.setSize (shape => RechteckRahmenAccess,
                                                size  => (BerechnungenKarteSFML.KartenfelderAbmessung.x, DickeRahmen));
            Sf.Graphics.RectangleShape.setPosition (shape    => RechteckRahmenAccess,
                                                    position => PositionExtern);
         
         when Westen =>
            Sf.Graphics.RectangleShape.setSize (shape => RechteckRahmenAccess,
                                                size  => (DickeRahmen, BerechnungenKarteSFML.KartenfelderAbmessung.y));
            Sf.Graphics.RectangleShape.setPosition (shape    => RechteckRahmenAccess,
                                                    position => PositionExtern);
         
         when Osten =>
            Sf.Graphics.RectangleShape.setSize (shape => RechteckRahmenAccess,
                                                size  => (DickeRahmen, BerechnungenKarteSFML.KartenfelderAbmessung.y));
            Sf.Graphics.RectangleShape.setPosition (shape    => RechteckRahmenAccess,
                                                    position => (PositionExtern.x + BerechnungenKarteSFML.KartenfelderAbmessung.x - DickeRahmen, PositionExtern.y));
         
         when Süden =>
            Sf.Graphics.RectangleShape.setSize (shape => RechteckRahmenAccess,
                                                size  => (BerechnungenKarteSFML.KartenfelderAbmessung.x, DickeRahmen));
            Sf.Graphics.RectangleShape.setPosition (shape    => RechteckRahmenAccess,
                                                    position => (PositionExtern.x, PositionExtern.y + BerechnungenKarteSFML.KartenfelderAbmessung.y - DickeRahmen));
      end case;
            
      Sf.Graphics.RenderWindow.drawRectangleShape (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                   object       => RechteckRahmenAccess);
      
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

end WeltkarteSFML;
