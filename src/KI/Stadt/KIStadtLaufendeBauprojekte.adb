pragma SPARK_Mode (On);

package body KIStadtLaufendeBauprojekte is

   function StadtLaufendeBauprojekte
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BauprojektExtern : in Natural)
      return Natural
   is begin
      
      GleichesBauprojekt := 0;
     
      StadtSchleife:
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (2) loop
            
         if
           StadtNummerSchleifenwert = StadtRasseNummerExtern.Platznummer
           or
             GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtNummerSchleifenwert).ID = 0
         then
            null;
               
         elsif
           GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AktuellesBauprojekt = BauprojektExtern
         then
            GleichesBauprojekt := GleichesBauprojekt + 1;
               
         else
            null;
         end if;
            
      end loop StadtSchleife;
      
      return GleichesBauprojekt;
      
   end StadtLaufendeBauprojekte;

end KIStadtLaufendeBauprojekte;
