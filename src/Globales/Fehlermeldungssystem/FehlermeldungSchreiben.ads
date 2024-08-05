private with Ada.Wide_Wide_Text_IO;

package FehlermeldungSchreiben is
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
   use Ada.Wide_Wide_Text_IO;
   
   Meldungen : constant String (1 .. 9) := "Meldungen";
      
   DateiMeldung : File_Type;

end FehlermeldungSchreiben;
