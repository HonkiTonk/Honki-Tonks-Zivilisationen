pragma SPARK_Mode (On);

with KartenRecords; use KartenRecords;
with KartenDatentypen; use KartenDatentypen;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with KartenKonstanten;
with EinheitenKonstanten;

with LeseKarten;
with LeseEinheitenGebaut;

with KartePositionPruefen;
with GrafikAllgemein;
with Sichtweiten;
with GrafikEinstellungen;
with EinheitSuchen;
with StadtSuchen;

package body KarteAnzeigeErmitteln is
   
   procedure KarteAnzeigen
     (InDerStadtExtern : in Boolean;
      RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      GrafikAllgemein.FensterLeeren;
      
      YAchseSchleife:
      for YAchseSchleifenwert in -Sichtweiten.SichtweitenStandard (Sichtweiten.SichtweiteFestlegen).YAchse .. Sichtweiten.SichtweitenStandard (Sichtweiten.SichtweiteFestlegen).YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in -Sichtweiten.SichtweitenStandard (Sichtweiten.SichtweiteFestlegen).XAchse .. Sichtweiten.SichtweitenStandard (Sichtweiten.SichtweiteFestlegen).XAchse loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt,
                                                                        ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert));
            
            case
              KartenWert.XAchse
            is
               when KartenKonstanten.LeerXAchse =>
                  null;
                  
               when others =>
                  KarteAnzeigeErmitteln.Sichtbarkeit (InDerStadtExtern      => InDerStadtExtern,
                                                      SichtweiteEbeneExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                      RasseExtern           => RasseExtern);
            end case;
                        
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      GrafikAllgemein.FensterAnzeigen;
      
   end KarteAnzeigen;
   
   

   procedure Sichtbarkeit
     (InDerStadtExtern : in Boolean;
      SichtweiteEbeneExtern : in KartenRecords.AchsenKartenfeldRecord;
      RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt,
                                                                  ÄnderungExtern    => SichtweiteEbeneExtern);
      
      case
        KartenWert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            return;
                  
         when others =>
            null;
      end case;
      
      Abmessung.x := Float (GrafikEinstellungen.FensterBreite) / Float (2 * Sichtweiten.SichtweitenStandard (Sichtweiten.SichtweiteFestlegen).XAchse + 1);
      Abmessung.y := Float (GrafikEinstellungen.FensterHöhe) / Float (2 * Sichtweiten.SichtweitenStandard (Sichtweiten.SichtweiteFestlegen).YAchse + 1);
      
      YMultiplikator := 0.00;
      
      YAchseSchleife:
      for YAchseSchleifenwert in -Sichtweiten.SichtweitenStandard (Sichtweiten.SichtweiteFestlegen).YAchse .. Sichtweiten.SichtweitenStandard (Sichtweiten.SichtweiteFestlegen).YAchse loop
         
         XMultiplikator := 0.00;
         
         XAchseSchleife:
         for XAchseSchleifenwert in -Sichtweiten.SichtweitenStandard (Sichtweiten.SichtweiteFestlegen).XAchse .. Sichtweiten.SichtweitenStandard (Sichtweiten.SichtweiteFestlegen).XAchse loop
            
            if
              SichtweiteEbeneExtern.YAchse = YAchseSchleifenwert
              and
                SichtweiteEbeneExtern.XAchse = XAchseSchleifenwert
            then
               Position.x := XMultiplikator * Abmessung.x;
               Position.y := YMultiplikator * Abmessung.y;
               exit YAchseSchleife;
         
            else
               XMultiplikator := XMultiplikator + 1.00;
            end if;
            
         end loop XAchseSchleife;
         
         YMultiplikator := YMultiplikator + 1.00;
         
      end loop YAchseSchleife;
            
      case
        LeseKarten.Sichtbar (PositionExtern => KartenWert,
                             RasseExtern    => RasseExtern)
      is
         when True =>
            IstSichtbar (InDerStadtExtern  => InDerStadtExtern,
                         KoordinatenExtern => KartenWert,
                         RasseExtern       => RasseExtern);
                        
         when False =>
            GrafikAllgemein.RechteckZeichnen (AbmessungExtern => Abmessung,
                                              PositionExtern  => Position,
                                              FarbeExtern     => Sf.Graphics.Color.sfBlack);
            if
              KartenWert = GlobaleVariablen.CursorImSpiel (RasseExtern).Position
            then
               GrafikAllgemein.PolygonZeichnen (RadiusExtern      => Abmessung.x / 2.00,
                                                PositionExtern    => Position,
                                                AnzahlEckenExtern => 3,
                                                FarbeExtern       => Sf.Graphics.Color.sfBlack);
               
            else
               null;
            end if;
      end case;
      
   end Sichtbarkeit;
   
   
   
   procedure IstSichtbar
     (InDerStadtExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
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
      RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        KoordinatenExtern = GlobaleVariablen.CursorImSpiel (RasseExtern).Position
        and
          InDerStadtExtern = False
      then
         GrafikAllgemein.PolygonZeichnen (RadiusExtern      => Abmessung.x / 2.00,
                                          PositionExtern    => Position,
                                          AnzahlEckenExtern => 3,
                                          FarbeExtern       => Sf.Graphics.Color.sfBlack);
         
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
         GrafikAllgemein.KreisZeichnen (RadiusExtern   => Abmessung.x / 2.00,
                                        PositionExtern => Position,
                                        FarbeExtern    => Sf.Graphics.Color.sfBlack);
            
      else
         GrafikAllgemein.KreisZeichnen (RadiusExtern   => Abmessung.x / 2.00,
                                        PositionExtern => Position,
                                        FarbeExtern    => Sf.Graphics.Color.sfBlack);
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
         GrafikAllgemein.KreisZeichnen (RadiusExtern   => Abmessung.x / 2.00,
                                        PositionExtern => Position,
                                        FarbeExtern    => Sf.Graphics.Color.sfBlack);
      end if;
      
   end AnzeigeStadt;
   
   
   
   procedure AnzeigeLandschaft
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      GrafikAllgemein.RechteckZeichnen (AbmessungExtern => Abmessung,
                                        PositionExtern  => Position,
                                        FarbeExtern     => FarbeErmitteln (GrundExtern => LeseKarten.Grund (PositionExtern => KartenWert)));
      
      case
        LeseKarten.Ressource (PositionExtern => KoordinatenExtern)
      is
         when KartenDatentypen.Leer =>
            null;
            
         when others =>
            GrafikAllgemein.KreisZeichnen (RadiusExtern   => Abmessung.x / 2.00,
                                           PositionExtern => Position,
                                           FarbeExtern    => Sf.Graphics.Color.sfBlack);
      end case;
      
      case
        LeseKarten.Fluss (PositionExtern => KoordinatenExtern)
      is
         when KartenDatentypen.Leer =>
            null;
            
         when others =>
            GrafikAllgemein.RechteckZeichnen (AbmessungExtern => (Abmessung.x, Abmessung.y / 2.00),
                                              PositionExtern  => Position,
                                              FarbeExtern     => Sf.Graphics.Color.sfBlue);
      end case;
      
      case
        LeseKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern)
      is
         when KartenDatentypen.Leer =>
            null;
            
         when others =>
            GrafikAllgemein.RechteckZeichnen (AbmessungExtern => (Abmessung.x, Abmessung.y / 2.00),
                                              PositionExtern  => Position,
                                              FarbeExtern     => Sf.Graphics.Color.sfRed);
      end case;
      
      case
        LeseKarten.VerbesserungGebiet (PositionExtern => KoordinatenExtern)
      is
         when KartenDatentypen.Leer =>
            null;
            
         when others =>
            GrafikAllgemein.RechteckZeichnen (AbmessungExtern => (Abmessung.x / 2.00, Abmessung.y / 2.00),
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

end KarteAnzeigeErmitteln;
