with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

package DateiLogik is
   pragma Elaborate_Body;
   
   procedure Erstellen
     (DateiartExtern : in out File_Type;
      NameExtern : in String);

   procedure Öffnen
     (DateiartExtern : in out File_Type;
      NameExtern : in String);
   
   procedure Schließen
     (DateiartExtern : in out File_Type);
   
private
   
   

end DateiLogik;
