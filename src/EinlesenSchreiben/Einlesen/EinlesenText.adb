pragma SPARK_Mode (On);

with Ada.Strings.UTF_Encoding.Wide_Wide_Strings, Ada.Directories;
use Ada.Strings.UTF_Encoding.Wide_Wide_Strings, Ada.Directories;

package body EinlesenText is
   
   function EinlesenText
     return Boolean
   is begin
      
      case
        TexteRassen
      is
         when False =>
            return False;
            
         when True =>
            null;
      end case;
      
      case
        TexteAllesAndere
      is
         when False =>
            return False;
            
         when True =>
            null;
      end case;
      
      case
        TexteOptionen
      is
         when False =>
            return False;
            
         when True =>
            null;
      end case;
      
      case
        TexteSpieleinstellungen
      is
         when False =>
            return False;
            
         when True =>
            return True;
      end case;
      
   end EinlesenText;
   
   
   
   function TexteRassen
     return Boolean
   is begin
      
      case
        Exists (Name => "Sprachen/" & Encode (Item => To_Wide_Wide_String (Source => GlobaleVariablen.NutzerEinstellungen.Sprache)) & "/0")
      is
         when True =>
            Open (File => DateiNeuWelcheTexteEinlesen,
                  Mode => In_File,
                  Name => "Sprachen/" & Encode (Item => To_Wide_Wide_String (Source => GlobaleVariablen.NutzerEinstellungen.Sprache)) & "/0");

         when False =>
            return False;
      end case;
      
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
               Open (File => DateiNeuText,
                     Mode => In_File,
                     Name => Encode (Item => (To_Wide_Wide_String (WelcheTexteEinlesenNeu (DateiSchleifenwert)))));
               LeereZeilenAbzieher := 0;

            when False =>
               return False;
         end case;
         
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
      
   end TexteRassen;
   
   
   
   function TexteAllesAndere
     return Boolean
   is begin
      
      return True;
      
   end TexteAllesAndere;
     
     
   
   function TexteOptionen
     return Boolean
   is begin
      
      return True;
      
   end TexteOptionen;
     
     
   
   function TexteSpieleinstellungen
     return Boolean
   is begin
      
      return True;
      
   end TexteSpieleinstellungen;

end EinlesenText;
