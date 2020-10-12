package body Einlesen is

   function Einlesen return Boolean is
   begin      
      
      Erfolgreich := EinlesenText;

      case Erfolgreich is
         when True =>
            EinlesenWerte;
            return Erfolgreich;

         when False =>
            return Erfolgreich;
      end case;
      
   end Einlesen;



   function EinlesenText return Boolean is -- Wenn Hardcoded wie die Werte, dann funktioniert es mit einer Sprache ohne die Dateien zum Einlesen
   begin

      case Exists (Name => "Dateien/WelcheTexteEinlesen") is
         when True =>
            null;

         when False =>
            return False;
      end case;

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
      for B in GlobaleVariablen.TexteEinlesen'Range (1) loop

         case Exists (To_String (Source => WelcheTexteEinlesen (B))) is
            when True =>
               null;

            when False =>
               return False;
         end case;
         
         Open (File => DateiText,
               Mode => In_File,
               Name => To_String (WelcheTexteEinlesen (B)));
      
         Einlesen:
         for C in GlobaleVariablen.TexteEinlesen'Range (2) loop

            if End_Of_File (File => DateiText) = True then
               exit Einlesen;
               
            else
               Set_Line (File => DateiText,
                         To   => Ada.Wide_Wide_Text_IO.Count (C));         
               GlobaleVariablen.TexteEinlesen (B, C) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiText));
            end if;

         end loop Einlesen;

         close (File => DateiText);

      end loop WelcherTextSchleife;

      return True;

   exception
      when Storage_Error =>
         Ada.Wide_Wide_Text_IO.Put_Line (Item => "Zu lange Zeile, Einlesen.EinlesenText");
         close (File => DateiText);
         raise;
         
   end EinlesenText;



   procedure EinlesenWerte is
   begin
        
      case Exists (Name => "Dateien/WelcheWerteEinlesen") is
         when True =>
            null;

         when False =>
            return;
      end case;

      Open (File => DateiWelcheWerteEinlesen,
            Mode => In_File,
            Name => "Dateien/WelcheWerteEinlesen");

      for A in WelcheWerteEinlesen'Range loop

         if End_Of_File (File => DateiWelcheWerteEinlesen) = True then
            exit;
               
         else
            Set_Line (File => DateiWelcheWerteEinlesen,
                      To   => Ada.Text_IO.Count (A));         
            WelcheWerteEinlesen (A) := To_Unbounded_String (Source => Ada.Text_IO.Get_Line (File => DateiWelcheWerteEinlesen));
         end if;

      end loop;

      close (File => DateiWelcheWerteEinlesen);

      WelcheWerteSchleife:
      for B in WelcheWerteEinlesen'Range loop

         case Exists (To_String (Source => WelcheWerteEinlesen (B))) is
            when True =>
               null;

            when False =>
               return;
         end case;
         
         Open (File => DateiWerte,
               Mode => In_File,
               Name => To_String (WelcheWerteEinlesen (B)));

         close (File => DateiWerte);

      end loop WelcheWerteSchleife;
   
   end EinlesenWerte;

end Einlesen;
