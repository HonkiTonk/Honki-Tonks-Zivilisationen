pragma SPARK_Mode (On);

with GlobaleVariablen;

package body KIZuruecksetzen is

   procedure KIZurücksetzenAmRundenende is
   begin
      
      RassenSchleife:
      for RasseSchleifenwert in GlobaleVariablen.RassenImSpiel'Range loop
         
         case GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) is
            when 2 =>
               EinheitenSchleife:
               for EinheitNummer in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
                  
                  null;
                  
               end loop EinheitenSchleife;
               
            when others =>
               null;
         end case;
         
      end loop RassenSchleife;
      
   end KIZurücksetzenAmRundenende;

end KIZuruecksetzen;
