pragma SPARK_Mode (On);

with Sf.Graphics.RenderWindow;

with KartenRecords; use KartenRecords;
with KartenDatentypen; use KartenDatentypen;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with EinheitenKonstanten;

with LeseKarten;
with LeseEinheitenGebaut;

with KartePositionPruefen;
with EinheitSuchen;
with StadtSuchen;
with KarteInformationenSFML;
with BerechnungenKarteSFML;
with Fehler;
with GrafikEinstellungen;
with AnzeigeEingabe;
with InteraktionTasks;

package body KarteSFML is
   
   procedure KarteAnzeigen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
            
      Sichtbarkeit (InDerStadtExtern => False,
                    RasseExtern      => RasseExtern);
      
      KarteInformationenSFML.KarteInformationenSFML (RasseExtern => RasseExtern);
      
      case
        InteraktionTasks.Eingabe
      is
         when True =>
            AnzeigeEingabe.AnzeigeGanzeZahl;
            
         when False =>
            null;
      end case;
      
   end KarteAnzeigen;
   
   

   procedure Sichtbarkeit
     (InDerStadtExtern : in Boolean;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
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
            
            Position.x := XMultiplikator * BerechnungenKarteSFML.KartenfelderAbmessung.x;
            Position.y := YMultiplikator * BerechnungenKarteSFML.KartenfelderAbmessung.y;
            
            case
              LeseKarten.Sichtbar (PositionExtern => KartenWert,
                                   RasseExtern    => RasseExtern)
            is
               when True =>
                  IstSichtbar (InDerStadtExtern  => InDerStadtExtern,
                               KoordinatenExtern => KartenWert,
                               RasseExtern       => RasseExtern);
                        
               when False =>
                  -- Ist das Zeichnen von schwarzen Felder überhaupt notwendig? Immerhin wird ja vorher das Fenster immer geleert und auf Schwarz gesetzt.
                  
                  -- GrafikAllgemein.RechteckZeichnen (AbmessungExtern => BerechnungenKarteSFML.KartenfelderAbmessung,
                  --                                  PositionExtern  => Position,
                  --                                  FarbeExtern     => Sf.Graphics.Color.sfBlack);
                  
                  if
                    KartenWert = GlobaleVariablen.CursorImSpiel (RasseExtern).Position
                  then
                     PolygonZeichnen (FarbeExtern            => Sf.Graphics.Color.sfBlack,
                                      PositionZeichnenExtern => Position,
                                      RadiusExtern           => BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.00,
                                      AnzahlEckenExtern      => 3);
                     
                  else
                     null;
                  end if;
            end case;
            
            XMultiplikator := XMultiplikator + 1.00;
                          
         end loop XAchseSchleife;
         
         YMultiplikator := YMultiplikator + 1.00;
         
      end loop YAchseSchleife;
      
   end Sichtbarkeit;
   
   
   
   procedure IstSichtbar
     (InDerStadtExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      -- Über den Kartenfeldern kommen die Kartenressourcen.
      -- Über den Kartenressourcen kommen die Kartenverbesserungen.
      -- Über die Kartenverbesserungen kommen die Städte.
      -- Über die Städte kommen die nicht Transporteinheiten.
      -- Über den nicht Transporteinheiten kommen die Transporteinheiten.
      -- Über den Transporteinheiten kommt der Cursor.
      
      AnzeigeLandschaft (KoordinatenExtern => KoordinatenExtern);
            
      AnzeigeStadt (KoordinatenExtern => KoordinatenExtern);
            
      AnzeigeEinheit (KoordinatenExtern => KoordinatenExtern);
            
      AnzeigeCursor (InDerStadtExtern  => InDerStadtExtern,
                     KoordinatenExtern => KoordinatenExtern,
                     RasseExtern       => RasseExtern);
                  
   end IstSichtbar;
   
   
   
   procedure AnzeigeLandschaft
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      KartenfeldZeichnen (FarbeExtern            => FarbeErmitteln (GrundExtern => LeseKarten.Grund (PositionExtern => KartenWert)),
                          PositionZeichnenExtern => Position,
                          AbmessungExtern        => BerechnungenKarteSFML.KartenfelderAbmessung);
            
      -- Mal Farben für die einzelnen Objekte einbauen.
      case
        LeseKarten.Ressource (PositionExtern => KoordinatenExtern)
      is
         when KartenDatentypen.Leer =>
            null;
            
         when others =>
            KreisZeichnen (FarbeExtern            => Sf.Graphics.Color.sfBlack,
                           PositionZeichnenExtern => Position,
                           RadiusExtern           => BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.00);
      end case;
      
      case
        LeseKarten.Fluss (PositionExtern => KoordinatenExtern)
      is
         when KartenDatentypen.Leer =>
            null;
            
         when others =>
            KartenfeldZeichnen (FarbeExtern            => Sf.Graphics.Color.sfBlue,
                                PositionZeichnenExtern => (Position.x, Position.y + 0.40 * BerechnungenKarteSFML.KartenfelderAbmessung.y),
                                AbmessungExtern        => (BerechnungenKarteSFML.KartenfelderAbmessung.x, BerechnungenKarteSFML.KartenfelderAbmessung.y / 5.00));
      end case;
                  
      case
        LeseKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern)
      is
         when KartenDatentypen.Leer =>
            null;
            
         when others =>
            KartenfeldZeichnen (FarbeExtern            => Sf.Graphics.Color.sfRed,
                                PositionZeichnenExtern => (Position.x, Position.y + 0.80 * BerechnungenKarteSFML.KartenfelderAbmessung.y),
                                AbmessungExtern        => (BerechnungenKarteSFML.KartenfelderAbmessung.x, BerechnungenKarteSFML.KartenfelderAbmessung.y / 2.00));
      end case;
      
      case
        LeseKarten.VerbesserungGebiet (PositionExtern => KoordinatenExtern)
      is
         when KartenDatentypen.Leer =>
            null;
            
         when others =>
            KartenfeldZeichnen (FarbeExtern            => Sf.Graphics.Color.sfCyan,
                                PositionZeichnenExtern => Position,
                                AbmessungExtern        => (BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.00, BerechnungenKarteSFML.KartenfelderAbmessung.y / 2.00));
      end case;
      
   end AnzeigeLandschaft;
   
   
   
   procedure KartenfeldZeichnen
     (FarbeExtern : in Sf.Graphics.Color.sfColor;
      PositionZeichnenExtern : in Sf.System.Vector2.sfVector2f;
      AbmessungExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      if
        AbmessungExtern.y = 0.00
        or
          AbmessungExtern.x = 0.00
      then
         Fehler.GrafikStopp (FehlermeldungExtern => "GrafikAllgemein.RechteckZeichnen - Rechteck ist ein Strich");
         
      elsif
        AbmessungExtern.y > Float (GrafikEinstellungen.AktuelleFensterEinstellungen.AktuelleFensterHöhe)
        or
          AbmessungExtern.x > Float (GrafikEinstellungen.AktuelleFensterEinstellungen.AktuelleFensterBreite)
      then
         Fehler.GrafikStopp (FehlermeldungExtern => "GrafikAllgemein.RechteckZeichnen - Rechteck ist größer als das Fenster");
         
      else
         Sf.Graphics.RectangleShape.setSize (shape => RechteckZugriff,
                                             size  => AbmessungExtern);
         Sf.Graphics.RectangleShape.setPosition (shape    => RechteckZugriff,
                                                 position => PositionZeichnenExtern);
         Sf.Graphics.RectangleShape.setFillColor (shape => RechteckZugriff,
                                                  color => FarbeExtern);
         Sf.Graphics.RenderWindow.drawRectangleShape (renderWindow => GrafikEinstellungen.Fenster,
                                                      object       => RechteckZugriff);
      end if;
      
   end KartenfeldZeichnen;
   
   
   
   procedure KreisZeichnen
     (FarbeExtern : in Sf.Graphics.Color.sfColor;
      PositionZeichnenExtern : in Sf.System.Vector2.sfVector2f;
      RadiusExtern : in Float)
   is begin
            
      if
        RadiusExtern = 0.00
      then
         Fehler.GrafikStopp (FehlermeldungExtern => "GrafikAllgemein.KreisZeichnen - Kreisradius ist 0.");
         
      else
         Sf.Graphics.CircleShape.setRadius (shape  => KreisZugriff,
                                            radius => RadiusExtern);
         Sf.Graphics.CircleShape.setPosition (shape    => KreisZugriff,
                                              position => PositionZeichnenExtern);
         Sf.Graphics.CircleShape.setFillColor (shape => KreisZugriff,
                                               color => FarbeExtern);
         Sf.Graphics.RenderWindow.drawCircleShape (renderWindow => GrafikEinstellungen.Fenster,
                                                   object       => KreisZugriff);
      end if;
      
   end KreisZeichnen;
   
   
   
   procedure PolygonZeichnen
     (FarbeExtern : in Sf.Graphics.Color.sfColor;
      PositionZeichnenExtern : in Sf.System.Vector2.sfVector2f;
      RadiusExtern : in Float;
      AnzahlEckenExtern : in Sf.sfSize_t)
   is begin
            
      if
        RadiusExtern = 0.00
      then
         Fehler.GrafikStopp (FehlermeldungExtern => "GrafikAllgemein.PolygonZeichnen - RadiusExtern = 0.00");
         
      else
         Sf.Graphics.CircleShape.setRadius (shape  => PolygonZugriff,
                                            radius => RadiusExtern);
         Sf.Graphics.CircleShape.setPointCount (shape => PolygonZugriff,
                                                count => AnzahlEckenExtern);
         Sf.Graphics.CircleShape.setPosition (shape    => PolygonZugriff,
                                              position => PositionZeichnenExtern);
         Sf.Graphics.CircleShape.setFillColor (shape => PolygonZugriff,
                                               color => FarbeExtern);
         Sf.Graphics.RenderWindow.drawCircleShape (renderWindow => GrafikEinstellungen.Fenster,
                                                   object       => PolygonZugriff);
      end if;
      
   end PolygonZeichnen;
   
   
   
   procedure AnzeigeStadt
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      EinheitStadtRasseNummer := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern);
         
      if
        EinheitStadtRasseNummer.Platznummer = EinheitenKonstanten.LeerNummer
      then
         null;
            
      else
         PolygonZeichnen (FarbeExtern            => Sf.Graphics.Color.sfYellow,
                          PositionZeichnenExtern => Position,
                          RadiusExtern           => BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.00,
                          AnzahlEckenExtern      => 5);
      end if;
      
   end AnzeigeStadt;
   
   
   
   procedure AnzeigeEinheit
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      EinheitStadtRasseNummer := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern);
         
      if
        EinheitStadtRasseNummer.Platznummer = EinheitenKonstanten.LeerNummer
      then
         null;
            
      elsif
        LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitStadtRasseNummer) /= EinheitenKonstanten.LeerWirdTransportiert
      then
         PolygonZeichnen (FarbeExtern            => Sf.Graphics.Color.sfYellow,
                          PositionZeichnenExtern => Position,
                          RadiusExtern           => BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.00,
                          AnzahlEckenExtern      => 4);
            
      else
         PolygonZeichnen (FarbeExtern            => Sf.Graphics.Color.sfYellow,
                          PositionZeichnenExtern => Position,
                          RadiusExtern           => BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.00,
                          AnzahlEckenExtern      => 4);
      end if;
      
   end AnzeigeEinheit;
   
   
   
   procedure AnzeigeCursor
     (InDerStadtExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        InDerStadtExtern
      is
         when False =>
            null;
            
         when True =>
            null;
      end case;
      
      if
        KoordinatenExtern = GlobaleVariablen.CursorImSpiel (RasseExtern).Position
        and
          InDerStadtExtern = False
      then
         PolygonZeichnen (FarbeExtern            => Sf.Graphics.Color.sfRed,
                          PositionZeichnenExtern => Position,
                          RadiusExtern           => BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.00,
                          AnzahlEckenExtern      => 3);
         
      else
         null;
      end if;
      
   end AnzeigeCursor;
   
   
   
   function FarbeErmitteln
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
      
   end FarbeErmitteln;

end KarteSFML;
