pragma SPARK_Mode (On);

with KIVariablen, GlobaleVariablen;

package body KIZuruecksetzen is

   procedure KIZurücksetzenAmRundenende is
   begin
      
      RassenSchleife:
      for RassenIntern in GlobaleVariablen.RassenImSpiel'Range loop
         
         case GlobaleVariablen.RassenImSpiel (RassenIntern) is
            when 2 =>
               KIVariablen.EinheitenSchonBefehleErteilt (RassenIntern) := 0;
               EinheitenSchleife:
               for EinheitNummer in KIVariablen.EinheitenNochBefehleErteilbar'Range (2) loop
                  
                  KIVariablen.EinheitenNochBefehleErteilbar (RassenIntern, EinheitNummer) := True;
                  
               end loop EinheitenSchleife;
               
            when others =>
               null;
         end case;
         
      end loop RassenSchleife;
      
   end KIZurücksetzenAmRundenende;

end KIZuruecksetzen;
