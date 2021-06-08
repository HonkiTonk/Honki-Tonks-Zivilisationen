pragma SPARK_Mode (On);

with Ada.Strings.UTF_Encoding.Wide_Wide_Strings, Ada.Directories;
use Ada.Strings.UTF_Encoding.Wide_Wide_Strings, Ada.Directories;

package body EinlesenText is

   function EinlesenTextNeu
     return Boolean
   is begin
      
      case
        Exists (Name => "Sprachen/" & Encode (Item => To_Wide_Wide_String (Source => GlobaleVariablen.GewählteSprache)) & "/0")
      is
         when True =>
            null;

         when False =>
            return False;
      end case;

      Open (File => DateiNeuWelcheTexteEinlesen,
            Mode => In_File,
            Name => "Sprachen/" & Encode (Item => To_Wide_Wide_String (Source => GlobaleVariablen.GewählteSprache)) & "/0");
      
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

end EinlesenText;
