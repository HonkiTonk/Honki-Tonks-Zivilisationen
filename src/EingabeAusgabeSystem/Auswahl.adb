package body Auswahl is

   function Auswahl (WelcheAuswahl, WelcherText : in Integer) return Integer is
   begin

      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");

      for A in Einlesen.TexteEinlesen'Range (2) loop
         
         if To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (WelcherText, A)) = "|" then
            exit;
            
         else
            Ende := A;
         end if;
         
      end loop;

      AktuelleAuswahl := 1;
      
      AuswahlSchleife:
      loop
         
         if WelcheAuswahl = 0 then
            null;
            
         else
            Put_Line (Item => To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (21, WelcheAuswahl)));
         end if;

         Anzeige.Anzeige (WelcherText => WelcherText,
                          AktuelleAuswahl => AktuelleAuswahl);         
         
         Get_Immediate (Item => Taste);
         
         case To_Lower (Item => Taste) is               
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

               elsif Einlesen.TexteEinlesen (WelcherText, AktuelleAuswahl) = "Optionen" then
                 return 4;

               elsif Einlesen.TexteEinlesen (WelcherText, AktuelleAuswahl) = "Informationen" then
                 return 5;
                     
               else
                  Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
                  return AktuelleAuswahl;
               end if;
                     
            when others =>
               null;                    
         end case;

         Put (Item => CSI & "2J" & CSI & "3J"  & CSI & "H");
         
      end loop AuswahlSchleife;
      
   end Auswahl;

end Auswahl;
