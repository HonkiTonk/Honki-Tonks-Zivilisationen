pragma SPARK_Mode (On);

with GlobaleKonstanten;

package body NaechstesObjekt is  

   procedure NächsteEinheit
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      BewegungspunkteExtern : in Bewegungspunkte)
   is begin
      
      SchleifenBegrenzung := 0;
      
      EinheitSuchenSchleife:
      loop

         if
           AktuelleEinheit (RasseExtern) >= GlobaleVariablen.Grenzen (RasseExtern).Einheitengrenze
         then
            AktuelleEinheit (RasseExtern) := 1;
               
         else
            AktuelleEinheit (RasseExtern) := AktuelleEinheit (RasseExtern) + 1;
         end if;
               
         if
           GlobaleVariablen.EinheitenGebaut (RasseExtern, AktuelleEinheit (RasseExtern)).ID = GlobaleKonstanten.LeerEinheit.ID
           or
             (GlobaleVariablen.EinheitenGebaut (RasseExtern, AktuelleEinheit (RasseExtern)).Bewegungspunkte <= GlobaleKonstanten.LeerEinheit.Bewegungspunkte and BewegungspunkteExtern = Hat_Bewegungspunkte)
           or
             (GlobaleVariablen.EinheitenGebaut (RasseExtern, AktuelleEinheit (RasseExtern)).Bewegungspunkte > GlobaleKonstanten.LeerEinheit.Bewegungspunkte and BewegungspunkteExtern = Keine_Bewegungspunkte)
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
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin

      SchleifenBegrenzung := 0;
      
      StadtSuchenSchleife:
      loop

         if
           AktuelleStadt (RasseExtern) >= GlobaleVariablen.Grenzen (RasseExtern).Städtegrenze
         then
            AktuelleStadt (RasseExtern) := 1;
               
         else
            AktuelleStadt (RasseExtern) := AktuelleStadt (RasseExtern) + 1;
         end if;
               
         if
           GlobaleVariablen.StadtGebaut (RasseExtern, AktuelleStadt (RasseExtern)).ID = GlobaleDatentypen.Leer
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
