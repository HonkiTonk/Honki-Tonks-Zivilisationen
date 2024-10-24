private with Ada.Wide_Wide_Text_IO;

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
   
   -- Diese Dinge noch anpassbar machen? äöü
   -- Dann müsste man aber auch prüfen ob das gültige Angaben sind, eventuell später einbauen. äöü
   Meldungen : constant String (1 .. 9) := "Meldungen";
   Dateiform : constant String (1 .. 6) := "WCEM=8";
   
   Wartezeit : constant Duration := 0.002;
         
   DateiMeldung : File_Type;

end HTB1_MeldungSchreiben;
