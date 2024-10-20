private with Ada.Wide_Wide_Text_IO;

with Ada.Calendar; use Ada.Calendar;

package HTB1_MeldungSchreiben is
   pragma Elaborate_Body;

   procedure Meldung
     (MeldungExtern : in Wide_Wide_String)
     with
       Pre => (
                 MeldungExtern'Length > 0
              );
   
   procedure MeldungASCII
     (MeldungExtern : in String)
     with
       Pre => (
                 MeldungExtern'Length > 0
              );
   
private
   use Ada.Wide_Wide_Text_IO;
   
   Meldungen : constant String (1 .. 9) := "Meldungen";
   Dateiform : constant String (1 .. 6) := "WCEM=8";
   
   Wartezeit : constant Duration := 0.002;
   
   Test : Time;
      
   DateiMeldung : File_Type;

end HTB1_MeldungSchreiben;
