pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics; use Sf.Graphics;
with Sf.Graphics.RenderWindow;

with KartenRecords; use KartenRecords;
with KartenDatentypen; use KartenDatentypen;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with EinheitenKonstanten;
with KartenKonstanten;
with StadtKonstanten;

with LeseKarten;
with LeseEinheitenGebaut;
with LeseStadtGebaut;

with KartePositionPruefen;
with EinheitSuchen;
with StadtSuchen;
with KarteInformationenSFML;
with BerechnungenKarteSFML;
with Fehler;
with ObjekteZeichnenSFML;
with GrafikEinstellungenSFML;
with TextAllgemeinSFML;
with EingeleseneTexturenSFML;

package body KarteSFML is
   
   procedure KarteAnzeigen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Sichtbarkeit (RasseExtern => RasseExtern);
      
      KarteInformationenSFML.KarteInformationenSFML (RasseExtern => RasseExtern);
      
   end KarteAnzeigen;
   
   

   procedure Sichtbarkeit
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
        
      SichtbereichAnfangEnde := BerechnungenKarteSFML.SichtbereichKarteBerechnen (RasseExtern => RasseExtern);
      
      YMultiplikator := 0.00;
            
      YAchseSchleife:
      for YAchseSchleifenwert in SichtbereichAnfangEnde (1) .. SichtbereichAnfangEnde (2) loop
         
         XMultiplikator := 0.00;
         
         XAchseSchleife:
         for XAchseSchleifenwert in SichtbereichAnfangEnde (3) .. SichtbereichAnfangEnde (4) loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt,
                                                                        ÄnderungExtern   => (0, YAchseSchleifenwert, XAchseSchleifenwert));
            
            -- Die Position durchzureichen bedeutet auch gleichzeitig den aktuellen Multiplikator mit durchzureichen!
            Position.x := XMultiplikator * BerechnungenKarteSFML.KartenfelderAbmessung.x;
            Position.y := YMultiplikator * BerechnungenKarteSFML.KartenfelderAbmessung.y;
            
            case
              LeseKarten.Sichtbar (PositionExtern => KartenWert,
                                   RasseExtern    => RasseExtern)
            is
               when True =>
                  IstSichtbar (KoordinatenExtern => KartenWert,
                               RasseExtern       => RasseExtern,
                               PositionExtern    => Position);
                        
               when False =>
                  -- Ist das Zeichnen von schwarzen Felder notwendig? Immerhin wird ja vorher das Fenster immer geleert und auf Schwarz gesetzt.
                  null;
            end case;
            
            XMultiplikator := XMultiplikator + 1.00;
                          
         end loop XAchseSchleife;
         
         YMultiplikator := YMultiplikator + 1.00;
         
      end loop YAchseSchleife;
      
   end Sichtbarkeit;
   
   
   
   procedure IstSichtbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      -- Über den Kartenfeldern kommen die Kartenressourcen.
      -- Über den Kartenressourcen kommen die Kartenverbesserungen.
      -- Über die Kartenverbesserungen kommen die Städte.
      -- Über die Städte kommen die nicht Transporteinheiten.
      -- Über den nicht Transporteinheiten kommen die Transporteinheiten.
      -- Über den Transporteinheiten kommt der Cursor.
      
      AnzeigeLandschaft (KoordinatenExtern => KoordinatenExtern,
                         PositionExtern    => PositionExtern);
            
      AnzeigeStadt (KoordinatenExtern => KoordinatenExtern,
                    RasseExtern       => RasseExtern,
                    PositionExtern    => PositionExtern);
            
      AnzeigeEinheit (KoordinatenExtern => KoordinatenExtern,
                      PositionExtern    => PositionExtern);
      
      AnzeigeFeldbesitzer (KoordinatenExtern => KoordinatenExtern,
                           PositionExtern    => PositionExtern);
            
      case
        GlobaleVariablen.Debug
      is
         when True =>
            AnzeigeCursor (KoordinatenExtern => KoordinatenExtern,
                           RasseExtern       => RasseExtern,
                           PositionExtern    => PositionExtern);
            
         when False =>
            null;
      end case;
                  
   end IstSichtbar;
   
   
   
   procedure AnzeigeLandschaft
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      KartenfeldZeichnen (KoordinatenExtern => KoordinatenExtern,
                          PositionExtern    => PositionExtern);
      
      case
        LeseKarten.Ressource (PositionExtern => KoordinatenExtern)
      is
         when KartenDatentypen.Leer =>
            null;
            
         when others =>
            ObjekteZeichnenSFML.KreisZeichnen (RadiusExtern      => BerechnungenKarteSFML.KartenfelderAbmessung.x / 3.00,
                                               PositionExtern    => PositionExtern,
                                               FarbeExtern       => Sf.Graphics.Color.sfBlack,
                                               KreisAccessExtern => KreisAccess);
      end case;
      
      case
        LeseKarten.Fluss (PositionExtern => KoordinatenExtern)
      is
         when KartenDatentypen.Leer =>
            null;
            
         when others =>
            ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (BerechnungenKarteSFML.KartenfelderAbmessung.x, BerechnungenKarteSFML.KartenfelderAbmessung.y / 5.00),
                                                  PositionExtern       => (PositionExtern.x, PositionExtern.y + 0.40 * BerechnungenKarteSFML.KartenfelderAbmessung.y),
                                                  FarbeExtern          => Sf.Graphics.Color.sfBlue,
                                                  RechteckAccessExtern => RechteckAccess);
      end case;
                  
      case
        LeseKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern)
      is
         when KartenDatentypen.Leer =>
            null;
            
         when others =>
            ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (BerechnungenKarteSFML.KartenfelderAbmessung.x, BerechnungenKarteSFML.KartenfelderAbmessung.y / 2.00),
                                                  PositionExtern       => (PositionExtern.x, PositionExtern.y + 0.80 * BerechnungenKarteSFML.KartenfelderAbmessung.y),
                                                  FarbeExtern          => Sf.Graphics.Color.sfRed,
                                                  RechteckAccessExtern => RechteckAccess);
      end case;
      
      case
        LeseKarten.VerbesserungGebiet (PositionExtern => KoordinatenExtern)
      is
         when KartenDatentypen.Leer =>
            null;
            
         when others =>
            ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.00, BerechnungenKarteSFML.KartenfelderAbmessung.y / 2.00),
                                                  PositionExtern       => PositionExtern,
                                                  FarbeExtern          => Sf.Graphics.Color.sfCyan,
                                                  RechteckAccessExtern => RechteckAccess);
      end case;
      
   end AnzeigeLandschaft;
   
   
   
   procedure KartenfeldZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Kartenfeld := LeseKarten.Grund (PositionExtern => KoordinatenExtern);
      
      if
        Kartenfeld = KartenDatentypen.Flachland
        and
          EingeleseneTexturenSFML.KartenfelderAccess /= null
      then
         -- Sf.Graphics.Sprite.setTexture (sprite  => SpriteAccess,
         --                                texture => EingeleseneTexturenSFML.KartenfelderAccess);
         -- Sf.Graphics.RenderWindow.drawSprite (renderWindow => GrafikEinstellungenSFML.FensterAccess,
         --                                      object       => SpriteAccess);
         -- Sf.Graphics.Sprite.setPosition (sprite   => SpriteAccess,
         --                                 position => PositionExtern);
         -- Sf.Graphics.Sprite.setScale (sprite => SpriteAccess,
         --                              scale  => (1.00, 0.80));
         null;
         
      else
         ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => BerechnungenKarteSFML.KartenfelderAbmessung,
                                               PositionExtern       => PositionExtern,
                                               FarbeExtern          => FarbeKartenfeldErmitteln (GrundExtern => Kartenfeld),
                                               RechteckAccessExtern => RechteckAccess);
      end if;
      
   end KartenfeldZeichnen;
   
   
   
   procedure AnzeigeStadt
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      EinheitStadtRasseNummer := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern);
         
      if
        EinheitStadtRasseNummer.Platznummer = EinheitenKonstanten.LeerNummer
      then
         return;
         
      elsif
        EinheitStadtRasseNummer.Rasse = RasseExtern
      then
         AktuelleFarbe := Sf.Graphics.Color.sfRed;
         
      else
         AktuelleFarbe := Sf.Graphics.Color.sfYellow;
      end if;
      
      case
        LeseStadtGebaut.ID (StadtRasseNummerExtern => EinheitStadtRasseNummer)
      is
         when KartenDatentypen.Eigene_Hauptstadt =>
            ObjekteZeichnenSFML.PolygonZeichnen (RadiusExtern        => BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.00,
                                                 PositionExtern      => PositionExtern,
                                                 AnzahlEckenExtern   => 5,
                                                 FarbeExtern         => AktuelleFarbe,
                                                 PolygonAccessExtern => PolygonAccess);
               
         when KartenDatentypen.Eigene_Stadt =>
            ObjekteZeichnenSFML.PolygonZeichnen (RadiusExtern        => BerechnungenKarteSFML.KartenfelderAbmessung.x / 3.00,
                                                 PositionExtern      => PositionExtern,
                                                 AnzahlEckenExtern   => 6,
                                                 FarbeExtern         => AktuelleFarbe,
                                                 PolygonAccessExtern => PolygonAccess);
               
         when KartenDatentypen.Leer =>
            Fehler.GrafikStopp (FehlermeldungExtern => "KarteSFML.AnzeigeStadt - Vorhandene Stadt ist nicht vorhanden.");
      end case;
      
   end AnzeigeStadt;
   
   
   
   procedure AnzeigeEinheit
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      EinheitStadtRasseNummer := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern);
         
      if
        EinheitStadtRasseNummer.Platznummer = EinheitenKonstanten.LeerNummer
      then
         null;
            
      elsif
        LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitStadtRasseNummer) /= EinheitenKonstanten.LeerWirdTransportiert
      then
         ObjekteZeichnenSFML.PolygonZeichnen (RadiusExtern        => BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.80,
                                              PositionExtern      => PositionExtern,
                                              AnzahlEckenExtern   => 4,
                                              FarbeExtern         => Sf.Graphics.Color.sfYellow,
                                              PolygonAccessExtern => PolygonAccess);
            
      else
         ObjekteZeichnenSFML.PolygonZeichnen (RadiusExtern        => BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.80,
                                              PositionExtern      => PositionExtern,
                                              AnzahlEckenExtern   => 4,
                                              FarbeExtern         => Sf.Graphics.Color.sfYellow,
                                              PolygonAccessExtern => PolygonAccess);
      end if;
      
   end AnzeigeEinheit;
   
   
   
   procedure AnzeigeFeldbesitzer
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      AktuelleRasse := LeseKarten.RasseBelegtGrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        AktuelleRasse
      is
         when SystemKonstanten.LeerRasse =>
            return;
            
         when others =>
            -- Rahmen drumherum ziehen? Die Anzahl der Balken könnte ich durch eine Prüfung der umliegenden Felder festlegen lassen?
            ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => BerechnungenKarteSFML.KartenfelderAbmessung,
                                                  PositionExtern       => PositionExtern,
                                                  FarbeExtern          => GrafikEinstellungenSFML.RassenFarben (AktuelleRasse),
                                                  RechteckAccessExtern => RechteckAccess);
      end case;
      
      RahmenBesetztesFeld (KoordinatenExtern => KoordinatenExtern,
                           PositionExtern    => PositionExtern,
                           RasseExtern       => AktuelleRasse);
      
   end AnzeigeFeldbesitzer;
   
   
   
   procedure RahmenBesetztesFeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
            
      -- Für den Rahmen weniger Transparenz benutzen.
      Sf.Graphics.RectangleShape.setSize (shape => RechteckRahmenAccess,
                                          size  => (BerechnungenKarteSFML.KartenfelderAbmessung.x - 6.00, BerechnungenKarteSFML.KartenfelderAbmessung.y - 6.00));
      Sf.Graphics.RectangleShape.setPosition (shape    => RechteckRahmenAccess,
                                              position => (PositionExtern.x + 3.00, PositionExtern.y + 3.00));
      Sf.Graphics.RectangleShape.setFillColor (shape => RechteckRahmenAccess,
                                               color => Sf.Graphics.Color.sfTransparent);
      Sf.Graphics.RectangleShape.setOutlineColor (shape => RechteckRahmenAccess,
                                                  color => GrafikEinstellungenSFML.RassenFarben (RasseExtern));
      Sf.Graphics.RectangleShape.setOutlineThickness (shape     => RechteckRahmenAccess,
                                                      thickness => 3.00);
      Sf.Graphics.RenderWindow.drawRectangleShape (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                   object       => RechteckRahmenAccess);
      
      KartenWertRahmen := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => KoordinatenExtern,
                                                                        ÄnderungExtern    => (0, -1, 0));
      
      case
        KartenWertRahmen.YAchse
      is
         when KartenKonstanten.LeerYAchse =>
            return;
            
         when others =>
            StadtRasseNummer := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => KartenWertRahmen);
            
            if
              StadtRasseNummer.Platznummer = StadtKonstanten.LeerNummer
            then
               return;
               
            else
               null;
            end if;
      end case;
      
      -- Möglicherweise die Schriftfarbe durch die Rahmenfarbe ersetzen? Die Belegungsfarbe ist auf jeden Fall ungeeignet.
      -- Text wird von den anderen Feldern immer wieder überschrieben. Eventuell ein zweites Mal über die ganzen Felder gehen?
      -- Wenn ich das ganze als View anlege, die Städtenamen da rein schreibe und den dann am Schluss anzeige, müsste das nicht gehen?
      TextAllgemeinSFML.TextAccessEinstellen (TextAccessExtern   => TextAccess,
                                              FontAccessExtern   => GrafikEinstellungenSFML.SchriftartAccess,
                                              SchriftgrößeExtern => GrafikEinstellungenSFML.FensterEinstellungen.Schriftgröße,
                                              FarbeExtern        => GrafikEinstellungenSFML.Schriftfarben.FarbeStandardText);
      
      Sf.Graphics.Text.setUnicodeString (text => TextAccess,
                                         str  => To_Wide_Wide_String (Source => LeseStadtGebaut.Name (StadtRasseNummerExtern => StadtRasseNummer)));
      Sf.Graphics.Text.setPosition (text     => TextAccess,
                                    position => PositionExtern);
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextAccess);
      
   end RahmenBesetztesFeld;
   
   
   
   procedure AnzeigeCursor
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      if
        KoordinatenExtern = GlobaleVariablen.CursorImSpiel (RasseExtern).Position
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
   
   
   
   function FarbeKartenfeldErmitteln
     (GrundExtern : in KartenDatentypen.Karten_Grund_Enum)
      return Sf.Graphics.Color.sfColor
   is begin
      
      case
        GrundExtern
      is
         when KartenDatentypen.Eis | KartenDatentypen.Unterwasser_Eis =>
            return (255, 245, 238, 255);
            
         when KartenDatentypen.Wasser | KartenDatentypen.Unterwasser_Wasser =>
            return (0, 0, 205, 255);
            
         when KartenDatentypen.Flachland =>
            return (100, 160, 60, 255);
            
         when KartenDatentypen.Tundra =>
            return (205, 200, 177, 255);
            
         when KartenDatentypen.Wüste | KartenDatentypen.Sand =>
            return (238, 238, 0, 255);
            
         when KartenDatentypen.Hügel =>
            return (205, 133, 63, 255);
            
         when KartenDatentypen.Gebirge =>
            return (120, 120, 120, 255);
            
         when KartenDatentypen.Wald =>
            return (30, 130, 30, 255);
            
         when KartenDatentypen.Dschungel =>
            return (0, 70, 0, 255);
            
         when KartenDatentypen.Küstengewässer | KartenDatentypen.Unterwasser_Küstengewässer =>
            return (135, 206, 250, 255);
            
         when KartenDatentypen.Sumpf =>
            return (0, 40, 0, 255);

         when KartenDatentypen.Erde =>
            return (139, 69, 19, 255);
            
         when KartenDatentypen.Erdgestein =>
            return (120, 120, 120, 255);
            
         when KartenDatentypen.Lava =>
            return (250, 39, 39, 255);
            
         when KartenDatentypen.Wolken =>
            return (236, 236, 236, 255);
            
         when KartenDatentypen.Weltraum =>
            return (127, 127, 127, 255);
            
         when KartenDatentypen.Gestein =>
            return (87, 87, 87, 255);   
            
         when KartenDatentypen.Planetenkern =>
            return (205, 0, 0, 255);
            
         when KartenDatentypen.Unterwasser_Wald =>
            return (127, 255, 212, 255);
            
         when KartenDatentypen.Korallen =>
            return (255, 114, 86, 255);
                        
         when others =>
            Fehler.GrafikStopp (FehlermeldungExtern => "KarteSFML.FarbeErmitteln - Keine gültige Farbe gefunden.");
            -- return muss hier sein, weil der Kompiler nicht weiß dass der Prozeduraufruf das Programm stoppt.
            return (0, 0, 0, 0);
      end case;
      
   end FarbeKartenfeldErmitteln;

end KarteSFML;
