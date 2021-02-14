pragma SPARK_Mode (On);

package body Sortieren is

   procedure EinheitenSortieren (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin

      EinheitenTauschSchleife:
      for EinheitenTauschen in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
         
         SortierenEinheiten (EinheitenTauschen) := GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitenTauschen);
         GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitenTauschen) := GlobaleVariablen.LeererWertEinheit;
         
      end loop EinheitenTauschSchleife;

      EinheitenSortierenAußenSchleife:
      for Einsortieren in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
         EinheitenSortierenInnenSchleife:
         for Auswahl in SortierenEinheitenArray'Range loop
            
            if SortierenEinheiten (Auswahl).ID /= 0 then
               GlobaleVariablen.EinheitenGebaut (RasseExtern, Einsortieren) := SortierenEinheiten (Auswahl);
               SortierenEinheiten (Auswahl) := GlobaleVariablen.LeererWertEinheit;
               exit EinheitenSortierenInnenSchleife;
               
            elsif Auswahl = SortierenEinheiten'Last then
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
      for StädteTauschen in GlobaleVariablen.StadtGebautArray'Range (2) loop

         SortierenStädte (StädteTauschen) := GlobaleVariablen.StadtGebaut (RasseExtern, StädteTauschen);
         GlobaleVariablen.StadtGebaut (RasseExtern, StädteTauschen) := GlobaleVariablen.LeererWertStadt;

      end loop StädteTauschenSchleife;

      StädteSortierenAußenSchleife:
      for Einsortieren in GlobaleVariablen.StadtGebautArray'Range (2) loop
         StädteSortierenInnenSchleife:
         for Auswahl in SortierenStädteArray'Range loop
            
            if SortierenStädte (Auswahl).ID /= 0 then
               GlobaleVariablen.StadtGebaut (RasseExtern, Einsortieren) := SortierenStädte (Auswahl);
               SortierenStädte (Auswahl) := GlobaleVariablen.LeererWertStadt;
               exit StädteSortierenInnenSchleife;
               
            elsif Auswahl = SortierenStädte'Last then
               exit StädteSortierenAußenSchleife;
               
            else
               null;
            end if;
            
         end loop StädteSortierenInnenSchleife;
      end loop StädteSortierenAußenSchleife;
      
   end StädteSortieren;

end Sortieren;
