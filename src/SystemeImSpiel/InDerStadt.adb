package body InDerStadt is

   procedure InDerStadt (Rasse, StadtPositionInListe : in Integer) is
   begin
      
      StadtSchleife:
      loop
    
         Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
         KarteStadt.AnzeigeStadt (Stadtnummer => StadtPositionInListe);
         New_Line;  

         Get_Immediate (Item => Taste);
         
         case To_Lower (Item => Taste) is
            when 'w' | 's' | 'a' | 'd' | '1' | '2' | '3' | '4' | '6' | '7' | '8' | '9' =>
               BewegungssystemCursor.BewegungCursorRichtung (Karte => False,
                                                             Richtung => To_Lower (Item => Taste));

            when 'e' => -- Einwohner von Feld entfernen/zuweisen
               if GlobaleVariablen.CursorImSpiel.YAchseStadt < Karten.Stadtkarte'First (1) + 7 and GlobaleVariablen.CursorImSpiel.XAchseStadt > Karten.Stadtkarte'Last (2) - 7 then
                  null;
                  
               else
                  null;
               end if;
               
            when 'b' => -- Gebäude/Einheit bauen
               case GlobaleVariablen.StadtGebaut (Rasse, StadtPositionInListe).AktuellesBauprojekt is
                  when 0 =>
                     Bauen.Bauen (Rasse                => Rasse,
                                  StadtPositionInListe => StadtPositionInListe);
                     
                  when others =>
                     Wahl := Auswahl.Auswahl (WelcheAuswahl => 14,
                                              WelcherText => 18);
                     case Wahl is
                        when -3 =>
                           Bauen.Bauen (Rasse                => Rasse,
                                        StadtPositionInListe => StadtPositionInListe);
                     
                        when others =>
                           null;
                     end case;
               end case;
               
            when 'v' => -- Gebäude verkaufen
               null;

            when 'q' =>
               return;
               
            when others =>
               null;
         end case;
         
      end loop StadtSchleife;
      
   end InDerStadt;
   
   
   
   procedure StadtBauen (Rasse, Listenplatz : in Integer) is
   begin

      BauMöglich := True;
      
      YAchseSchleife:
      for Y in -3 .. 3 loop
         XAchseSchleife:
         for X in -3 .. 3 loop
                     
            if GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse + Y > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße or GlobaleVariablen.StadtGebaut (Rasse, Listenplatz).YAchse + Y < Karten.Karten'First (1) then
               exit XAchseSchleife;

            elsif GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse + X > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße then
               Überhang := GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse + X - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
               BauMöglich := StadtBauenPrüfen (Y => GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse + Y,
                                                 X => Überhang);
                     
                     
            elsif GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse + X < Karten.Karten'First (1) then
               Überhang := GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse + X + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
               BauMöglich := StadtBauenPrüfen (Y => GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse + Y,
                                                 X => Überhang);
                     
            else
               BauMöglich := StadtBauenPrüfen (Y => GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse + Y,
                                                 X => GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse + X);
            end if;

            case BauMöglich is
               when True =>
                  null;
                  
               when False =>                  
                  Fehlermeldungen.Fehlermeldungen (WelcheFehlermeldung => 6);
                  return;
            end case;
         
         end loop XAchseSchleife;
      end loop YAchseSchleife;

      for A in GlobaleVariablen.StadtGebaut'Range (2) loop
         
         if GlobaleVariablen.StadtGebaut (Rasse, A).ID /= 0 then
            null;
            
         elsif A = GlobaleVariablen.StadtGebaut'Last (2) and GlobaleVariablen.StadtGebaut (Rasse, A).ID /= 0 then
            Fehlermeldungen.Fehlermeldungen (WelcheFehlermeldung => 7);
            
         else
            if A = 1 and Rasse = GlobaleVariablen.Rasse then
               Stadtart := 1;
               
            elsif Rasse = GlobaleVariablen.Rasse then
               Stadtart := 2;
               
            elsif A = 1 and Rasse /= GlobaleVariablen.Rasse then
               Stadtart := 3;
               
            else
               Stadtart := 4;
            end if;

            GlobaleVariablen.StadtGebaut (Rasse, A) := 
              (Stadtart, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse, False, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0,
               "000000000000000000000000", To_Unbounded_Wide_Wide_String (Source => "Name"),
               (0 => (0 => True, others => False), 
                others => (others => False)));
               
            YAchsenSchleife:
            for YAchse in -1 .. 1 loop
               XAchsenSchleife:
               for XAchse in -1 .. 1 loop
                  
                  if GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse + YAchse > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
                    or GlobaleVariablen.StadtGebaut (Rasse, Listenplatz).YAchse + YAchse < Karten.Karten'First (1) then
                     exit XAchsenSchleife;

                  elsif GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse + XAchse > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße then
                     Überhang := GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse + XAchse - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
                     if Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse + YAchse, Überhang).Grund = 2
                       or (Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse + YAchse, Überhang).Grund >= 29
                           and Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse + YAchse, Überhang).Grund <= 31) then
                        GlobaleVariablen.StadtGebaut (Rasse, A).AmWasser := True;
                        exit YAchsenSchleife;
                        
                     else
                        null;
                     end if;
                     
                  elsif GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse + XAchse < Karten.Karten'First (1) then
                     Überhang := GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse + XAchse + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
                     if Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse + YAchse, Überhang).Grund = 2
                       or (Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse + YAchse, Überhang).Grund >= 29
                           and Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse + YAchse, Überhang).Grund <= 31) then
                        GlobaleVariablen.StadtGebaut (Rasse, A).AmWasser := True;
                        exit YAchsenSchleife;
                        
                     else
                        null;
                     end if;
                     
                  else                         
                     if Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse + YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse + XAchse).Grund = 2
                       or (Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse + YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse + XAchse).Grund >= 29
                           and Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse + YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse + XAchse).Grund <= 31) then
                        GlobaleVariablen.StadtGebaut (Rasse, A).AmWasser := True;
                        exit YAchsenSchleife;
                        
                     else
                        null;
                     end if;
                  end if;
                  
               end loop XAchsenSchleife;
            end loop YAchsenSchleife;
            
            GlobaleVariablen.StadtGebaut (Rasse, A).AktuelleNahrungsproduktion := 
              KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse).Grund).Nahrungsgewinnung;
            GlobaleVariablen.StadtGebaut (Rasse, A).AktuelleProduktionrate := 
              KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse).Grund).Ressourcengewinnung;
            GlobaleVariablen.StadtGebaut (Rasse, A).AktuelleGeldgewinnung := 
              KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse).Grund).Geldgewinnung;
            GlobaleVariablen.StadtGebaut (Rasse, A).AktuelleForschungsrate := 
              KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse).Grund).Wissensgewinnung;

            EinheitenDatenbank.EinheitEntfernen (Rasse => Rasse,
                                                 Platznummer => Listenplatz);
            
            if Rasse = GlobaleVariablen.Rasse then
               GlobaleVariablen.StadtGebaut (Rasse, A).Name := Eingabe.StadtName;
               
            else
               null;
            end if;

            

            return;
         end if;
         
      end loop;
                           
   end StadtBauen;



   function StadtBauenPrüfen (Y, X : in Integer) return Boolean is
   begin
      
      RassenSchleife:
      for A in GlobaleVariablen.StadtGebaut'Range (1) loop
         StadtSchleife:
         for B in GlobaleVariablen.StadtGebaut'Range (2) loop
            
            if GlobaleVariablen.StadtGebaut (A, B).ID = 0 then
               exit StadtSchleife;
               
            elsif GlobaleVariablen.StadtGebaut (A, B).YAchse = Y and GlobaleVariablen.StadtGebaut (A, B).XAchse = X then
               return False;
               
            else
               null;
            end if;
            
         end loop StadtSchleife;
      end loop RassenSchleife;

      return True;
      
   end StadtBauenPrüfen;   

end InDerStadt;
