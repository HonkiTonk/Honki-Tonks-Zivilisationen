pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics;
with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with KartenRecords; use KartenRecords;
with EinheitenDatentypen; use EinheitenDatentypen;
with KartengrundDatentypen; use KartengrundDatentypen;
with KartenVerbesserungDatentypen; use KartenVerbesserungDatentypen;
with StadtDatentypen; use StadtDatentypen;
with EinheitenKonstanten;
with KartenKonstanten;
with StadtKonstanten;
with TextaccessVariablen;

with LeseKarten;
with LeseEinheitenGebaut;
with LeseStadtGebaut;

with Kartenkoordinatenberechnungssystem;
with EinheitSuchen;
with StadtSuchen;
with KarteInformationenSFML;
with BerechnungenKarteSFML;
with ObjekteZeichnenSFML;
with GrafikEinstellungenSFML;
with EingeleseneTexturenSFML;
with KartenspritesZeichnenSFML;
with FarbgebungSFML;
with TextberechnungenBreiteSFML;
with Warnung;

package body KarteSFML is
   
   procedure KarteAnzeigen
     (RasseEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      Sichtbarkeit (RasseEinheitExtern => RasseEinheitExtern);
      
      -- Die Einheit auch mitübergeben? Wäre das hier überhaupt sinnvoll? Müsste ja gehen und je nach Belegung der Einheit den Check auf eine Einheit durchführen oder nicht. äöü
      KarteInformationenSFML.KarteInformationenSFML (RasseExtern => RasseEinheitExtern.Rasse);
      
   end KarteAnzeigen;
   
   

   procedure Sichtbarkeit
     (RasseEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
        
      SichtbereichAnfangEnde := BerechnungenKarteSFML.SichtbereichKarteBerechnen (RasseExtern => RasseEinheitExtern.Rasse);
      
      YMultiplikator := 0.00;
      CursorKoordinatenAlt := SpielVariablen.CursorImSpiel (RasseEinheitExtern.Rasse).KoordinatenAlt;
            
      YAchseSchleife:
      for YAchseSchleifenwert in SichtbereichAnfangEnde (1) .. SichtbereichAnfangEnde (2) loop
         
         XMultiplikator := 0.00;
         
         XAchseSchleife:
         for XAchseSchleifenwert in SichtbereichAnfangEnde (3) .. SichtbereichAnfangEnde (4) loop
            
            KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => CursorKoordinatenAlt,
                                                                                                 ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                 LogikGrafikExtern => False);
            
            -- Die Position durchzureichen bedeutet auch gleichzeitig den aktuellen Multiplikator mit durchzureichen!
            Position.x := XMultiplikator * BerechnungenKarteSFML.KartenfelderAbmessung.x;
            Position.y := YMultiplikator * BerechnungenKarteSFML.KartenfelderAbmessung.y;
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              LeseKarten.Sichtbar (KoordinatenExtern => KartenWert,
                                   RasseExtern       => RasseEinheitExtern.Rasse)
              = True
            then
               IstSichtbar (KoordinatenExtern  => KartenWert,
                            RasseEinheitExtern => RasseEinheitExtern,
                            PositionExtern     => Position);
               
            else
               -- Ist das Zeichnen von schwarzen Felder notwendig? Immerhin wird ja vorher das Fenster immer geleert und auf Schwarz gesetzt.
               -- Schwarze Felder zu zeichnen könnte fehlerhafte Größenverhältnisse überdecken, lieber lassen.
               null;
            end if;
            
            XMultiplikator := XMultiplikator + 1.00;
                          
         end loop XAchseSchleife;
         
         YMultiplikator := YMultiplikator + 1.00;
         
      end loop YAchseSchleife;
      
      YMultiplikator := 0.00;
            
      YAchseStadtnameSchleife:
      for YAchseStadtnameSchleifenwert in SichtbereichAnfangEnde (1) .. SichtbereichAnfangEnde (2) loop
         
         XMultiplikator := 0.00;
         
         XAchseStadtnameSchleife:
         for XAchseStadtnameSchleifenwert in SichtbereichAnfangEnde (3) .. SichtbereichAnfangEnde (4) loop
            
            KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => CursorKoordinatenAlt,
                                                                                                 ÄnderungExtern    => (0, YAchseStadtnameSchleifenwert, XAchseStadtnameSchleifenwert),
                                                                                                 LogikGrafikExtern => False);
            
            -- Die Position durchzureichen bedeutet auch gleichzeitig den aktuellen Multiplikator mit durchzureichen!
            Position.x := XMultiplikator * BerechnungenKarteSFML.KartenfelderAbmessung.x;
            Position.y := YMultiplikator * BerechnungenKarteSFML.KartenfelderAbmessung.y;
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              LeseKarten.Sichtbar (KoordinatenExtern => KartenWert,
                                   RasseExtern       => RasseEinheitExtern.Rasse)
              = True
            then
               StadtnameAnzeigen (KoordinatenExtern => KartenWert,
                                  PositionExtern    => Position);
               
            else
               -- Ist das Zeichnen von schwarzen Felder notwendig? Immerhin wird ja vorher das Fenster immer geleert und auf Schwarz gesetzt.
               -- Schwarze Felder zu zeichnen könnte fehlerhafte Größenverhältnisse überdecken, lieber lassen.
               null;
            end if;
            
            XMultiplikator := XMultiplikator + 1.00;
                          
         end loop XAchseStadtnameSchleife;
         
         YMultiplikator := YMultiplikator + 1.00;
         
      end loop YAchseStadtnameSchleife;
      
   end Sichtbarkeit;
   
   
   
   procedure IstSichtbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      -- Über den Kartenfeldern kommen die Kartenressourcen.
      -- Über den Kartenressourcen kommen die Kartenverbesserungen (Städte sind jetzt Teil der Verbesserungen).
      -- Über die Städte kommen die nicht Transporteinheiten.
      -- Über den nicht Transporteinheiten kommen die Transporteinheiten.
      -- Über den Transporteinheiten kommt der Cursor.
      
      AnzeigeLandschaft (KoordinatenExtern => KoordinatenExtern,
                         PositionExtern    => PositionExtern);
            
      AnzeigeEinheit (KoordinatenExtern  => KoordinatenExtern,
                      RasseEinheitExtern => RasseEinheitExtern,
                      PositionExtern     => PositionExtern);
      
      AnzeigeFeldbesitzer (KoordinatenExtern => KoordinatenExtern,
                           PositionExtern    => PositionExtern);
            
      case
        SpielVariablen.Debug.Allgemeines
      is
         when True =>
            AnzeigeCursor (KoordinatenExtern => KoordinatenExtern,
                           RasseExtern       => RasseEinheitExtern.Rasse,
                           PositionExtern    => PositionExtern);
            
         when False =>
            null;
      end case;
                  
   end IstSichtbar;
   
   
   
   procedure AnzeigeLandschaft
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
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
      
   end AnzeigeLandschaft;
   
   
   
   procedure KartenfeldZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      ------------------------------------ Noch die Grafiken anpassen damit diese Anzeige hier auch Sinn ergibt.
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
      
      -------------------------- Kan man das auch noch an anderen Stellen (Dateien) verwenden? Wahrscheinlich ja.
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
   
   
   
   -- Verbesserung und Stadt zeichnen zusammenführen, müsste mit dem neuen System gehen. äöü
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
           ZeitZwei - ZeitEins > BlinkIntervall
         then
            AusgewählteEinheitAnzeigen := not AusgewählteEinheitAnzeigen;
            ZeitEins := Clock;
            ZeitZwei := Clock;
            
         else
            ZeitZwei := Clock;
         end if;
         
         case
           AusgewählteEinheitAnzeigen
         is
            when True =>
               if
                 KartenspritesZeichnenSFML.SpriteGezeichnetKartenfeld (SpriteAccesExtern  => SpriteAccess,
                                                                       TexturAccessExtern => EingeleseneTexturenSFML.EinheitenAccess (RasseEinheitExtern.Rasse, EinheitID),
                                                                       PositionExtern     => PositionExtern)
                 = True
               then
                  null;
                  
               else
                  ObjekteZeichnenSFML.PolygonZeichnen (RadiusExtern        => BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.80,
                                                       PositionExtern      => PositionExtern,
                                                       AnzahlEckenExtern   => 4,
                                                       FarbeExtern         => GrafikEinstellungenSFML.RassenFarbenRahmen (EinheitRasseNummer.Rasse),
                                                       PolygonAccessExtern => PolygonAccess);
               end if;
               
            when False =>
               return;
         end case;
         
      else
         if
           KartenspritesZeichnenSFML.SpriteGezeichnetKartenfeld (SpriteAccesExtern  => SpriteAccess,
                                                                 TexturAccessExtern => EingeleseneTexturenSFML.EinheitenAccess (RasseEinheitExtern.Rasse, EinheitID),
                                                                 PositionExtern     => PositionExtern)
           = True
         then
            null;
            
         else
            ObjekteZeichnenSFML.PolygonZeichnen (RadiusExtern        => BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.80,
                                                 PositionExtern      => PositionExtern,
                                                 AnzahlEckenExtern   => 4,
                                                 FarbeExtern         => GrafikEinstellungenSFML.RassenFarbenRahmen (EinheitRasseNummer.Rasse),
                                                 PolygonAccessExtern => PolygonAccess);
            Warnung.GrafikWarnung (WarnmeldungExtern => "KarteSFML.AnzeigeEinheit - Sprite nicht vorhanden: " & RasseEinheitExtern.Rasse'Wide_Wide_Image & " - " & EinheitID'Wide_Wide_Image);
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
                                               color => GrafikEinstellungenSFML.RassenFarben (RasseExtern));
      
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
                                               color => GrafikEinstellungenSFML.RassenFarbenRahmen (RasseExtern));
      
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
      
      KartenWertStadtname := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                    ÄnderungExtern    => (0, -1, 0),
                                                                                                    LogikGrafikExtern => False);
      
      case
        KartenWertStadtname.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            return;
            
         when others =>
            StadtRasseNummer := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => KartenWertStadtname);
            
            if
              StadtRasseNummer.Nummer = StadtKonstanten.LeerNummer
            then
               return;
               
            else
               null;
            end if;
      end case;
      
      -- Wenn ich das ganze als View anlege, die Städtenamen da rein schreibe und den dann am Schluss anzeige, müsste das nicht gehen? äöü
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteAccess,
                                         str  => To_Wide_Wide_String (Source => LeseStadtGebaut.Name (StadtRasseNummerExtern => StadtRasseNummer)));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.KarteAccess,
                                    position => (PositionExtern.x - TextberechnungenBreiteSFML.HalbeBreiteBerechnen (TextAccessExtern => TextaccessVariablen.KarteAccess), PositionExtern.y));
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.KarteAccess);
      
   end StadtnameAnzeigen;
   
   
   
   procedure AnzeigeCursor
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      if
        KoordinatenExtern = SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell
      then
         ObjekteZeichnenSFML.PolygonZeichnen (RadiusExtern        => BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.00,
                                              PositionExtern      => PositionExtern,
                                              AnzahlEckenExtern   => 3,
                                              FarbeExtern         => Sf.Graphics.Color.sfRed,
                                              PolygonAccessExtern => PolygonAccess);
         
      else
         null;
      end if;
      
   end AnzeigeCursor;

end KarteSFML;
