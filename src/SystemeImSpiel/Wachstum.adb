package body Wachstum is

   procedure Wachstum is
   begin
      
      RasseSchleife:
      for Rasse in GlobaleVariablen.StadtGebaut'Range (1) loop
         StadtSchleife:
         for StadtNummer in GlobaleVariablen.StadtGebaut'Range (2) loop

            if StadtNummer = 1 then
               GlobaleVariablen.Wichtiges (Rasse).AktuelleForschungsrate := 0;
               GlobaleVariablen.Wichtiges (Rasse).GeldZugewinnProRunde := 0;
            
            elsif GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).ID = 0 then
               exit StadtSchleife;
               
            else
               GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleNahrungsmittel :=
                 GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleNahrungsmittel + GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleNahrungsproduktion;

               if GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleNahrungsmittel >= 10 then
                  GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleNahrungsmittel := 0;
                  GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).Einwohner := GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).Einwohner + 1;

               elsif GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleNahrungsmittel < 0 then
                  GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleNahrungsmittel := 0;
                  GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).Einwohner := GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).Einwohner - 1;
                  
               else
                  null;
               end if;
            end if;

            GlobaleVariablen.Wichtiges (Rasse).AktuelleForschungsrate := GlobaleVariablen.Wichtiges (Rasse).AktuelleForschungsrate + GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleForschungsrate;
            GlobaleVariablen.Wichtiges (Rasse).GeldZugewinnProRunde := GlobaleVariablen.Wichtiges (Rasse).GeldZugewinnProRunde + GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleGeldgewinnung;
            
         end loop StadtSchleife;
      end loop RasseSchleife;

      for RasseZwei in GlobaleVariablen.StadtGebaut'Range (1) loop
         
         GlobaleVariablen.Wichtiges (RasseZwei).AktuelleGeldmenge := GlobaleVariablen.Wichtiges (RasseZwei).AktuelleGeldmenge + GlobaleVariablen.Wichtiges (RasseZwei).GeldZugewinnProRunde;
         GlobaleVariablen.Wichtiges (RasseZwei).AktuelleForschungsmenge := GlobaleVariablen.Wichtiges (RasseZwei).AktuelleForschungsmenge + GlobaleVariablen.Wichtiges (RasseZwei).AktuelleForschungsrate;
         
      end loop;
      
   end Wachstum;

end Wachstum;
