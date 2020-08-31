package body Sichtbarkeit is

   procedure Sichtbarkeit is
   begin
      
      EinheitenPlätzeSchleife:
      for A in GlobaleVariablen.EinheitenGebaut'Range (2) loop

         if GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, A).ID = 0 then
            exit EinheitenPlätzeSchleife;
            
         else
            null;
         end if;
         
         if Karten.Karten (GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, A).YAchse, GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, A).XAchse).Grund = 7 then
            Sichtweite := 3;
         elsif Karten.Karten (GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, A).YAchse, GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, A).XAchse).Grund = 9  then
            Sichtweite := 1;
         else
            Sichtweite := 2;
         end if;

         YÄnderungEinheitenSchleife:
         for Y in -Sichtweite .. Sichtweite loop
            
            XÄnderungEinheitenSchleife:
            for X in -Sichtweite .. Sichtweite loop
               
               if GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, A).YAchse + Y > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße or GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, A).YAchse + Y < Karten.Karten'First (1) then
                  null;

               elsif GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, A).XAchse + X > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße then
                  Wert := GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, A).XAchse + X - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
                  for B in Karten.Karten'First (2) .. Wert loop
                  
                     Karten.Karten (GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, A).YAchse + Y, B).Sichtbar := True;
                  
                  end loop;
                  
               elsif GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, A).XAchse + X < Karten.Karten'First (2) then
                  Wert := GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, A).XAchse + X + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
                  for B in Wert .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
                  
                     Karten.Karten (GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, A).YAchse + Y, B).Sichtbar := True;
                  
                  end loop;
                  
               else
                  Karten.Karten (GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, A).YAchse + Y, GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, A).XAchse + X).Sichtbar := True;
               end if;
            
            end loop XÄnderungEinheitenSchleife;
         end loop YÄnderungEinheitenSchleife;
      end loop EinheitenPlätzeSchleife;

      StadtPlätzeSchleife:
      for A in GlobaleVariablen.EinheitenGebaut'Range (2) loop

         if GlobaleVariablen.StadtGebaut (GlobaleVariablen.Rasse, A).ID = 0 then
            exit StadtPlätzeSchleife;
                  
         elsif GlobaleVariablen.StadtGebaut (GlobaleVariablen.Rasse, A). Einwohner < 10 then
            Sichtweite := 2;
            
         else
            Sichtweite := 3;
         end if; 

         YÄnderungStadtSchleife:         
         for Y in -Sichtweite .. Sichtweite loop
            
            XÄnderungStadtSchleife:
            for X in -Sichtweite .. Sichtweite loop
               
               if GlobaleVariablen.StadtGebaut (GlobaleVariablen.Rasse, A).YAchse + Y > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße or GlobaleVariablen.StadtGebaut (GlobaleVariablen.Rasse, A).YAchse + Y < Karten.Karten'First (1) then
                  null;

               elsif GlobaleVariablen.StadtGebaut (GlobaleVariablen.Rasse, A).XAchse + X > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße then
                  Wert := GlobaleVariablen.StadtGebaut (GlobaleVariablen.Rasse, A).XAchse + X - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
                  for B in Karten.Karten'First (2) .. Wert loop
                  
                     Karten.Karten (GlobaleVariablen.StadtGebaut (GlobaleVariablen.Rasse, A).YAchse + Y, B).Sichtbar := True;
                  
                  end loop;
                  
               elsif GlobaleVariablen.StadtGebaut (GlobaleVariablen.Rasse, A).XAchse + X < Karten.Karten'First (2) then
                  Wert := GlobaleVariablen.StadtGebaut (GlobaleVariablen.Rasse, A).XAchse + X + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
                  for B in Wert .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
                  
                     Karten.Karten (GlobaleVariablen.StadtGebaut (GlobaleVariablen.Rasse, A).YAchse + Y, B).Sichtbar := True;
                  
                  end loop;
                  
               else
                  Karten.Karten (GlobaleVariablen.StadtGebaut (GlobaleVariablen.Rasse, A).YAchse + Y, GlobaleVariablen.StadtGebaut (GlobaleVariablen.Rasse, A).XAchse + X).Sichtbar := True;
               end if;  
            
            end loop XÄnderungStadtSchleife;
         end loop YÄnderungStadtSchleife;
      end loop StadtPlätzeSchleife;
      
   end Sichtbarkeit;

end Sichtbarkeit;
