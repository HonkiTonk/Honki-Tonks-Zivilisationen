package body DateiLogik is
   
   procedure Erstellen
     (DateiartExtern : in out File_Type;
      NameExtern : in String)
   is begin
      
        Create (File => DateiartExtern,
                Mode => Out_File,
                Name => NameExtern,
                Form => "WCEM=8");
      
   end Erstellen;
   
   

   procedure Öffnen
     (DateiartExtern : in out File_Type;
      NameExtern : in String)
   is begin
      
      Open (File => DateiartExtern,
            Mode => In_File,
            Name => NameExtern,
            Form => "WCEM=8");
      
   end Öffnen;
   
   
   
   -- Schließen ist immer gleich und braucht auch keine Extraparameter.
   -- Trotzdem eine eigene Version davon verwenden der Vollständigkeitshalber und um nur hier with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO; verwenden zu müssen? äöü
   procedure Schließen
     (DateiartExtern : in out File_Type)
   is begin
      
      Close (File => DateiartExtern);
      
   end Schließen;
   
end DateiLogik;
