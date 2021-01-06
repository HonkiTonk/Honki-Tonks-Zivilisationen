package body Einlesen is

   function Einlesen return Boolean is
   begin      
      
      Ladezeiten.SpielStartzeiten (1, 1) := Clock;

      Erfolgreich := EinlesenSprache;
      
      case Erfolgreich is
         when True =>
            GlobaleVariablen.GewählteSprache := Auswahl.AuswahlSprache;
            
         when False =>
            return Erfolgreich;
      end case;
      
      Erfolgreich := EinlesenText;

      case Erfolgreich is
         when True =>
            EinlesenWerte;
            Ladezeiten.SpielStartzeiten (2, 1) := Clock;
            Ladezeiten.SpielStart (WelcheZeit => 1);
            return Erfolgreich;

         when False =>
            return Erfolgreich;
      end case;
      
   end Einlesen;



   function EinlesenSprache return Boolean is
   begin
      
      Start_Search (Search    => Suche,
                    Directory => "Dateien/Sprachen",
                    Pattern   => "");

      VerzeichnisAußenSchleife:
      while More_Entries (Search => Suche) loop

         Get_Next_Entry (Search          => Suche,
                         Directory_Entry => Verzeichnis);
         if Simple_Name (Directory_Entry => Verzeichnis) = "." or Simple_Name (Directory_Entry => Verzeichnis) = ".." then
            null;
                  
         else  
            VerzeichnisInnenSchleife:
            for Sprache in GlobaleVariablen.TexteEinlesen'Range (2) loop
            
               if GlobaleVariablen.TexteEinlesen (0, Sprache) /= "|" then
                  null;
            
               else        
                  GlobaleVariablen.TexteEinlesen (0, Sprache) := To_Unbounded_Wide_Wide_String (Source => Ada.Characters.Conversions.To_Wide_Wide_String (Item => Simple_Name (Directory_Entry => Verzeichnis)));
                  exit VerzeichnisInnenSchleife;
               end if;            
         
            end loop VerzeichnisInnenSchleife;
         end if;
      end loop VerzeichnisAußenSchleife;
      
      return True;
      
   end EinlesenSprache;



   function EinlesenText return Boolean is -- Wenn Hardcoded wie die Werte, dann funktioniert es mit einer Sprache ohne die Dateien zum Einlesen
   begin

      case Exists (Name => "Dateien/Sprachen/" & Ada.Characters.Conversions.To_String (Item => To_Wide_Wide_String (Source => GlobaleVariablen.GewählteSprache)) & "/0") is
         when True =>
            null;

         when False =>
            return False;
      end case;

      Open (File => DateiWelcheTexteEinlesen,
            Mode => In_File,
            Name => "Dateien/Sprachen/" & Ada.Characters.Conversions.To_String (Item => To_Wide_Wide_String (Source => GlobaleVariablen.GewählteSprache)) & "/0");

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
      for B in 1 .. GlobaleVariablen.TexteEinlesen'Last (1) loop

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
