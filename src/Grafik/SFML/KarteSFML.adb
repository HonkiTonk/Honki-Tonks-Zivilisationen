pragma SPARK_Mode (On);

with KartenRecords; use KartenRecords;
with KartenDatentypen; use KartenDatentypen;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with EinheitenKonstanten;

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

package body KarteSFML is
   
   procedure KarteAnzeigen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Sichtbarkeit (InDerStadtExtern => False,
                    RasseExtern      => RasseExtern);
      
      KarteInformationenSFML.KarteInformationenSFML (RasseExtern => RasseExtern);
      
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
                  -- Ist das Zeichnen von schwarzen Felder notwendig? Immerhin wird ja vorher das Fenster immer geleert und auf Schwarz gesetzt.
                  null;
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
      
      -- Nicht vergessen Position hier in Übergabeparameter umzuwandeln.
      AnzeigeLandschaft (KoordinatenExtern => KoordinatenExtern,
                         PositionExtern    => Position);
            
      AnzeigeStadt (KoordinatenExtern => KoordinatenExtern,
                    RasseExtern       => RasseExtern);
            
      AnzeigeEinheit (KoordinatenExtern => KoordinatenExtern);
            
      case
        GlobaleVariablen.Debug
      is
         when True =>
            AnzeigeCursor (InDerStadtExtern  => InDerStadtExtern,
                           KoordinatenExtern => KoordinatenExtern,
                           RasseExtern       => RasseExtern);
            
         when False =>
            null;
      end case;
                  
   end IstSichtbar;
   
   
   
   procedure AnzeigeLandschaft
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => BerechnungenKarteSFML.KartenfelderAbmessung,
                                            PositionExtern       => PositionExtern,
                                            FarbeExtern          => FarbeKartenfeldErmitteln (GrundExtern => LeseKarten.Grund (PositionExtern => KoordinatenExtern)),
                                            RechteckAccessExtern => RechteckAccess);
            
      -- Mal Farben für die einzelnen Objekte einbauen. Ist das überhaupt sinnvoll wenn ich da später sowieso Texturen drüberlege?
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
   
   
   
   procedure AnzeigeStadt
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      -- Hier kann man die belegten Stadtfelder nicht einbauen. Eventuell über die Stadtgröße loopen, wenn eine Stadt gefunden wurde?
      EinheitStadtRasseNummer := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern);
         
      if
        EinheitStadtRasseNummer.Platznummer = EinheitenKonstanten.LeerNummer
      then
         null;
         
      elsif
        EinheitStadtRasseNummer.Rasse = RasseExtern
      then
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => EinheitStadtRasseNummer)
         is
            when KartenDatentypen.Eigene_Hauptstadt =>
               ObjekteZeichnenSFML.PolygonZeichnen (RadiusExtern        => BerechnungenKarteSFML.KartenfelderAbmessung.x / 3.00,
                                                    PositionExtern      => Position,
                                                    AnzahlEckenExtern   => 6,
                                                    FarbeExtern         => Sf.Graphics.Color.sfRed,
                                                    PolygonAccessExtern => PolygonAccess);
               
            when KartenDatentypen.Eigene_Stadt =>
               ObjekteZeichnenSFML.PolygonZeichnen (RadiusExtern        => BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.00,
                                                    PositionExtern      => Position,
                                                    AnzahlEckenExtern   => 5,
                                                    FarbeExtern         => Sf.Graphics.Color.sfRed,
                                                    PolygonAccessExtern => PolygonAccess);
               
            when KartenDatentypen.Leer =>
               Fehler.LogikStopp (FehlermeldungExtern => "KarteSFML.AnzeigeStadt - Vorhandene, eigene Stadt ist nicht vorhanden.");
         end case;
            
      else
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => EinheitStadtRasseNummer)
         is
            when KartenDatentypen.Eigene_Hauptstadt =>
               ObjekteZeichnenSFML.PolygonZeichnen (RadiusExtern        => BerechnungenKarteSFML.KartenfelderAbmessung.x / 3.00,
                                                    PositionExtern      => Position,
                                                    AnzahlEckenExtern   => 6,
                                                    FarbeExtern         => Sf.Graphics.Color.sfYellow,
                                                    PolygonAccessExtern => PolygonAccess);
               
            when KartenDatentypen.Eigene_Stadt =>
               ObjekteZeichnenSFML.PolygonZeichnen (RadiusExtern        => BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.00,
                                                    PositionExtern      => Position,
                                                    AnzahlEckenExtern   => 5,
                                                    FarbeExtern         => Sf.Graphics.Color.sfYellow,
                                                    PolygonAccessExtern => PolygonAccess);
               
            when KartenDatentypen.Leer =>
               Fehler.LogikStopp (FehlermeldungExtern => "KarteSFML.AnzeigeStadt - Vorhandene, fremde Stadt ist nicht vorhanden.");
         end case;
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
         ObjekteZeichnenSFML.PolygonZeichnen (RadiusExtern        => BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.80,
                                              PositionExtern      => Position,
                                              AnzahlEckenExtern   => 4,
                                              FarbeExtern         => Sf.Graphics.Color.sfYellow,
                                              PolygonAccessExtern => PolygonAccess);
            
      else
         ObjekteZeichnenSFML.PolygonZeichnen (RadiusExtern        => BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.80,
                                              PositionExtern      => Position,
                                              AnzahlEckenExtern   => 4,
                                              FarbeExtern         => Sf.Graphics.Color.sfYellow,
                                              PolygonAccessExtern => PolygonAccess);
      end if;
      
   end AnzeigeEinheit;
   
   
   
   procedure AnzeigeCursor
     (InDerStadtExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      -- Das kann wohl raus, auf jeden Fall in der SFML Version.
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
         ObjekteZeichnenSFML.PolygonZeichnen (RadiusExtern        => BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.00,
                                              PositionExtern      => Position,
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
