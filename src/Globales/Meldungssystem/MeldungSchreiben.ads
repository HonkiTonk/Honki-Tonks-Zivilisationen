pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

private with Ada.Text_IO;

package MeldungSchreiben is
   pragma Elaborate_Body;

   procedure MeldungSchreiben
     (MeldungExtern : in Wide_Wide_String)
     with
       Pre => (
                 MeldungExtern'Length > 0
              );
   
   procedure MeldungSchreibenASCII
     (MeldungExtern : in String)
     with
       Pre => (
                 MeldungExtern'Length > 0
              );
   
private

   DateiMeldungASCII : Ada.Text_IO.File_Type;
   
   DateiMeldung : File_Type;

end MeldungSchreiben;
