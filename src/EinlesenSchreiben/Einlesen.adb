pragma SPARK_Mode (On);

with Ada.Strings.UTF_Encoding.Wide_Wide_Strings, Ada.Calendar, Ada.Characters.Conversions;
use Ada.Strings.UTF_Encoding.Wide_Wide_Strings, Ada.Calendar;

with Ladezeiten, Schreiben;

package body Einlesen is

   function Einlesen return Boolean is
   begin
      
      Ladezeiten.SpielStartzeiten (1, 1) := Clock;
      
      Schreiben.SchreibenStartAufruf;
      Erfolgreich := True; -- EinlesenSprache;
      
      case Erfolgreich is
         when True =>
            GlobaleVariablen.GewählteSprache := To_Unbounded_Wide_Wide_String (Source => "Deutsch"); -- Auswahl.AuswahlSprache;
            
         when False =>
            return Erfolgreich;
      end case;
      
      Erfolgreich := EinlesenTextNeu;

      case Erfolgreich is
         when True =>
            EinlesenWerte;
            Ladezeiten.SpielStartzeiten (2, 1) := Clock;
            -- Ladezeiten.SpielStart (WelcheZeit => 1);
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
            for Sprache in GlobaleVariablen.TexteEinlesenNeuArray'Range (2) loop
            
               if GlobaleVariablen.TexteEinlesenNeu (0, Sprache) /= "|" then
                  null;
            
               else        
                  GlobaleVariablen.TexteEinlesenNeu (0, Sprache) := To_Unbounded_Wide_Wide_String (Source => Ada.Characters.Conversions.To_Wide_Wide_String (Item => Simple_Name (Directory_Entry => Verzeichnis)));
                  exit VerzeichnisInnenSchleife;
               end if;            
         
            end loop VerzeichnisInnenSchleife;
         end if;
      end loop VerzeichnisAußenSchleife;
      
      return True;
      
   end EinlesenSprache;



   function EinlesenTextNeu return Boolean is
   begin
      
      case Exists (Name => "Dateien/Sprachen/" & Encode (Item => To_Wide_Wide_String (Source => GlobaleVariablen.GewählteSprache)) & "/0") is
         when True =>
            null;

         when False =>
            return False;
      end case;

      Open (File => DateiNeuWelcheTexteEinlesen,
            Mode => In_File,
            Name => "Dateien/Sprachen/" & Encode (Item => To_Wide_Wide_String (Source => GlobaleVariablen.GewählteSprache)) & "/0");
      
      EinlesenSchleife:
      for WelcheDateien in WelcheTexteEinlesenNeuArray'Range loop

         if End_Of_File (File => DateiNeuWelcheTexteEinlesen) = True then
            exit EinlesenSchleife;
               
         else
            Set_Line (File => DateiNeuWelcheTexteEinlesen,
                      To   => Ada.Wide_Wide_Text_IO.Count (WelcheDateien));         
            WelcheTexteEinlesenNeu (WelcheDateien) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiNeuWelcheTexteEinlesen));
         end if;

      end loop EinlesenSchleife;

      Close (File => DateiNeuWelcheTexteEinlesen);
      
      DateiSchleife:
      for Datei in 1 .. GlobaleVariablen.TexteEinlesenNeuArray'Last (1) loop

         case Exists (Encode (Item => (To_Wide_Wide_String (Source => WelcheTexteEinlesenNeu (Datei))))) is
            when True =>
               null;

            when False =>
               return False;
         end case;
         
         Open (File => DateiNeuText,
               Mode => In_File,
               Name => Encode (Item => (To_Wide_Wide_String (WelcheTexteEinlesenNeu (Datei)))));
      
         ZeilenSchleife:
         for Zeile in GlobaleVariablen.TexteEinlesenNeuArray'Range (2) loop

            if End_Of_File (File => DateiNeuText) = True then
               exit ZeilenSchleife;
               
            else
               Set_Line (File => DateiNeuText,
                         To   => Ada.Wide_Wide_Text_IO.Count (Zeile));         
               GlobaleVariablen.TexteEinlesenNeu (Datei, Zeile) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiNeuText));
            end if;

         end loop ZeilenSchleife;

         Close (File => DateiNeuText);

      end loop DateiSchleife;

      return True;

   exception
      when Storage_Error =>
         Put_Line (Item => "Zu lange Zeile, Einlesen.EinlesenText");
         Close (File => DateiNeuText);
         raise;
         
   end EinlesenTextNeu;



   procedure EinlesenWerte is
   begin
        
      case Exists (Name => "Dateien/WelcheWerteEinlesen") is
         when True =>
            null;

         when False =>
            return;
      end case;

      Open (File => DateiNeuWelcheWerteEinlesen,
            Mode => In_File,
            Name => "Dateien/WelcheWerteEinlesen");

      for A in WelcheWerteEinlesenNeuArray'Range loop

         if End_Of_File (File => DateiNeuWelcheWerteEinlesen) = True then
            exit;
               
         else
            Set_Line (File => DateiNeuWelcheWerteEinlesen,
                      To   => Ada.Wide_Wide_Text_IO.Count (A));         
            WelcheWerteEinlesenNeu (A) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiNeuWelcheWerteEinlesen));
         end if;

      end loop;

      close (File => DateiNeuWelcheWerteEinlesen);

      WelcheWerteSchleife:
      for B in WelcheWerteEinlesenNeuArray'Range loop

         case Exists (Encode (Item => (To_Wide_Wide_String (Source => WelcheWerteEinlesenNeu (B))))) is
            when True =>
               null;

            when False =>
               return;
         end case;
         
         Open (File => DateiNeuWerte,
               Mode => In_File,
               Name => Encode (Item => (To_Wide_Wide_String (WelcheWerteEinlesenNeu (B)))));

         close (File => DateiNeuWerte);

      end loop WelcheWerteSchleife;
   
   end EinlesenWerte;

end Einlesen;
