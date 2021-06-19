pragma SPARK_Mode (On);

with Ada.Directories, Ada.Strings.Wide_Wide_Unbounded;
use Ada.Directories, Ada.Strings.Wide_Wide_Unbounded;

with GlobaleVariablen;

with SchreibenEinstellungen;

package body EinlesenEinstellungen is

   procedure EinlesenEinstellungen
   is begin
      
      case
        Exists (Name => "Einstellungen/" & "Einstellungen")
      is
         when True =>
            null;

         when False =>
            SchreibenEinstellungen.SchreibenEinstellungen;
      end case;      
      
      LeereZeilenAbzieher := 0;
      
      Open (File => DateiEinstellungenEinlesen,
            Mode => In_File,
            Name => "Einstellungen/" & "Einstellungen");
      
      EinlesenSchleife:
      for WelcheZeileSchleifenwert in GlobaleVariablen.EinstellungenEinlesenArray'Range loop

         if
           End_Of_File (File => DateiEinstellungenEinlesen) = True
         then
            exit EinlesenSchleife;
               
         else
            Set_Line (File => DateiEinstellungenEinlesen,
                      To   => Ada.Wide_Wide_Text_IO.Count (WelcheZeileSchleifenwert));         
            GlobaleVariablen.EinstellungenEingelesen (WelcheZeileSchleifenwert - LeereZeilenAbzieher) := To_Unbounded_Wide_Wide_String (Source => Get_Line (File => DateiEinstellungenEinlesen));
            
            if
              To_Wide_Wide_String (Source => GlobaleVariablen.EinstellungenEingelesen (WelcheZeileSchleifenwert - LeereZeilenAbzieher)) (1) /= '|'
            then
               null;                 
                  
            else
               LeereZeilenAbzieher := LeereZeilenAbzieher + 1;
            end if;
         end if;

      end loop EinlesenSchleife;

      Close (File => DateiEinstellungenEinlesen);
      
   end EinlesenEinstellungen;

end EinlesenEinstellungen;
