package body Sichtbarkeit is

   procedure Sichtbarkeitsprüfung is
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
      
   end Sichtbarkeitsprüfung;



   procedure Sichtbarkeit (YAchse, XAchse : in Integer) is
   begin
      
      -- Über den Kartenfeldern kommen die Kartenressourcen
      -- Über den Kartenressourcen kommen die Kartenverbesserungen
      -- Über die Kartenverbesserungen kommen die Städte
      -- Über die Städte kommen die Einheiten
       
      if Karten.Karten (YAchse, XAchse).Sichtbar = True then
         RassenEinheitenPrüfenSchleife:
         for A in GlobaleVariablen.EinheitenGebaut'Range (1) loop
            EinheitenPrüfenSchleife:
            for B in GlobaleVariablen.EinheitenGebaut'Range (2) loop
            
               if GlobaleVariablen.EinheitenGebaut (A, B).ID = 0 then
                  exit EinheitenPrüfenSchleife;
               
               elsif GlobaleVariablen.EinheitenGebaut (A, B).YAchse = YAchse and GlobaleVariablen.EinheitenGebaut (A, B).XAchse = XAchse then
                  Farben (Einheit => GlobaleVariablen.EinheitenGebaut (A, B).ID,
                          Verbesserung => 0,
                          Ressource => 0,
                          Grund => Karten.Karten (YAchse, XAchse).Grund);
                  return;
               
               else
                  null;
               end if;
            
            end loop EinheitenPrüfenSchleife;
         end loop RassenEinheitenPrüfenSchleife;

         RassenStädtePrüfenSchleife:
         for C in GlobaleVariablen.StadtGebaut'Range (1) loop
            StädtePrüfenSchleife:
            for D in GlobaleVariablen.StadtGebaut'Range (2) loop
            
               if GlobaleVariablen.StadtGebaut (C, D).ID = 0 then
                  exit StädtePrüfenSchleife;

               elsif GlobaleVariablen.StadtGebaut (C, D).YAchse = YAchse and GlobaleVariablen.StadtGebaut (C, D).XAchse = XAchse then
                  Farben (Einheit => 0,
                          Verbesserung => GlobaleVariablen.StadtGebaut (C, D).ID,
                          Ressource => 0,
                          Grund => Karten.Karten (YAchse, XAchse).Grund);
                  return;
               
               else
                  null;
               end if;
               
            end loop StädtePrüfenSchleife;
         end loop RassenStädtePrüfenSchleife;

         if Karten.Karten (YAchse, XAchse).VerbesserungGebiet /= 0 then            
            Farben (Einheit => 0,
                    Verbesserung => Karten.Karten (YAchse, XAchse).VerbesserungGebiet,
                    Ressource => 0,
                    Grund => Karten.Karten (YAchse, XAchse).Grund);
           
         elsif Karten.Karten (YAchse, XAchse).VerbesserungStraße /= 0 then
            Farben (Einheit => 0,
                    Verbesserung => Karten.Karten (YAchse, XAchse).VerbesserungStraße,
                    Ressource => 0,
                    Grund => Karten.Karten (YAchse, XAchse).Grund);
            
         elsif Karten.Karten (YAchse, XAchse).Ressource /= 0 then
            Farben (Einheit => 0,
                    Verbesserung => 0,
                    Ressource => Karten.Karten (YAchse, XAchse).Ressource,
                    Grund => Karten.Karten (YAchse, XAchse).Grund);
            
         elsif Karten.Karten (YAchse, XAchse).Fluss /= 0 then
            Farben (Einheit => 0,
                    Verbesserung => 0,
                    Ressource => Karten.Karten (YAchse, XAchse).Fluss,
                    Grund => Karten.Karten (YAchse, XAchse).Grund);
            
         else
            Farben (Einheit => 0,
                    Verbesserung => 0,
                    Ressource => 0,
                    Grund => Karten.Karten (YAchse, XAchse).Grund);
         end if;
         
      else
         Put (Item => NichtSichtbar);
      end if;
      
   end Sichtbarkeit;



   procedure Farben (Einheit, Verbesserung, Ressource, Grund : in Integer) is
   begin

      case Einheit is
         when EinheitenDatenbank.EinheitenListe'Range =>
            Put (Item => CSI & "38;2;0;0;0m");
            
         when others =>
            null;
      end case;
      
      case Verbesserung is
         when 1 =>
            Put (Item => CSI & "38;2;0;0;0m");
         
         when 2 =>
            Put (Item => CSI & "38;2;0;0;0m");
            
         when 3 =>
            Put (Item => CSI & "38;2;0;0;0m");
            
         when 4 =>
            Put (Item => CSI & "38;2;0;0;0m");
            
         when 5 .. 19 =>
            Put (Item => CSI & "38;2;0;0;0m");

         when 20 =>
            Put (Item => CSI & "38;2;0;0;0m");
            
         when 21 =>
            Put (Item => CSI & "38;2;0;0;0m");
            
         when 22 =>
            Put (Item => CSI & "38;2;0;0;0m");
            
         when others =>
            null;
      end case;
      
      case Ressource is
         when 10 =>
            Put (Item => CSI & "38;2;0;0;0m");

         when 11 =>
            Put (Item => CSI & "38;2;0;0;0m");

         when 12 =>
            Put (Item => CSI & "38;2;0;0;0m");

         when 13 =>
            Put (Item => CSI & "38;2;0;0;0m");

         when 29 => 
            Put (Item => CSI & "38;2;255;255;255m");

         when 30 =>
            Put (Item => CSI & "38;2;255;255;255m");

         when 33 =>
            Put (Item => CSI & "38;2;0;0;0m");
            
         when others =>
            null;
      end case;
      
      case Grund is
         when 1 =>
            Put (Item => CSI & "48;2;255;245;238m");
            
         when 2 =>
            Put (Item => CSI & "48;2;0;0;205m");
            
         when 3 =>
            Put (Item => CSI & "48;2;100;160;60m");
            
         when 4 =>
            Put (Item => CSI & "48;2;205;200;177m");
            
         when 5 =>
            Put (Item => CSI & "48;2;238;238;0m");
            
         when 6 =>
            Put (Item => CSI & "48;2;205;133;63m");
            
         when 7 =>
            Put (Item => CSI & "48;2;120;120;120m");
            
         when 8 =>
            Put (Item => CSI & "48;2;30;130;30m");
            
         when 9 =>
            Put (Item => CSI & "48;2;0;70;0m");
            
         when 31 =>
            Put (Item => CSI & "48;2;135;206;250m");
            
         when 32 =>
            Put (Item => CSI & "48;2;0;40;0m");
            
         when others =>
            Put (Item => CSI & "48;2;0;0;0m");
      end case;
      
      if Einheit /= 0 then
         Put (Item => EinheitenDatenbank.EinheitenListe (Einheit).Anzeige & CSI & "0m");
        
      elsif Verbesserung /= 0 then
         Put (Item => VerbesserungenDatenbank.VerbesserungObjektListe (Verbesserung).Anzeige & CSI & "0m");

      elsif Ressource /= 0 then
         Put (Item => KartenDatenbank.KartenObjektListe (Ressource).Anzeige & CSI & "0m");
            
      else         
         Put (Item => KartenDatenbank.KartenObjektListe (Grund).Anzeige & CSI & "0m");
      end if;
      
   end Farben;

end Sichtbarkeit;
