pragma SPARK_Mode (On);

package body NaechstesObjekt is  

   procedure NächsteEinheit (RasseExtern : in GlobaleDatentypen.Rassen; BewegungspunkteExtern : in Bewegungspunkte) is
   begin
      
      SchleifenBegrenzung := 0;
      
      EinheitSuchenSchleife:
      loop

         case
           AktuelleEinheit (RasseExtern)
         is
            when GlobaleDatentypen.MaximaleEinheiten'Last =>
               AktuelleEinheit (RasseExtern) := 1;
               
            when others =>
               AktuelleEinheit (RasseExtern) := AktuelleEinheit (RasseExtern) + 1;
         end case;
               
         if
           GlobaleVariablen.EinheitenGebaut (RasseExtern, AktuelleEinheit (RasseExtern)).ID = 0
           or
             (GlobaleVariablen.EinheitenGebaut (RasseExtern, AktuelleEinheit (RasseExtern)).AktuelleBewegungspunkte <= 0.00 and BewegungspunkteExtern = Hat_Bewegungspunkte)
           or
             (GlobaleVariablen.EinheitenGebaut (RasseExtern, AktuelleEinheit (RasseExtern)).AktuelleBewegungspunkte > 0.00 and BewegungspunkteExtern = Keine_Bewegungspunkte)
         then
            null;
         
         else
            exit EinheitSuchenSchleife;
         end if;

         SchleifenBegrenzung := SchleifenBegrenzung + 1;
         case
           SchleifenBegrenzung
         is
            when GlobaleDatentypen.MaximaleEinheiten'Last =>
               return;
               
            when others =>
               null;
         end case;

      end loop EinheitSuchenSchleife;
      
      GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition := GlobaleVariablen.EinheitenGebaut (RasseExtern, AktuelleEinheit (RasseExtern)).AchsenPosition;
      
   end NächsteEinheit;
   
   
   
   procedure NächsteStadt (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin

      SchleifenBegrenzung := 0;
      
      StadtSuchenSchleife:
      loop

         case
           AktuelleStadt (RasseExtern)
         is
            when GlobaleDatentypen.MaximaleStädte'Last =>
               AktuelleStadt (RasseExtern) := 1;
               
            when others =>
               AktuelleStadt (RasseExtern) := AktuelleStadt (RasseExtern) + 1;
         end case;
               
         if
           GlobaleVariablen.StadtGebaut (RasseExtern, AktuelleStadt (RasseExtern)).ID = 0
         then
            null;
         
         else
            exit StadtSuchenSchleife;
         end if;

         SchleifenBegrenzung := SchleifenBegrenzung + 1;
         case
           SchleifenBegrenzung
         is
            when GlobaleDatentypen.MaximaleStädte'Last =>
               return;
               
            when others =>
               null;
         end case;

      end loop StadtSuchenSchleife;
      
      GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition := GlobaleVariablen.StadtGebaut (RasseExtern, AktuelleStadt (RasseExtern)).AchsenPosition;
      
   end NächsteStadt;

end NaechstesObjekt;
