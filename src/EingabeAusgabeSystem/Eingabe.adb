package body Eingabe is

   function GanzeZahl (Zahlengröße : Integer) return Integer is
   begin
      
      EingabeSchleife:
      loop

         Zahl := To_Unbounded_Wide_Wide_String (Source => Get_Line);

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
