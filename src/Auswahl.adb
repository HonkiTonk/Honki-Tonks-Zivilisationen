package body Auswahl is

   function Auswahl (WelcheAuswahl, WelcherText : in Integer) return Integer is
   begin

      Put (CSI & "2J" & CSI & "3J"  & CSI & "H");

      for A in Einlesen.TexteEinlesen'Range (2) loop
         
         if To_Wide_Wide_String (Einlesen.TexteEinlesen (WelcherText, A)) = "|" then
            exit;
            
         else
            Ende := A;
         end if;
         
      end loop;

      AktuelleAuswahl := 1;
      
      StartauswahlSchleife:
      loop
         
         if WelcheAuswahl = 0 then
            null;
            
         else
            Put_Line (To_Wide_Wide_String (Einlesen.TexteEinlesen (21, WelcheAuswahl)));
         end if;

         Anzeige (WelcherText => WelcherText);         
         
         Get_Immediate (Taste);
         
         case To_Lower (Taste) is               
            when 'w' | '8' => 
               if AktuelleAuswahl = Einlesen.TexteEinlesen'First (2) then
                  AktuelleAuswahl := Ende;
               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;

            when 's' | '2' =>
               if AktuelleAuswahl = Ende then
                  AktuelleAuswahl := Einlesen.TexteEinlesen'First (2);
               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;
                              
            when 'e' | '5' =>
               if Einlesen.TexteEinlesen (WelcherText, AktuelleAuswahl) = "Hauptmenü" then
                  return 0;
                  
               elsif Einlesen.TexteEinlesen (WelcherText, AktuelleAuswahl) = "Spiel beenden" then
                  return -1;
                  
               elsif Einlesen.TexteEinlesen (WelcherText, AktuelleAuswahl) = "Zurück" then
                  return -2;
                  
               elsif Einlesen.TexteEinlesen (WelcherText, AktuelleAuswahl) = "Ja" then
                  return -3;
                  
               elsif Einlesen.TexteEinlesen (WelcherText, AktuelleAuswahl) = "Nein" then
                  return -4;

               elsif Einlesen.TexteEinlesen (WelcherText, AktuelleAuswahl) = "Speichern" then
                 return 2;

               elsif Einlesen.TexteEinlesen (WelcherText, AktuelleAuswahl) = "Laden" then
                 return 3;
                     
               else
                  Put (CSI & "2J" & CSI & "3J" & CSI & "H");
                  return AktuelleAuswahl;
               end if;
                     
            when others =>
               null;                    
         end case;

         Put (CSI & "2J" & CSI & "3J"  & CSI & "H");
         
      end loop StartauswahlSchleife;
      
   end Auswahl;

   -- ║ ╚ ╔ ═ ╝ ╗

   procedure Anzeige (WelcherText : in Integer) is
   begin

      LängsterText := 1;
      
      TextlängePrüfenSchleife:
      for A in Einlesen.TexteEinlesen'Range (2) loop
         if To_Wide_Wide_String (Einlesen.TexteEinlesen (WelcherText, A)) = "|" then
            exit TextlängePrüfenSchleife;
            
         elsif To_Wide_Wide_String (Einlesen.TexteEinlesen (WelcherText, A))'Length > LängsterText then
            LängsterText := To_Wide_Wide_String (Einlesen.TexteEinlesen (WelcherText, A))'Length;
            
         else
            null;
         end if;
      end loop TextlängePrüfenSchleife;
      
      AnzeigeSchleife:
      for A in Einlesen.TexteEinlesen'Range (2) loop

         if AktuelleAuswahl = A then
            for B in 1 .. LängsterText loop

               if To_Wide_Wide_String (Einlesen.TexteEinlesen (WelcherText, A)) = "|" then
                  exit AnzeigeSchleife;
                  
               elsif B = 1 then
                  Put ("╔");
                  Put ("═");

               elsif B = LängsterText then                  
                  Put ("═");
                  Put_Line ("╗");
                  Put ("║");
                  Put (To_Wide_Wide_String (Einlesen.TexteEinlesen (WelcherText, A)));

                  for Leer in 1 .. LängsterText - To_Wide_Wide_String (Einlesen.TexteEinlesen (WelcherText, A))'Length loop
                        
                     Put (" ");
                        
                  end loop;
                  Put_Line ("║");
                  Put ("╚");

               else
                  Put ("═");
               end if;
               
            end loop;

            for C in 1 .. LängsterText loop
               
               if C = LängsterText then
                  Put ("═");
                  Put_Line ("╝");
               
               else
                  Put ("═");
               end if;
            
            end loop;
         
         else
            if To_Wide_Wide_String (Einlesen.TexteEinlesen (WelcherText, A)) = "|" then
               exit AnzeigeSchleife; 
            
            else
               Put_Line (To_Wide_Wide_String (Einlesen.TexteEinlesen (WelcherText, A)));
            end if;
         end if;
         
      end loop AnzeigeSchleife;
   
   end Anzeige;



   procedure AnzeigeLangerText (WelcherText, WelcheZeile : in Integer) is
   begin
      
      N := 1;

      for A in To_Wide_Wide_String (Einlesen.TexteEinlesen (WelcherText, WelcheZeile))'Range loop
         
         if To_Wide_Wide_String (Einlesen.TexteEinlesen (WelcherText, WelcheZeile)) (A) = '|' then
            exit;
            
            else
               Text (A) := To_Wide_Wide_String (Einlesen.TexteEinlesen (WelcherText, WelcheZeile)) (A);
         end if;
         
      end loop;
      
      for B in Text'Range loop
         
         if Text (B) = '|' then
            exit;
            
         elsif B - 80 * N > 1 then
            if Text (B) = ' ' then
               N := N + 1;
               New_Line;
               
            else
               Put (Text (B));
            end if;
            
         else
            Put (Text (B));
         end if;
         
      end loop;

      Get_Immediate (Taste);
      
   end AnzeigeLangerText;

end Auswahl;
