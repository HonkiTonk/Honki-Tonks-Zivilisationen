pragma SPARK_Mode (On);

with GlobaleKonstanten;

with SchreibeEinheitenGebaut;
with LeseKarten, LeseEinheitenGebaut;

with KartePositionPruefen, EinheitSuchen, StadtSuchen, DiplomatischerZustand;
with KIGefahrReaktion;

package body KIGefahrErmitteln is
   
   procedure KIGefahrErmitteln
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
               
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                        ÄnderungExtern   => (0, YAchseSchleifenwert, XAchseSchleifenwert));
               
            if
              KartenWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
            then
               null;
                  
            elsif
              LeseKarten.Sichtbar (PositionExtern => KartenWert,
                                   RasseExtern    => EinheitRasseNummerExtern.Rasse)
              = False
            then
               null;
                  
            else
               EinheitUnzugeordnet := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KartenWert);
                  
               if
                 EinheitUnzugeordnet.Platznummer = GlobaleKonstanten.LeerEinheitStadtNummer
                 or
                   EinheitUnzugeordnet.Rasse = EinheitRasseNummerExtern.Rasse
               then
                  null;
                     
               elsif
                 DiplomatischerZustand.DiplomatischenStatusPrüfen (EigeneRasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                    FremdeRasseExtern => EinheitUnzugeordnet.Rasse)
                 = GlobaleDatentypen.Krieg
                 and
                   StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                               KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
                     /= GlobaleKonstanten.LeerEinheitStadtNummer
               then
                  SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                           BewegungspunkteExtern    => GlobaleKonstanten.LeerEinheit.Bewegungspunkte,
                                                           RechnenSetzenExtern      => 0);
                  
               elsif
                 DiplomatischerZustand.DiplomatischenStatusPrüfen (EigeneRasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                    FremdeRasseExtern => EinheitUnzugeordnet.Rasse)
                 = GlobaleDatentypen.Krieg
               then
                  KIGefahrReaktion.KIGefahrReaktion (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
                  return;
                  
               else
                  null;
               end if;
            end if;
               
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end KIGefahrErmitteln;

end KIGefahrErmitteln;
