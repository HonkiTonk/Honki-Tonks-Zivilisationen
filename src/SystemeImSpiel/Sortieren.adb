pragma SPARK_Mode (On);

package body Sortieren is

   procedure EinheitenSortieren (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin

      EinheitenTauschSchleife:
      for EinheitenTauschenSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
         
         SortierenEinheiten (EinheitenTauschenSchleifenwert) := GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitenTauschenSchleifenwert);
         GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitenTauschenSchleifenwert) := GlobaleVariablen.LeererWertEinheit;
         
      end loop EinheitenTauschSchleife;

      EinheitenSortierenAußenSchleife:
      for EinsortierenSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
         EinheitenSortierenInnenSchleife:
         for AuswahlSchleifenwert in SortierenEinheitenArray'Range loop
            
            if SortierenEinheiten (AuswahlSchleifenwert).ID /= 0 then
               GlobaleVariablen.EinheitenGebaut (RasseExtern, EinsortierenSchleifenwert) := SortierenEinheiten (AuswahlSchleifenwert);
               SortierenEinheiten (AuswahlSchleifenwert) := GlobaleVariablen.LeererWertEinheit;
               exit EinheitenSortierenInnenSchleife;
               
            elsif AuswahlSchleifenwert = SortierenEinheiten'Last then
               exit EinheitenSortierenAußenSchleife;
               
            else
               null;
            end if;               
            
         end loop EinheitenSortierenInnenSchleife;         
      end loop EinheitenSortierenAußenSchleife;
            
   end EinheitenSortieren;



   procedure StädteSortieren (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin
      
      StädteTauschenSchleife:
      for StädteTauschenSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (2) loop

         SortierenStädte (StädteTauschenSchleifenwert) := GlobaleVariablen.StadtGebaut (RasseExtern, StädteTauschenSchleifenwert);
         GlobaleVariablen.StadtGebaut (RasseExtern, StädteTauschenSchleifenwert) := GlobaleVariablen.LeererWertStadt;

      end loop StädteTauschenSchleife;

      StädteSortierenAußenSchleife:
      for EinsortierenSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (2) loop
         StädteSortierenInnenSchleife:
         for AuswahlSchleifenwert in SortierenStädteArray'Range loop
            
            if SortierenStädte (AuswahlSchleifenwert).ID /= 0 then
               GlobaleVariablen.StadtGebaut (RasseExtern, EinsortierenSchleifenwert) := SortierenStädte (AuswahlSchleifenwert);
               SortierenStädte (AuswahlSchleifenwert) := GlobaleVariablen.LeererWertStadt;
               exit StädteSortierenInnenSchleife;
               
            elsif AuswahlSchleifenwert = SortierenStädte'Last then
               exit StädteSortierenAußenSchleife;
               
            else
               null;
            end if;
            
         end loop StädteSortierenInnenSchleife;
      end loop StädteSortierenAußenSchleife;
      
   end StädteSortieren;

end Sortieren;
