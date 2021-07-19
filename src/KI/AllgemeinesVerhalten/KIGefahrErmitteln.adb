pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KartePositionPruefen, EinheitSuchen, Karten;

package body KIGefahrErmitteln is

   procedure KIGefahrErmitteln
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      EigeneEinheiten := 0;
      FeindlicheEinheiten := 0;
            
      EAchseSchleife:
      for EAchseSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         YAchseSchleife:
         for YAchseSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
            XAchseSchleife:
            for XAchseSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
               
               KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position,
                                                                           ÄnderungExtern   => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
               
               if
                 KartenWert.XAchse = 0
               then
                  null;
                  
               elsif
                 Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Sichtbar (EinheitRasseNummerExtern.Rasse) = False
               then
                  null;
                  
               else
                  EinheitUnzugeordnet := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KartenWert);
                  
                  if
                    EinheitUnzugeordnet.Platznummer = GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch
                  then
                     null;
                     
                  elsif
                    EinheitUnzugeordnet.Rasse = EinheitRasseNummerExtern.Rasse
                  then
                     EigeneEinheiten := EigeneEinheiten + 1;
                     
                  elsif
                    GlobaleVariablen.Diplomatie (EinheitRasseNummerExtern.Rasse, EinheitUnzugeordnet.Rasse) in GlobaleDatentypen.Status_Untereinander_Friedlich_Enum
                    or
                      GlobaleVariablen.Diplomatie (EinheitRasseNummerExtern.Rasse, EinheitUnzugeordnet.Rasse) in GlobaleDatentypen.Status_Untereinander_Neutral_Enum
                    or
                      GlobaleVariablen.Diplomatie (EinheitRasseNummerExtern.Rasse, EinheitUnzugeordnet.Rasse) = GlobaleDatentypen.Kein_Kontakt
                  then
                     null;
                     
                  elsif
                    GlobaleVariablen.Diplomatie (EinheitRasseNummerExtern.Rasse, EinheitUnzugeordnet.Rasse) in GlobaleDatentypen.Status_Untereinander_Aggressiv_Enum
                  then
                     FeindlicheEinheiten := FeindlicheEinheiten + 1;
                  
                  else
                     null;
                  end if;
               end if;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      
   end KIGefahrErmitteln;

end KIGefahrErmitteln;
