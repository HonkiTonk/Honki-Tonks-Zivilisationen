pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

package MeldungenSchreiben is

   procedure MeldungSchreiben
     (FehlermeldungExtern : in Wide_Wide_String)
     with
       Pre => (
                 FehlermeldungExtern'Length > 0
              );
   
private

   DateiMeldungen : File_Type;

end MeldungenSchreiben;
