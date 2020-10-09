package body Einlesen is

   procedure EinlesenText is
   begin

      Open (File => DateiWelcheTexteEinlesen,
            Mode => In_File,
            Name => "Dateien/WelcheTexteEinlesen");

      for A in WelcheTexteEinlesen'Range loop

         if End_Of_File (File => DateiWelcheTexteEinlesen) = True then
            exit;
               
         else
            Set_Line (File => DateiWelcheTexteEinlesen,
                      To   => Ada.Text_IO.Count (A));         
            WelcheTexteEinlesen (A) := To_Unbounded_String (Source => Ada.Text_IO.Get_Line (File => DateiWelcheTexteEinlesen));
         end if;

      end loop;

      close (File => DateiWelcheTexteEinlesen);
      
      WelcherTextSchleife:
      for B in TexteEinlesen'Range (1) loop
         
         Open (File => DateiText,
               Mode => In_File,
               Name => To_String (WelcheTexteEinlesen (B)));
      
         Einlesen:
         for C in TexteEinlesen'Range (2) loop

            if End_Of_File (File => DateiText) = True then
               exit Einlesen;
               
            else
               Set_Line (File => DateiText,
                         To   => Ada.Wide_Wide_Text_IO.Count (C));         
               TexteEinlesen (B, C) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
            end if;

         end loop Einlesen;

         close (File => DateiText);

      end loop WelcherTextSchleife;

   exception
      when Storage_Error =>
         Ada.Wide_Wide_Text_IO.Put_Line (Item => "Zu lange Zeile, Einlesen.EinlesenText");
         close (File => DateiText);
         raise;
      
   end EinlesenText;



   procedure EinlesenGanzeZahl is
   begin
        
      null;
      
   end EinlesenGanzeZahl;

end Einlesen;
