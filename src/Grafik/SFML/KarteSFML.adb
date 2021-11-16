pragma SPARK_Mode (On);

with KartenRecords; use KartenRecords;
with KartenDatentypen; use KartenDatentypen;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with EinheitenKonstanten;

with LeseKarten;
with LeseEinheitenGebaut;

with KartePositionPruefen;
with GrafikAllgemein;
with EinheitSuchen;
with StadtSuchen;
with KarteInformationenSFML;
with BerechnungenKarteSFML;

package body KarteSFML is
   
   procedure KarteAnzeigen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
            
      GrafikAllgemein.FensterLeeren;
            
      Sichtbarkeit (InDerStadtExtern => False,
                    RasseExtern      => RasseExtern);
      
      KarteInformationenSFML.KarteInformationenSFML (RasseExtern => RasseExtern);
      
      GrafikAllgemein.FensterAnzeigen;
      
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
                  GrafikAllgemein.RechteckZeichnen (AbmessungExtern => BerechnungenKarteSFML.KartenfelderAbmessung,
                                                    PositionExtern  => Position,
                                                    FarbeExtern     => Sf.Graphics.Color.sfBlack);
                  if
                    KartenWert = GlobaleVariablen.CursorImSpiel (RasseExtern).Position
                  then
                     GrafikAllgemein.PolygonZeichnen (RadiusExtern      => BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.00,
                                                      PositionExtern    => Position,
                                                      AnzahlEckenExtern => 3,
                                                      FarbeExtern       => Sf.Graphics.Color.sfBlack);
               
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
         GrafikAllgemein.PolygonZeichnen (RadiusExtern      => BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.00,
                                          PositionExtern    => Position,
                                          AnzahlEckenExtern => 3,
                                          FarbeExtern       => Sf.Graphics.Color.sfRed);
         
      else
         null;
      end if;
      
   end AnzeigeCursor;
   
   
   
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
         GrafikAllgemein.PolygonZeichnen (RadiusExtern      => BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.00,
                                          PositionExtern    => Position,
                                          AnzahlEckenExtern => 4,
                                          FarbeExtern       => Sf.Graphics.Color.sfYellow);
            
      else
         GrafikAllgemein.PolygonZeichnen (RadiusExtern      => BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.00,
                                          PositionExtern    => Position,
                                          AnzahlEckenExtern => 4,
                                          FarbeExtern       => Sf.Graphics.Color.sfYellow);
      end if;
      
   end AnzeigeEinheit;
   
   
   
   procedure AnzeigeStadt
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      EinheitStadtRasseNummer := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern);
         
      if
        EinheitStadtRasseNummer.Platznummer = EinheitenKonstanten.LeerNummer
      then
         null;
            
      else
         GrafikAllgemein.PolygonZeichnen (RadiusExtern      => BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.00,
                                          PositionExtern    => Position,
                                          AnzahlEckenExtern => 5,
                                          FarbeExtern       => Sf.Graphics.Color.sfYellow);
      end if;
      
   end AnzeigeStadt;
   
   
   
   procedure AnzeigeLandschaft
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      GrafikAllgemein.RechteckZeichnen (AbmessungExtern => BerechnungenKarteSFML.KartenfelderAbmessung,
                                        PositionExtern  => Position,
                                        FarbeExtern     => FarbeErmitteln (GrundExtern => LeseKarten.Grund (PositionExtern => KartenWert)));
      
      case
        LeseKarten.Ressource (PositionExtern => KoordinatenExtern)
      is
         when KartenDatentypen.Leer =>
            null;
            
         when others =>
            GrafikAllgemein.KreisZeichnen (RadiusExtern   => BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.00,
                                           PositionExtern => Position,
                                           FarbeExtern    => Sf.Graphics.Color.sfBlack);
      end case;
      
      case
        LeseKarten.Fluss (PositionExtern => KoordinatenExtern)
      is
         when KartenDatentypen.Leer =>
            null;
            
         when others =>
            GrafikAllgemein.RechteckZeichnen (AbmessungExtern => (BerechnungenKarteSFML.KartenfelderAbmessung.x, BerechnungenKarteSFML.KartenfelderAbmessung.y / 5.00),
                                              PositionExtern  => (Position.x, Position.y + 0.40 * BerechnungenKarteSFML.KartenfelderAbmessung.y),
                                              FarbeExtern     => Sf.Graphics.Color.sfBlue);
      end case;
      
      case
        LeseKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern)
      is
         when KartenDatentypen.Leer =>
            null;
            
         when others =>
            GrafikAllgemein.RechteckZeichnen (AbmessungExtern => (BerechnungenKarteSFML.KartenfelderAbmessung.x, BerechnungenKarteSFML.KartenfelderAbmessung.y / 2.00),
                                              PositionExtern  => Position,
                                              FarbeExtern     => Sf.Graphics.Color.sfRed);
      end case;
      
      case
        LeseKarten.VerbesserungGebiet (PositionExtern => KoordinatenExtern)
      is
         when KartenDatentypen.Leer =>
            null;
            
         when others =>
            GrafikAllgemein.RechteckZeichnen (AbmessungExtern => (BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.00, BerechnungenKarteSFML.KartenfelderAbmessung.y / 2.00),
                                              PositionExtern  => Position,
                                              FarbeExtern     => Sf.Graphics.Color.sfCyan);
      end case;
      
   end AnzeigeLandschaft;
   
   
   
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
            raise Program_Error;
      end case;
      
   end FarbeErmitteln;

end KarteSFML;
