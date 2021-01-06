package body Auswahl is

   function AuswahlSprache return Unbounded_Wide_Wide_String is
   begin
      
      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
      
      for A in GlobaleVariablen.TexteEinlesen'Range (2) loop
         
         if To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (0, A)) = "|" then
            exit;
            
         else
            Ende := A;
         end if;
         
      end loop;

      AktuelleAuswahl := 1;
      
      AuswahlSchleife:
      loop         

         Put_Line (Item => "Sprache auswählen:");
         Anzeige.Anzeige (WelcherText     => 0,
                          AktuelleAuswahl => AktuelleAuswahl);         
         
         Get_Immediate (Item => Taste);
         
         case To_Lower (Item => Taste) is               
            when 'w' | '8' => 
               if AktuelleAuswahl = GlobaleVariablen.TexteEinlesen'First (2) then
                  AktuelleAuswahl := Ende;
               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;

            when 's' | '2' =>
               if AktuelleAuswahl = Ende then
                  AktuelleAuswahl := GlobaleVariablen.TexteEinlesen'First (2);
               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;
                              
            when 'e' | '5' =>    
               Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
               return GlobaleVariablen.TexteEinlesen (0, AktuelleAuswahl);
                     
            when others =>
               null;                    
         end case;

         Put (Item => CSI & "2J" & CSI & "3J"  & CSI & "H");
         
      end loop AuswahlSchleife;
      
   end AuswahlSprache;

   function Auswahl (WelcheAuswahl, WelcherText : in Integer) return Integer is
   begin

      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");

      for A in GlobaleVariablen.TexteEinlesen'Range (2) loop
         
         if To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (WelcherText, A)) = "|" then
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
            Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (21, WelcheAuswahl)));
         end if;

         Anzeige.Anzeige (WelcherText => WelcherText,
                          AktuelleAuswahl => AktuelleAuswahl);         
         
         Get_Immediate (Item => Taste);
         
         case To_Lower (Item => Taste) is               
            when 'w' | '8' => 
               if AktuelleAuswahl = GlobaleVariablen.TexteEinlesen'First (2) then
                  AktuelleAuswahl := Ende;
               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;

            when 's' | '2' =>
               if AktuelleAuswahl = Ende then
                  AktuelleAuswahl := GlobaleVariablen.TexteEinlesen'First (2);
               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;
                              
            when 'e' | '5' =>                  
               if GlobaleVariablen.TexteEinlesen (WelcherText, AktuelleAuswahl) = GlobaleVariablen.TexteEinlesen (23, 1) then
                  return 0;
                  
               elsif GlobaleVariablen.TexteEinlesen (WelcherText, AktuelleAuswahl) = GlobaleVariablen.TexteEinlesen (23, 2) then
                  return -1;
                  
               elsif GlobaleVariablen.TexteEinlesen (WelcherText, AktuelleAuswahl) = GlobaleVariablen.TexteEinlesen (23, 3) then
                  return -2;
                  
               elsif GlobaleVariablen.TexteEinlesen (WelcherText, AktuelleAuswahl) = GlobaleVariablen.TexteEinlesen (23, 4) then
                  return -3;
                  
               elsif GlobaleVariablen.TexteEinlesen (WelcherText, AktuelleAuswahl) = GlobaleVariablen.TexteEinlesen (23, 5) then
                  return -4;

               elsif GlobaleVariablen.TexteEinlesen (WelcherText, AktuelleAuswahl) = GlobaleVariablen.TexteEinlesen (23, 6) then
                 return 2;

               elsif GlobaleVariablen.TexteEinlesen (WelcherText, AktuelleAuswahl) = GlobaleVariablen.TexteEinlesen (23, 7) then
                 return 3;

               elsif GlobaleVariablen.TexteEinlesen (WelcherText, AktuelleAuswahl) = GlobaleVariablen.TexteEinlesen (23, 8) then
                 return 4;

               elsif GlobaleVariablen.TexteEinlesen (WelcherText, AktuelleAuswahl) = GlobaleVariablen.TexteEinlesen (23, 9) then
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
