package body KarteStadt is

   procedure AnzeigeStadt (Stadtnummer : in Integer) is
   begin

      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");

      if ForschungsDatenbank.Erforscht (GlobaleVariablen.Rasse) (5) /= '0' and GlobaleVariablen.StadtGebaut (GlobaleVariablen.Rasse, Stadtnummer).Einwohner >= 10 then
         Stadtumgebungsgröße := 2;

      elsif ForschungsDatenbank.Erforscht (GlobaleVariablen.Rasse) (10) /= '0' and GlobaleVariablen.StadtGebaut (GlobaleVariablen.Rasse, Stadtnummer).Einwohner >= 20 then
         Stadtumgebungsgröße := 3;
                  
      else
         Stadtumgebungsgröße := 1;
      end if;

      YAchsenabstraktion := -Stadtumgebungsgröße;
      
      YAchseSchleife:
      for Y in Karten.Stadtkarte'Range (1) loop
         XAchseSchleife:
         for X in Karten.Stadtkarte'Range (2) loop
                        
            if X > Karten.Stadtkarte'Last (2) - 7 and Y < Karten.Stadtkarte'First (1) + 7 then
               if YAchsenabstraktion > Stadtumgebungsgröße then
                  for A in 1 .. 7 loop
                     
                     Put (Item => " ");
                     
                  end loop;
                  
                  New_Line;
                  exit XAchseSchleife;

               elsif Stadtumgebungsgröße = 1 and Y < 3 then
                  for A in 1 .. 7 loop
                     
                     Put (Item => " ");
                     
                  end loop;
                  
                  New_Line;
                  exit XAchseSchleife;

               elsif Stadtumgebungsgröße = 2 and Y < 2 then
                  for A in 1 .. 7 loop
                     
                     Put (Item => " ");
                     
                  end loop;
                  
                  New_Line;
                  exit XAchseSchleife;
                  
               else
                  if Stadtumgebungsgröße = 1 and X < Karten.Stadtkarte'Last (2) - 4 then -- Wenn loop von 1 .. 7 dann muss das raus,
                                                                                           -- bei loop von -Stadtumgebungsgröße .. Stadtumgebungsgröße muss noch was rein für den Fall größer
                     Put (Item => " ");
                     
                  elsif Stadtumgebungsgröße = 2 and X < Karten.Stadtkarte'Last (2) - 5 then -- Wenn loop von 1 .. 7 dann muss das raus,
                                                                                              -- bei loop von -Stadtumgebungsgröße .. Stadtumgebungsgröße muss noch was rein für den Fall größer
                     Put (Item => " ");
                     
                  else
                     UmgebungsSchleife:
                     for A in -Stadtumgebungsgröße .. Stadtumgebungsgröße loop

                        if GlobaleVariablen.CursorImSpiel.YAchse + YAchsenabstraktion < Karten.Karten'First (1) or GlobaleVariablen.CursorImSpiel.YAchse + YAchsenabstraktion > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße then
                           exit UmgebungsSchleife;

                        elsif GlobaleVariablen.CursorImSpiel.XAchse + A < Karten.Karten'First (2) then
                           Überhang := GlobaleVariablen.CursorImSpiel.XAchse + A + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
                           Sichtbarkeit.Sichtbarkeit (YAchse => GlobaleVariablen.CursorImSpiel.YAchse + YAchsenabstraktion,
                                                      XAchse => Überhang);
                           
                        elsif GlobaleVariablen.CursorImSpiel.XAchse + A > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße and A < Stadtumgebungsgröße then
                           null;
                           
                        elsif GlobaleVariablen.CursorImSpiel.XAchse + A > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße then
                           Überhang := GlobaleVariablen.CursorImSpiel.XAchse + A - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
                              Sichtbarkeit.Sichtbarkeit (YAchse => GlobaleVariablen.CursorImSpiel.YAchse + YAchsenabstraktion,
                                                         XAchse => Überhang);
                        else
                           Sichtbarkeit.Sichtbarkeit (YAchse => GlobaleVariablen.CursorImSpiel.YAchse + YAchsenabstraktion,
                                                      XAchse => GlobaleVariablen.CursorImSpiel.XAchse + A);
                        end if;

                     end loop UmgebungsSchleife;

                     New_Line;
                     YAchsenabstraktion := YAchsenabstraktion + 1;
                     exit XAchseSchleife;
                  end if;
               end if;
               
            elsif Y = GlobaleVariablen.CursorImSpiel.YAchseStadt and X = GlobaleVariablen.CursorImSpiel.XAchseStadt then
               Put (Item => CSI & "5m" & GlobaleVariablen.CursorImSpiel.CursorGrafik & CSI & "0m");

            else
               Sichtbarkeit.Farben (Einheit      => 0,
                                    Verbesserung => 0,
                                    Ressource    => 0,
                                    Grund        => Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Grund);
            end if;

            case X is
               when Karten.Stadtkarte'Last (2) =>
                  New_Line;
                  
               when others =>
                  null;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
         
   end AnzeigeStadt;



   procedure FarbenStadt is
   begin
      
      null;
      
   end FarbenStadt;
   
   
   
   procedure InformationenStadt is
   begin
      
      null;
      
   end InformationenStadt;

end KarteStadt;
