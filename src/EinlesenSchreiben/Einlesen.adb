pragma SPARK_Mode (On);

with Ada.Strings.UTF_Encoding.Wide_Wide_Strings, Ada.Calendar, Ada.Characters.Conversions;
use Ada.Strings.UTF_Encoding.Wide_Wide_Strings, Ada.Calendar;

with Ladezeiten, Schreiben, Auswahl;

package body Einlesen is

   function Einlesen
     return Boolean
   is begin
      
      Ladezeiten.SpielStartzeiten (1, 1) := Clock;      
      Schreiben.SchreibenStartAufruf;
      Erfolgreich := EinlesenSprache;
      Ladezeiten.SpielStartzeiten (2, 1) := Clock;
      
      case
        Erfolgreich
      is
         when True =>
            GlobaleVariablen.GewählteSprache := Auswahl.AuswahlSprache;
            
         when False =>
            return Erfolgreich;
      end case;
      
      Ladezeiten.SpielStartzeiten (1, 2) := Clock;
      Erfolgreich := EinlesenTextNeu;

      case
        Erfolgreich
      is
         when True =>
            EinlesenWerte;
            Ladezeiten.SpielStartzeiten (2, 2) := Clock;
            Ladezeiten.SpielStart (WelcheZeitExtern => 1);
            return Erfolgreich;

         when False =>
            return Erfolgreich;
      end case;
      
   end Einlesen;



   function EinlesenSprache
     return Boolean
   is begin

      GlobaleVariablen.SprachenEinlesen := (others => (To_Unbounded_Wide_Wide_String (Source => "|")));
      
      Start_Search (Search    => Suche,
                    Directory => "Dateien/Sprachen",
                    Pattern   => "");

      VerzeichnisAußenSchleife:
      while More_Entries (Search => Suche) loop

         Get_Next_Entry (Search          => Suche,
                         Directory_Entry => Verzeichnis);
         if
           Simple_Name (Directory_Entry => Verzeichnis) = "."
           or
             Simple_Name (Directory_Entry => Verzeichnis) = ".."
         then
            null;
                  
         else  
            VerzeichnisInnenSchleife:
            for Sprache in GlobaleVariablen.SprachenEinlesenArray'Range loop -- Alphabetisch in ein Stringarray einlesen und dann entsprechend weitersuchen lassen
            
               if
                 GlobaleVariablen.SprachenEinlesen (Sprache) /= "|"
               then
                  null;
            
               else        
                  GlobaleVariablen.SprachenEinlesen (Sprache) := To_Unbounded_Wide_Wide_String (Source => Ada.Characters.Conversions.To_Wide_Wide_String (Item => Simple_Name (Directory_Entry => Verzeichnis)));
                  exit VerzeichnisInnenSchleife;
               end if;            
         
            end loop VerzeichnisInnenSchleife;
         end if;

      end loop VerzeichnisAußenSchleife;
      
      if
        GlobaleVariablen.SprachenEinlesen (1) = "|"
      then
         return False;
         
      else
         return True;
      end if;
      
   end EinlesenSprache;



   function EinlesenTextNeu
     return Boolean
   is begin
      
      case
        Exists (Name => "Dateien/Sprachen/" & Encode (Item => To_Wide_Wide_String (Source => GlobaleVariablen.GewählteSprache)) & "/0")
      is
         when True =>
            null;

         when False =>
            return False;
      end case;

      Open (File => DateiNeuWelcheTexteEinlesen,
            Mode => In_File,
            Name => "Dateien/Sprachen/" & Encode (Item => To_Wide_Wide_String (Source => GlobaleVariablen.GewählteSprache)) & "/0");
      
      EinlesenSchleife:
      for WelcheDateienSchleifenwert in WelcheTexteEinlesenNeuArray'Range loop

         if
           End_Of_File (File => DateiNeuWelcheTexteEinlesen) = True
         then
            exit EinlesenSchleife;
               
         else
            Set_Line (File => DateiNeuWelcheTexteEinlesen,
                      To   => Ada.Wide_Wide_Text_IO.Count (WelcheDateienSchleifenwert));         
            WelcheTexteEinlesenNeu (WelcheDateienSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiNeuWelcheTexteEinlesen));
         end if;

      end loop EinlesenSchleife;

      Close (File => DateiNeuWelcheTexteEinlesen);
      
      DateiSchleife:
      for DateiSchleifenwert in 1 .. GlobaleVariablen.TexteEinlesenNeuArray'Last (1) loop

         case
           Exists (Encode (Item => (To_Wide_Wide_String (Source => WelcheTexteEinlesenNeu (DateiSchleifenwert)))))
         is
            when True =>
               null;

            when False =>
               return False;
         end case;

         LeereZeilenAbzieher := 0;
         
         Open (File => DateiNeuText,
               Mode => In_File,
               Name => Encode (Item => (To_Wide_Wide_String (WelcheTexteEinlesenNeu (DateiSchleifenwert)))));
      
         ZeilenSchleife:
         for ZeileSchleifenwert in GlobaleVariablen.TexteEinlesenNeuArray'Range (2) loop
            if
              End_Of_File (File => DateiNeuText) = True
            then
               exit ZeilenSchleife;
               
            else
               Set_Line (File => DateiNeuText,
                         To   => Ada.Wide_Wide_Text_IO.Count (ZeileSchleifenwert));         
               GlobaleVariablen.TexteEinlesenNeu (DateiSchleifenwert, ZeileSchleifenwert - LeereZeilenAbzieher) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiNeuText));

               if
                 To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (DateiSchleifenwert, ZeileSchleifenwert - LeereZeilenAbzieher)) (1) /= '|'
               then
                  null;                 
                  
               else
                  LeereZeilenAbzieher := LeereZeilenAbzieher + 1;
               end if;
            end if;

         end loop ZeilenSchleife;

         Close (File => DateiNeuText);

      end loop DateiSchleife;

      return True;
         
   end EinlesenTextNeu;



   procedure EinlesenWerte
   is begin
        
      case
        Exists (Name => "Dateien/WelcheWerteEinlesen")
      is
         when True =>
            null;

         when False =>
            return;
      end case;

      Open (File => DateiNeuWelcheWerteEinlesen,
            Mode => In_File,
            Name => "Dateien/WelcheWerteEinlesen");

      DateiSchleife:
      for DateiSchleifenwert in WelcheWerteEinlesenNeuArray'Range loop

         if
           End_Of_File (File => DateiNeuWelcheWerteEinlesen) = True
         then
            exit DateiSchleife;
               
         else
            Set_Line (File => DateiNeuWelcheWerteEinlesen,
                      To   => Ada.Wide_Wide_Text_IO.Count (DateiSchleifenwert));         
            WelcheWerteEinlesenNeu (DateiSchleifenwert) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiNeuWelcheWerteEinlesen));
         end if;

      end loop DateiSchleife;

      Close (File => DateiNeuWelcheWerteEinlesen);

      WelcheWerteSchleife:
      for WerteSchleifenwert in WelcheWerteEinlesenNeuArray'Range loop

         case
           Exists (Encode (Item => (To_Wide_Wide_String (Source => WelcheWerteEinlesenNeu (WerteSchleifenwert)))))
         is
            when True =>
               null;

            when False =>
               return;
         end case;
         
         Open (File => DateiNeuWerte,
               Mode => In_File,
               Name => Encode (Item => (To_Wide_Wide_String (WelcheWerteEinlesenNeu (WerteSchleifenwert)))));

         Close (File => DateiNeuWerte);

      end loop WelcheWerteSchleife;
   
   end EinlesenWerte;

end Einlesen;
