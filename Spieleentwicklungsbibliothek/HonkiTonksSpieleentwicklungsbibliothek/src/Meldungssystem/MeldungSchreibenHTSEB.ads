private with Ada.Wide_Wide_Text_IO;

package MeldungSchreibenHTSEB is
   pragma Elaborate_Body;
   
   procedure MeldungUTF
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
   
   -- Das noch anpassbar machen? äöü
   -- Dann müsste man aber auch prüfen ob das gültige Angaben sind, eventuell später einbauen. äöü
   Meldungen : constant String (1 .. 9) := "Meldungen";
   
   

   protected Schreiben is
      
      procedure Meldung
        (MeldungExtern : in Wide_Wide_String)
        with
          Pre => (
                    MeldungExtern'Length > 0
                 );
      
   private
         
      DateiMeldung : File_Type;
      
   end Schreiben;

end MeldungSchreibenHTSEB;
