pragma SPARK_Mode (On);

with Ada.Directories, Ada.Strings.Wide_Wide_Unbounded;
use Ada.Directories, Ada.Strings.Wide_Wide_Unbounded;

with GlobaleVariablen;

package body SchreibenEinstellungen is

   procedure SchreibenEinstellungen
   is begin
      
      case
        Exists (Name => "Einstellungen/" & "Einstellungen")
      is
         when True =>
            return;

         when False =>
            Create (File => DateiEinstellungenSchreiben,
                    Mode => Out_File,
                    Name => "Einstellungen/Einstellungen");
      end case;
      
      DateiAnlegenSchleife:
      for DateiZeileSchleifenwert in GlobaleVariablen.EinstellungenEinlesenArray'Range loop
         
         Set_Line (File => DateiEinstellungenSchreiben,
                   To   => Ada.Wide_Wide_Text_IO.Count (DateiZeileSchleifenwert));
         
         case
           DateiZeileSchleifenwert
         is
            when 1 =>
               Put (File => DateiEinstellungenSchreiben,
                    Item => "|");
               
            when 2 =>
               Put (File => DateiEinstellungenSchreiben,
                    Item => "/");
         end case;
         
      end loop DateiAnlegenSchleife;
      
      Close (File => DateiEinstellungenSchreiben);
      
   end SchreibenEinstellungen;
   
   
   
   procedure SchreibenSprache
   is begin
      
      Open (File => DateiEinstellungenSchreiben,
            Mode => Out_File,
            Name => "Einstellungen/" & "Einstellungen");
      
      Put (File => DateiEinstellungenSchreiben,
           Item => "|");
      
      Set_Line (File => DateiEinstellungenSchreiben,
                To   => 2);
      
      Put (File => DateiEinstellungenSchreiben,
           Item => To_Wide_Wide_String (Source => (GlobaleVariablen.EinstellungenEingelesen (1))));
      
      Close (File => DateiEinstellungenSchreiben);
      
   end SchreibenSprache;

end SchreibenEinstellungen;
