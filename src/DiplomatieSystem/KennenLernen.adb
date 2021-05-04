pragma SPARK_Mode (On);

with Karten;

package body KennenLernen is

   procedure KennenLernen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) 
   is begin
      
      RassenSchleife:
      for RassenSchleifenwert in GlobaleDatentypen.Rassen loop
         
         if
           Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                             GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                             GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).Sichtbar (RassenSchleifenwert) = True
         then
            null;
            
         else
            null;
         end if;
         
      end loop RassenSchleife;
      
   end KennenLernen;

end KennenLernen;
