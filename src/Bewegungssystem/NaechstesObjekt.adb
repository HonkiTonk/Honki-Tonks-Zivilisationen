pragma SPARK_Mode (On);

package body NaechstesObjekt is  

   procedure NächsteEinheit
     (RasseExtern : in GlobaleDatentypen.Rassen;
      BewegungspunkteExtern : in Bewegungspunkte)
   is begin
      
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
             (GlobaleVariablen.EinheitenGebaut (RasseExtern, AktuelleEinheit (RasseExtern)).Bewegungspunkte <= 0.00 and BewegungspunkteExtern = Hat_Bewegungspunkte)
           or
             (GlobaleVariablen.EinheitenGebaut (RasseExtern, AktuelleEinheit (RasseExtern)).Bewegungspunkte > 0.00 and BewegungspunkteExtern = Keine_Bewegungspunkte)
         then
            null;
         
         else
            exit EinheitSuchenSchleife;
         end if;
         
         if
           SchleifenBegrenzung < GlobaleDatentypen.MaximaleEinheiten'Last
         then            
            SchleifenBegrenzung := SchleifenBegrenzung + 1;
            
         else
            return;
         end if;

      end loop EinheitSuchenSchleife;
      
      GlobaleVariablen.CursorImSpiel (RasseExtern).Position := GlobaleVariablen.EinheitenGebaut (RasseExtern, AktuelleEinheit (RasseExtern)).Position;
      
   end NächsteEinheit;
   
   
   
   procedure NächsteStadt
     (RasseExtern : in GlobaleDatentypen.Rassen)
   is begin

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
         
         if
           SchleifenBegrenzung < GlobaleDatentypen.MaximaleStädte'Last
         then
            SchleifenBegrenzung := SchleifenBegrenzung + 1;
            
         else
            return;
         end if;

      end loop StadtSuchenSchleife;
      
      GlobaleVariablen.CursorImSpiel (RasseExtern).Position := GlobaleVariablen.StadtGebaut (RasseExtern, AktuelleStadt (RasseExtern)).Position;
      
   end NächsteStadt;

end NaechstesObjekt;
