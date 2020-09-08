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
      
      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");

      YAchseSchleife:
      for Y in Karten.Karten'Range (1) loop
         XAchseSchleife:
         for X in Karten.Karten'Range (2) loop
            
            if Y = GlobaleVariablen.CursorImSpiel.YAchse and X = GlobaleVariablen.CursorImSpiel.XAchse then
               if X = Karten.Karten'First (2) and GlobaleVariablen.CursorImSpiel.XAchseAlt - Sichtweite < Karten.Karten'First (2) then
                  Überhang := GlobaleVariablen.CursorImSpiel.XAchseAlt - Sichtweite + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
                  for A in Überhang .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
                  
                     Sichtbarkeit.Sichtbarkeit (YAchse => Y,
                                                XAchse => A);
                  
                  end loop;                  
                  Put (Item => CSI & "5m" & GlobaleVariablen.CursorImSpiel.CursorGrafik & CSI & "0m");

               elsif X = Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße and GlobaleVariablen.CursorImSpiel.XAchseAlt + Sichtweite > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße then
                  Put (Item => CSI & "5m" & GlobaleVariablen.CursorImSpiel.CursorGrafik & CSI & "0m");
                  Überhang := GlobaleVariablen.CursorImSpiel.XAchseAlt + Sichtweite - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
                  for A in Karten.Karten'First (2) .. Überhang loop
                  
                     Sichtbarkeit.Sichtbarkeit (YAchse => Y,
                                                XAchse => A);
                  
                  end loop;
                  New_Line;
                  exit XAchseSchleife;

               else
                  Put (Item => CSI & "5m" & GlobaleVariablen.CursorImSpiel.CursorGrafik & CSI & "0m");
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
                  
                  Sichtbarkeit.Sichtbarkeit (YAchse => Y,
                                             XAchse => A);
                  
               end loop;
               Sichtbarkeit.Sichtbarkeit (YAchse => Y,
                                          XAchse => X);

            elsif X = Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße and GlobaleVariablen.CursorImSpiel.XAchseAlt + Sichtweite > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße then
               Sichtbarkeit.Sichtbarkeit (YAchse => Y, XAchse => X);
               Überhang := GlobaleVariablen.CursorImSpiel.XAchseAlt + Sichtweite - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
               for A in Karten.Karten'First (2) .. Überhang loop
                  
                  Sichtbarkeit.Sichtbarkeit (YAchse => Y,
                                             XAchse => A);
                  
               end loop;
               New_Line;
               exit XAchseSchleife;
            
            else
               Sichtbarkeit.Sichtbarkeit (YAchse => Y,
                                          XAchse => X);
            end if;

         end loop XAchseSchleife;
      end loop YAchseSchleife;
         
      Information;

   end AnzeigeKarte;
   


   procedure Information is
   begin

      Verteidigungsbonus := 0;
      Nahrungsgewinnung := 0;
      Ressourcengewinnung := 0;
      Geldgewinnung := 0;
      Wissensgewinnung := 0;

      Put_Line (Item => "Aktuelle Runde:" & GlobaleVariablen.RundenAnzahl'Wide_Wide_Image);
      New_Line;
      
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
                           Put (Item => "    " & To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (19, 14)));
                           Put_Line (Item => GlobaleVariablen.EinheitenGebaut (A, B).AktuelleLebenspunkte'Wide_Wide_Image & " /" & EinheitenDatenbank.EinheitenListe (GlobaleVariablen.EinheitenGebaut (A, B).ID).MaximaleLebenspunkte'Wide_Wide_Image);
                        
                           if A = GlobaleVariablen.Rasse then
                              Put (Item => "           " & To_Wide_Wide_String (Einlesen.TexteEinlesen (19, 15)));
                              Ada.Float_Text_IO.Put (Item => GlobaleVariablen.EinheitenGebaut (A, B).AktuelleBewegungspunkte,
                                                     Fore => 1,
                                                     Aft  => 1,
                                                     Exp  => 0);
                              Put (Item => " / ");
                              Ada.Float_Text_IO.Put (Item => EinheitenDatenbank.EinheitenListe (GlobaleVariablen.EinheitenGebaut (A, B).ID).MaximaleBewegungspunkte,
                                                     Fore => 1,
                                                     Aft  => 1,
                                                     Exp  => 0);
                              Put (Item => "    " & To_Wide_Wide_String (Einlesen.TexteEinlesen (19, 16)));
                              Put_Line (Item => GlobaleVariablen.EinheitenGebaut (A, B).AktuelleErfahrungspunkte'Wide_Wide_Image & " /" & EinheitenDatenbank.EinheitenListe (GlobaleVariablen.EinheitenGebaut (A, B).ID).Beförderungsgrenze'Wide_Wide_Image);
                              
                              Put (Item => "           " & To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (19, 17)));
                              EinheitenDatenbank.Beschäftigung (GlobaleVariablen.EinheitenGebaut (A, B).AktuelleBeschäftigung);
                              Put (Item => "    " & To_Wide_Wide_String (Einlesen.TexteEinlesen (19, 18)));
                              Put_Line (Item => GlobaleVariablen.EinheitenGebaut (A, B).AktuelleBeschäftigungszeit'Wide_Wide_Image);

                              Put (Item => "           " & To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (19, 24)));
                              Put (Item => EinheitenDatenbank.EinheitenListe (GlobaleVariablen.EinheitenGebaut (A, B).ID).Angriff'Wide_Wide_Image);
                              Put (Item => "    " & To_Wide_Wide_String (Einlesen.TexteEinlesen (19, 25)));
                              Put (Item => EinheitenDatenbank.EinheitenListe (GlobaleVariablen.EinheitenGebaut (A, B).ID).Verteidigung'Wide_Wide_Image);
                              Put (Item => "    " & To_Wide_Wide_String (Einlesen.TexteEinlesen (19, 26)));
                              Put_Line (Item => GlobaleVariablen.EinheitenGebaut (A, B).AktuellerRang'Wide_Wide_Image & " /" & EinheitenDatenbank.EinheitenListe (GlobaleVariablen.EinheitenGebaut (A, B).ID).MaximalerRang'Wide_Wide_Image);
                              
                           else
                              null;
                           end if;
                        
                           New_Line;
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
                           KarteStadt.Beschreibung (Rasse => C, StadtPositionInListe => D);
                           if C = GlobaleVariablen.Rasse then                              
                              Verteidigungsbonus := Verteidigungsbonus + VerbesserungenDatenbank.VerbesserungObjektListe (GlobaleVariablen.StadtGebaut (C, D).ID).Verteidigungsbonus;

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
                  
            if Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Hügel = True and Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Grund /= 6 then
               Put (Item => To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (9, 34)));
               KartenDatenbank.Beschreibung (ID => Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Grund);

               Verteidigungsbonus := Verteidigungsbonus + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Grund).Verteidigungsbonus;
               Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Grund).Nahrungsgewinnung;
               Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Grund).Ressourcengewinnung;
               Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Grund).Geldgewinnung;
               Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Grund).Wissensgewinnung;
         
            elsif Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Hügel = True then
               KartenDatenbank.Beschreibung (ID => Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Grund);

               Verteidigungsbonus := Verteidigungsbonus + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Grund).Verteidigungsbonus;
               Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Grund).Nahrungsgewinnung;
               Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Grund).Ressourcengewinnung;
               Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Grund).Geldgewinnung;
               Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Grund).Wissensgewinnung;
               
            else         
               KartenDatenbank.Beschreibung (ID => Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Grund);

               Verteidigungsbonus := Verteidigungsbonus + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Grund).Verteidigungsbonus;
               Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Grund).Nahrungsgewinnung;
               Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Grund).Ressourcengewinnung;
               Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Grund).Geldgewinnung;
               Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Grund).Wissensgewinnung;
            end if;
      
            if Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Ressource /= 0 then
               KartenDatenbank.Beschreibung (ID => Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Ressource);

               Verteidigungsbonus := Verteidigungsbonus + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Ressource).Verteidigungsbonus;
               Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Ressource).Nahrungsgewinnung;
               Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Ressource).Ressourcengewinnung;
               Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Ressource).Geldgewinnung;
               Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Ressource).Wissensgewinnung;
         
            else
               null;
            end if;
      
            if Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).VerbesserungGebiet /= 0 then
               VerbesserungenDatenbank.Beschreibung (ID => Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).VerbesserungGebiet);

               Verteidigungsbonus := Verteidigungsbonus + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).VerbesserungGebiet).Verteidigungsbonus;
               Nahrungsgewinnung := Nahrungsgewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).VerbesserungGebiet).Nahrungsbonus;
               Ressourcengewinnung := Ressourcengewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).VerbesserungGebiet).Ressourcenbonus;
               Geldgewinnung := Geldgewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).VerbesserungGebiet).Geldbonus;
               Wissensgewinnung := Wissensgewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).VerbesserungGebiet).Wissensbonus;
         
            else
               null;
            end if;
      
            if Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).VerbesserungStraße /= 0 then
               VerbesserungenDatenbank.Beschreibung (ID => Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).VerbesserungStraße);

               Verteidigungsbonus := Verteidigungsbonus + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).VerbesserungStraße).Verteidigungsbonus;
               Nahrungsgewinnung := Nahrungsgewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).VerbesserungStraße).Nahrungsbonus;
               Ressourcengewinnung := Ressourcengewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).VerbesserungStraße).Ressourcenbonus;
               Geldgewinnung := Geldgewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).VerbesserungStraße).Geldbonus;
               Wissensgewinnung := Wissensgewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).VerbesserungStraße).Wissensbonus;
         
            else
               null;
            end if;
      
            if Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Fluss /= 0 then
               KartenDatenbank.Beschreibung (ID => Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Fluss);

               Verteidigungsbonus := Verteidigungsbonus + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Fluss).Verteidigungsbonus;
               Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Fluss).Nahrungsgewinnung;
               Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Fluss).Ressourcengewinnung;
               Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Fluss).Geldgewinnung;
               Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Fluss).Wissensgewinnung;
         
            else
               null;
            end if;
            
            New_Line;
            Put (Item => "       " & To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (19, 19)));
            Put (Item => Verteidigungsbonus'Wide_Wide_Image);
            Put (Item => "    " & To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (19, 20)));
            Put_Line (Item => Nahrungsgewinnung'Wide_Wide_Image);
            Put (Item => "       " & To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (19, 21)));
            Put (Item => Ressourcengewinnung'Wide_Wide_Image);
            Put (Item => "    " & To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (19, 22)));
            Put (Item => Geldgewinnung'Wide_Wide_Image);
            Put (Item => "    " & To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (19, 23)));
            Put_Line (Item => Wissensgewinnung'Wide_Wide_Image);
            
         when False =>
            null;
      end case;
      
   end Information; 
   
end Karte;
