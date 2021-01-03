package body Eingabe is

   function GanzeZahl (Zahlengröße : Integer) return Integer is
   begin
      
      EingabeSchleife:
      loop

         Zahl := To_Unbounded_Wide_Wide_String (Source => Get_Line);
         if To_Wide_Wide_String (Source => Zahl)'Length = 0 then
            return -1;
            
         else
            null;
         end if;

         loop
            
            if To_Wide_Wide_String (Source => Zahl) (1) = '0' then
               Delete (Zahl, 1, 1);
               
            else
               exit;
            end if;
            
         end loop;
         
         if To_Wide_Wide_String (Source => Zahl)'Length = 0 then
            return -1;

         elsif To_Wide_Wide_String (Source => Zahl)'Length > Zahlengröße then
            Anzeige.Fehlermeldungen (WelcheFehlermeldung => 13);
         
         else
            for A in To_Wide_Wide_String (Source => Zahl)'Range loop
         
               case Is_Digit (To_Wide_Wide_String (Source => Zahl) (A)) is
                  when True =>
                     if A = Zahlengröße or A = To_Wide_Wide_String (Source => Zahl)'Last then
                        exit EingabeSchleife;
                     
                     else
                        null;
                     end if;
               
                  when False =>
                     Anzeige.Fehlermeldungen (WelcheFehlermeldung => 14);
                     exit;
               end case;
            end loop;
         end if;

      end loop EingabeSchleife;
      
      return Integer'Wide_Wide_Value (To_Wide_Wide_String (Source => Zahl));
      
   end GanzeZahl;



   function GanzeZahlNeu (WelcheDatei, WelcherText, ZahlenMinimum, ZahlenMaximum : Integer) return Integer is
   begin
      
      Schleifen := (others => False);
      
      HauptSchleife:
      loop
         
         ErsteZahlSchleife:
         while Schleifen (9) = False loop
            
            Get_Immediate (Item => Zahlen);
            IstZahl := ZahlPrüfung (Zeichen => Zahlen);
            case IstZahl is
               when 1 =>
                  ZahlenString (9) := Zahlen;

                  if Integer'Wide_Wide_Value (ZahlenString) <= ZahlenMaximum then
                     Schleifen (9) := True;
                     
                  else
                     null;
                  end if;

               when -1 =>
                  return -1;

               when 2 =>
                  if Integer'Wide_Wide_Value (ZahlenString) >= ZahlenMinimum then
                     exit HauptSchleife;
                     
                  else
                     null;
                  end if;
                  
               when others =>
                  Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
            end case;

         end loop ErsteZahlSchleife;

         ZweiteZahlSchleife:
         while Schleifen (8) = False loop
            
            Get_Immediate (Item => Zahlen);
            IstZahl := ZahlPrüfung (Zeichen => Zahlen);
            case IstZahl is
               when 1 =>
                  ZahlenString (8) := ZahlenString (9);
                  ZahlenString (9) := Zahlen;

                  if Integer'Wide_Wide_Value (ZahlenString) >= ZahlenMinimum and Integer'Wide_Wide_Value (ZahlenString) <= ZahlenMaximum then
                     Schleifen (8) := True;
                     
                  else
                     null;
                  end if;

               when -1 =>
                  return -1;

               when 2 =>
                  if Integer'Wide_Wide_Value (ZahlenString) >= ZahlenMinimum then
                     exit HauptSchleife;
                     
                  else
                     null;
                  end if;
                  
               when others =>
                  null;
            end case;

         end loop ZweiteZahlSchleife;

      end loop HauptSchleife;
         
      loop
            
         if ZahlenString (1) = '0' then
            Delete (Zahl, 1, 1);
               
         else
            exit;
         end if;
            
      end loop;

      return Integer'Wide_Wide_Value (ZahlenString);
            
   end GanzeZahlNeu;



   function ZahlPrüfung (Zeichen : in Wide_Wide_Character) return Integer is
   begin
      
      case Zeichen is
         when '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9' =>
            return 1;
            
         when 'q' =>
            return -1;

         when DEL =>
            return -2;

         when 'e' =>
            return 2;
            
         when others =>
            return 0;
      end case;
      
   end ZahlPrüfung;

   

   function StadtName return Unbounded_Wide_Wide_String is
   begin
      
      Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, 32)));
      Name := To_Unbounded_Wide_Wide_String (Source => Get_Line);
      
      return Name;
      
   end StadtName;



   function SpielstandName return Unbounded_Wide_Wide_String is
   begin            
      
      Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, 40)));
      Name := To_Unbounded_Wide_Wide_String (Source => Get_Line);
      
      return Name;
      
   end SpielstandName;

end Eingabe;
