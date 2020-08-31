package body Karte is

   procedure AnzeigeKarte is
   begin           
      
      if GlobaleVariablen.CursorImSpiel.YAchse > GlobaleVariablen.CursorImSpiel.YAchseAlt + Bewegungsfeld or GlobaleVariablen.CursorImSpiel.YAchse < GlobaleVariablen.CursorImSpiel.YAchseAlt - Bewegungsfeld then
         GlobaleVariablen.CursorImSpiel.YAchseAlt := GlobaleVariablen.CursorImSpiel.YAchse;

      elsif GlobaleVariablen.CursorImSpiel.XAchse > GlobaleVariablen.CursorImSpiel.XAchseAlt + Bewegungsfeld or GlobaleVariablen.CursorImSpiel.XAchse < GlobaleVariablen.CursorImSpiel.XAchseAlt - Bewegungsfeld then
         GlobaleVariablen.CursorImSpiel.XAchseAlt := GlobaleVariablen.CursorImSpiel.XAchse;
         
      else
         null;
      end if;
      
      Put (CSI & "2J" & CSI & "3J" & CSI & "H");

      YAchseSchleife:
      for Y in Karten.Karten'Range (1) loop
         XAchseSchleife:
         for X in Karten.Karten'Range (2) loop
            
            if Y = GlobaleVariablen.CursorImSpiel.YAchse and X = GlobaleVariablen.CursorImSpiel.XAchse then
               if X = Karten.Karten'First (2) and GlobaleVariablen.CursorImSpiel.XAchseAlt - Sichtweite < Karten.Karten'First (2) then
                  Überhang := GlobaleVariablen.CursorImSpiel.XAchseAlt - Sichtweite + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
                  for A in Überhang .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
                  
                     Sichtbarkeit (YAchse => Y, XAchse => A);
                  
                  end loop;                  
                  Put (CSI & "5m" & GlobaleVariablen.CursorImSpiel.CursorGrafik & CSI & "0m");

               elsif X = Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße and GlobaleVariablen.CursorImSpiel.XAchseAlt + Sichtweite > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße then
                  Put (CSI & "5m" & GlobaleVariablen.CursorImSpiel.CursorGrafik & CSI & "0m");
                  Überhang := GlobaleVariablen.CursorImSpiel.XAchseAlt + Sichtweite - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
                  for A in Karten.Karten'First (2) .. Überhang loop
                  
                     Sichtbarkeit (YAchse => Y, XAchse => A);
                  
                  end loop;
                  New_Line;
                  exit XAchseSchleife;

               else
                  Put (CSI & "5m" & GlobaleVariablen.CursorImSpiel.CursorGrafik & CSI & "0m");
               end if;

            elsif Y < GlobaleVariablen.CursorImSpiel.YAchseAlt - Sichtweite then
               exit XAchseSchleife;

            elsif Y > GlobaleVariablen.CursorImSpiel.YAchseAlt + Sichtweite then
               New_Line;
               exit YAchseSchleife;

            elsif Karten.Karten (Y, X).Grund = -2 then
               New_Line;
               exit YAchseSchleife;

            elsif X < GlobaleVariablen.CursorImSpiel.XAchseAlt - Sichtweite then
               null;

            elsif X > GlobaleVariablen.CursorImSpiel.XAchseAlt + Sichtweite then
               New_Line;
               exit XAchseSchleife;

            elsif Karten.Karten (Y, X).Grund = -1 then
               New_Line;
               exit XAchseSchleife;
               
            elsif X = Karten.Karten'First (2) and GlobaleVariablen.CursorImSpiel.XAchseAlt - Sichtweite < Karten.Karten'First (2) then
               Überhang := GlobaleVariablen.CursorImSpiel.XAchseAlt - Sichtweite + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
               for A in Überhang .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
                  
                  Sichtbarkeit (YAchse => Y, XAchse => A);
                  
               end loop;
               Sichtbarkeit (YAchse => Y, XAchse => X);

            elsif X = Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße and GlobaleVariablen.CursorImSpiel.XAchseAlt + Sichtweite > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße then
               Sichtbarkeit (YAchse => Y, XAchse => X);
               Überhang := GlobaleVariablen.CursorImSpiel.XAchseAlt + Sichtweite - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
               for A in Karten.Karten'First (2) .. Überhang loop
                  
                  Sichtbarkeit (YAchse => Y, XAchse => A);
                  
               end loop;
               New_Line;
               exit XAchseSchleife;
            
            else
               Sichtbarkeit (YAchse => Y, XAchse => X);
            end if;

         end loop XAchseSchleife;
      end loop YAchseSchleife;
         
      Information;

   end AnzeigeKarte;
   
   
   
   procedure AnzeigeStadt (Stadtnummer : in Integer) is
   begin

      Put (CSI & "2J" & CSI & "3J" & CSI & "H");

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
                  New_Line;
                  exit XAchseSchleife;

               elsif Stadtumgebungsgröße = 1 and Y < 3 then
                  New_Line;
                  exit XAchseSchleife;

               elsif Stadtumgebungsgröße = 2 and Y < 2 then
                  New_Line;
                  exit XAchseSchleife;
                  
               else
                  ÜberhangDurchlaufenLinks := False;
                  if Stadtumgebungsgröße = 1 and X < Karten.Stadtkarte'Last (2) - 4 then
                     Put (" ");
                     
                  elsif Stadtumgebungsgröße = 2 and X < Karten.Stadtkarte'Last (2) - 5 then
                     Put (" ");
                     
                  else
                     UmgebungsSchleife:
                     for A in -Stadtumgebungsgröße .. Stadtumgebungsgröße loop

                        if GlobaleVariablen.CursorImSpiel.YAchse + YAchsenabstraktion < Karten.Karten'First (1) or GlobaleVariablen.CursorImSpiel.YAchse + YAchsenabstraktion > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße then
                           exit UmgebungsSchleife;

                        elsif GlobaleVariablen.CursorImSpiel.XAchse + A < Karten.Karten'First (2) then
                           case ÜberhangDurchlaufenLinks is
                              when False =>
                                 Überhang := GlobaleVariablen.CursorImSpiel.XAchse + A + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
                                 for B in Überhang .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
                  
                                    Sichtbarkeit (YAchse => GlobaleVariablen.CursorImSpiel.YAchse + YAchsenabstraktion, XAchse => B);
                  
                                 end loop;
                                 ÜberhangDurchlaufenLinks := True;

                              when True =>
                                 null;
                           end case;
                           
                        elsif GlobaleVariablen.CursorImSpiel.XAchse + A > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße and A < Stadtumgebungsgröße then
                           null;
                           
                        elsif GlobaleVariablen.CursorImSpiel.XAchse + A > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße then
                           Überhang := GlobaleVariablen.CursorImSpiel.XAchse + A - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
                           for B in Karten.Karten'First (2) .. Überhang loop
                  
                              Sichtbarkeit (YAchse => GlobaleVariablen.CursorImSpiel.YAchse + YAchsenabstraktion, XAchse => B);
                  
                           end loop;

                        else
                           Sichtbarkeit (YAchse => GlobaleVariablen.CursorImSpiel.YAchse + YAchsenabstraktion, XAchse => GlobaleVariablen.CursorImSpiel.XAchse + A);
                        end if;

                     end loop UmgebungsSchleife;

                     New_Line;
                     YAchsenabstraktion := YAchsenabstraktion + 1;
                     exit XAchseSchleife;
                  end if;
               end if;
               
            elsif Y = GlobaleVariablen.CursorImSpiel.YAchseStadt and X = GlobaleVariablen.CursorImSpiel.XAchseStadt then
               Put (CSI & "5m" & GlobaleVariablen.CursorImSpiel.CursorGrafik & CSI & "0m");

            else
               if X = Karten.Stadtkarte'Last (2) then
                  Put (" ");
                  New_Line;

               else
                  Put (" ");
               end if;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
         
   end AnzeigeStadt;



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
                  Farben (Einheit => GlobaleVariablen.EinheitenGebaut (A, B).ID, Verbesserung => 0, Ressource => 0, Grund => Karten.Karten (YAchse, XAchse).Grund);
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
                  Farben (Einheit => 0, Verbesserung => GlobaleVariablen.StadtGebaut (C, D).ID, Ressource => 0, Grund => Karten.Karten (YAchse, XAchse).Grund);
                  return;
               
               else
                  null;
               end if;
               
            end loop StädtePrüfenSchleife;
         end loop RassenStädtePrüfenSchleife;

         if Karten.Karten (YAchse, XAchse).VerbesserungGebiet /= 0 then            
            Farben (Einheit => 0, Verbesserung => Karten.Karten (YAchse, XAchse).VerbesserungGebiet, Ressource => 0, Grund => Karten.Karten (YAchse, XAchse).Grund);
           
         elsif Karten.Karten (YAchse, XAchse).VerbesserungStraße /= 0 then
            Farben (Einheit => 0, Verbesserung => Karten.Karten (YAchse, XAchse).VerbesserungStraße, Ressource => 0, Grund => Karten.Karten (YAchse, XAchse).Grund);
            
         elsif Karten.Karten (YAchse, XAchse).Ressource /= 0 then
            Farben (Einheit => 0, Verbesserung => 0, Ressource => Karten.Karten (YAchse, XAchse).Ressource, Grund => Karten.Karten (YAchse, XAchse).Grund);
            
         elsif Karten.Karten (YAchse, XAchse).Fluss /= 0 then
            Farben (Einheit => 0, Verbesserung => 0, Ressource => Karten.Karten (YAchse, XAchse).Fluss, Grund => Karten.Karten (YAchse, XAchse).Grund);
            
         else
            Farben (Einheit => 0, Verbesserung => 0, Ressource => 0, Grund => Karten.Karten (YAchse, XAchse).Grund);
         end if;
         
      else
         Put (NichtSichtbar);
      end if;
      
   end Sichtbarkeit;



   procedure Farben (Einheit, Verbesserung, Ressource, Grund : in Integer) is
   begin

      case Einheit is
         when EinheitenDatenbank.EinheitenListe'Range =>
            Put (CSI & "38;2;0;0;0m");
            
         when others =>
            null;
      end case;
      
      case Verbesserung is
         when 1 =>
            Put (CSI & "38;2;0;0;0m");
         
         when 2 =>
            Put (CSI & "38;2;0;0;0m");
            
         when 3 =>
            Put (CSI & "38;2;0;0;0m");
            
         when 4 =>
            Put (CSI & "38;2;0;0;0m");
            
         when 5 .. 19 =>
            Put (CSI & "38;2;0;0;0m");

         when 20 =>
            Put (CSI & "38;2;0;0;0m");
            
         when 21 =>
            Put (CSI & "38;2;0;0;0m");
            
         when 22 =>
            Put (CSI & "38;2;0;0;0m");
            
         when others =>
            null;
      end case;
      
      case Ressource is
         when 10 =>
            Put (CSI & "38;2;255;255;255m");

         when 11 =>
            Put (CSI & "38;2;255;255;255m");

         when 12 =>
            Put (CSI & "38;2;255;255;255m");

         when 13 =>
            Put (CSI & "38;2;255;255;255m");

         when 29 => 
            Put (CSI & "38;2;255;255;255m");

         when 30 =>
            Put (CSI & "38;2;255;255;255m");
            
         when others =>
            null;
      end case;
      
      case Grund is
         when 1 =>
            Put (CSI & "48;2;255;245;238m");
            
         when 2 =>
            Put (CSI & "48;2;0;0;205m");
            
         when 3 =>
            Put (CSI & "48;2;100;160;60m");
            
         when 4 =>
            Put (CSI & "48;2;205;200;177m");
            
         when 5 =>
            Put (CSI & "48;2;238;238;0m");
            
         when 6 =>
            Put (CSI & "48;2;205;133;63m");
            
         when 7 =>
            Put (CSI & "48;2;120;120;120m");
            
         when 8 =>
            Put (CSI & "48;2;30;130;30m");
            
         when 9 =>
            Put (CSI & "48;2;0;70;0m");
            
         when 31 =>
            Put (CSI & "48;2;135;206;250m");
            
         when 32 =>
            Put (CSI & "48;2;0;0;0m"); -- Platzhalterfarbe
            
         when others =>
            Put (CSI & "48;2;0;0;0m");  -- Noch Farben für die restlichen Landschaften, Verbesserungen, Einheiten, Städt, usw. einfügen.
      end case;
      
      if Einheit /= 0 then
         Put (EinheitenDatenbank.EinheitenListe (Einheit).Anzeige & CSI & "0m");
        
      elsif Verbesserung /= 0 then
         Put (VerbesserungenDatenbank.VerbesserungObjektListe (Verbesserung).Anzeige & CSI & "0m");

      elsif Ressource /= 0 then
         Put (KartenDatenbank.KartenObjektListe (Ressource).Anzeige & CSI & "0m");
            
      else         
         Put (KartenDatenbank.KartenObjektListe (Grund).Anzeige & CSI & "0m");
      end if;
      
   end Farben;
   


   procedure Information is
   begin
      
      case Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Sichtbar is
         when True =>
            RassenEinheitenSchleife:
            for A in GlobaleVariablen.EinheitenGebaut'Range (1) loop
               EinheitenSchleife:
               for B in GlobaleVariablen.EinheitenGebaut'Range (2) loop
         
                  case GlobaleVariablen.EinheitenGebaut (A, B).ID is
                     when 0 =>
                        exit EinheitenSchleife;
                  
                     when others =>
                        if GlobaleVariablen.EinheitenGebaut (A, B).YAchse = GlobaleVariablen.CursorImSpiel.YAchse and GlobaleVariablen.EinheitenGebaut (A, B).XAchse = GlobaleVariablen.CursorImSpiel.XAchse then
                           EinheitenDatenbank.Beschreibung (GlobaleVariablen.EinheitenGebaut (A, B).ID);                        
                           Put ("    " & To_Wide_Wide_String (Einlesen.TexteEinlesen (19, 14)));
                           Put_Line (GlobaleVariablen.EinheitenGebaut (A, B).AktuelleLebenspunkte'Wide_Wide_Image & " /" & EinheitenDatenbank.EinheitenListe (GlobaleVariablen.EinheitenGebaut (A, B).ID).MaximaleLebenspunkte'Wide_Wide_Image);
                        
                           if A = GlobaleVariablen.Rasse then
                              Put ("           " & To_Wide_Wide_String (Einlesen.TexteEinlesen (19, 15)));
                              Put (GlobaleVariablen.EinheitenGebaut (A, B).AktuelleBewegungspunkte'Wide_Wide_Image & " /" & EinheitenDatenbank.EinheitenListe (GlobaleVariablen.EinheitenGebaut (A, B).ID).MaximaleBewegungspunkte'Wide_Wide_Image);
                              Put ("    " & To_Wide_Wide_String (Einlesen.TexteEinlesen (19, 16)));
                              Put_Line (GlobaleVariablen.EinheitenGebaut (A, B).AktuelleErfahrungspunkte'Wide_Wide_Image & " /" & EinheitenDatenbank.EinheitenListe (GlobaleVariablen.EinheitenGebaut (A, B).ID).Beförderungsgrenze'Wide_Wide_Image);
                              
                              Put ("           " & To_Wide_Wide_String (Einlesen.TexteEinlesen (19, 17)));
                              EinheitenDatenbank.Beschäftigung (GlobaleVariablen.EinheitenGebaut (A, B).AktuelleBeschäftigung);
                              Put ("    " & To_Wide_Wide_String (Einlesen.TexteEinlesen (19, 18)));
                              Put_Line (GlobaleVariablen.EinheitenGebaut (A, B).AktuelleBeschäftigungszeit'Wide_Wide_Image);
                              
                           else
                              null;
                           end if;
                        
                           exit RassenEinheitenSchleife;
                                         
                        else
                           null;
                        end if;                  
                  end case;                  
                                                   
               end loop EinheitenSchleife;
            end loop RassenEinheitenSchleife;
            
            RassenStadtSchleife:
            for C in GlobaleVariablen.StadtGebaut'Range (1) loop
               StadtSchleife:
               for D in GlobaleVariablen.StadtGebaut'Range (2) loop
            
                  case GlobaleVariablen.StadtGebaut (C, D).ID is
                     when 0 =>
                        exit StadtSchleife;
                  
                     when others =>
                        if GlobaleVariablen.StadtGebaut (C, D).YAchse = GlobaleVariablen.CursorImSpiel.YAchse and GlobaleVariablen.StadtGebaut (C, D).XAchse = GlobaleVariablen.CursorImSpiel.XAchse then
                           Put (To_Wide_Wide_String (Einlesen.TexteEinlesen (19, GlobaleVariablen.StadtGebaut (C, D).ID)));
                           Put (To_Wide_Wide_String (GlobaleVariablen.StadtGebaut (C, D).Name) & "    ");
                           Put (To_Wide_Wide_String (Einlesen.TexteEinlesen (19, 5)));
                           Put_Line (GlobaleVariablen.StadtGebaut (C, D).Einwohner'Wide_Wide_Image);
                     
                           if C = GlobaleVariablen.Rasse then
                              Put ("       " & To_Wide_Wide_String (Einlesen.TexteEinlesen (19, 6)));
                              Put (GlobaleVariablen.StadtGebaut (C, D).AktuelleNahrungsmittel'Wide_Wide_Image);
                              Put ("    " & To_Wide_Wide_String (Einlesen.TexteEinlesen (19, 7)));
                              Put_Line (GlobaleVariablen.StadtGebaut (C, D).AktuelleNahrungsproduktion'Wide_Wide_Image);
                        
                              Put ("       " & To_Wide_Wide_String (Einlesen.TexteEinlesen (19, 8)));
                              Put (GlobaleVariablen.StadtGebaut (C, D).AktuelleProduktionrate'Wide_Wide_Image);
                              Put ("    " & To_Wide_Wide_String (Einlesen.TexteEinlesen (19, 9)));
                              Put_Line (GlobaleVariablen.StadtGebaut (C, D).AktuelleGeldgewinnung'Wide_Wide_Image);

                              Put ("       " & To_Wide_Wide_String (Einlesen.TexteEinlesen (19, 10)));
                              Put (GlobaleVariablen.StadtGebaut (C, D).AktuelleForschungsrate'Wide_Wide_Image);                        
                              Put ("    " & To_Wide_Wide_String (Einlesen.TexteEinlesen (19, 11)));
                              Put_Line (GlobaleVariablen.StadtGebaut (C, D).Korruption'Wide_Wide_Image);
                        
                              Put ("       " & To_Wide_Wide_String (Einlesen.TexteEinlesen (19, 12)));
                              Put (GlobaleVariablen.StadtGebaut (C, D).AktuellesBauprojekt'Wide_Wide_Image);                       
                              Put_Line ("    " & To_Wide_Wide_String (Einlesen.TexteEinlesen (19, 13)));                        

                           else
                              null;
                           end if;
                     
                           exit RassenStadtSchleife;
                     
                        else
                           null;
                        end if;
                  end case;

               end loop StadtSchleife;
            end loop RassenStadtSchleife;  
      
            if Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).VerbesserungStraße /= 0 then
               VerbesserungenDatenbank.Beschreibung (ID => Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).VerbesserungStraße);
         
            else
               null;
            end if;
      
            if Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).VerbesserungGebiet /= 0 then
               VerbesserungenDatenbank.Beschreibung (ID => Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).VerbesserungGebiet);
         
            else
               null;
            end if;
      
            if Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Fluss /= 0 then
               KartenDatenbank.Beschreibung (ID => Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Fluss);
         
            else
               null;
            end if;
      
            if Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Ressource /= 0 then
               KartenDatenbank.Beschreibung (ID => Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Ressource);
         
            else
               null;
            end if;
                  
            if Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Hügel = True and Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Grund /= 6 then
               Put ("Hügel mit ");
               KartenDatenbank.Beschreibung (ID => Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Grund);
         
            elsif Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Hügel = True then
               KartenDatenbank.Beschreibung (ID => Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Grund);
         
            else         
               KartenDatenbank.Beschreibung (ID => Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Grund);         
            end if;
            
         when False =>
            null;
      end case;
      
   end Information;

end Karte;
