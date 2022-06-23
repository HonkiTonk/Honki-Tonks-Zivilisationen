pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;

package body MeldungenSchreiben is

   procedure MeldungSchreiben
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
      
      case
        Exists (Name => "Meldungen")
      is
         when True =>
            Open (File => DateiMeldungen,
                  Mode => Append_File,
                  Name => "Meldungen");
            
         when False =>
            Create (File => DateiMeldungen,
                    Mode => Out_File,
                    Name => "Meldungen");
      end case;
      
      Put_Line (File => DateiMeldungen,
                Item => FehlermeldungExtern);
      
      Close (File => DateiMeldungen);
      
   end MeldungSchreiben;

end MeldungenSchreiben;
