pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

package body Fehler is

   -- Immer bei allen raise IrgendeinFehler einbauen, damit das Programm sich auch wirklich sofort beendet? Ist das richtig so?
   -- Man könnte die Task IDs auch hier oder woanders speichern und dann von hier direkt die Tasks bei einem Fehler abbrechen? Eventuell auch gleich die Läuft Werte dazu speichern und von hier aus ändern?
   procedure LogikStopp
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
      
      Put_Line (FehlermeldungExtern);
      KritischesProblemLogik := True;
      raise LogikFehler;
      
   end LogikStopp;
   
   
   
   procedure GrafikStopp
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
      
      Put_Line (FehlermeldungExtern);
      KritischesProblemGrafik := True;
      raise GrafikFehler;
      
   end GrafikStopp;
   
   
   
   procedure SoundStopp
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
      
      Put_Line (FehlermeldungExtern);
      KritischesProblemSound := True;
      raise SoundFehler;
      
   end SoundStopp;
   
   
   
   procedure SonstigesStopp
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
      
      -- Put_Line ("Wofür das verwenden?");
      Put_Line (FehlermeldungExtern);
      KritischesProblemLogik := True;
      KritischesProblemGrafik := True;
      KritischesProblemSound := True;
      raise SonstigesFehler;
      
   end SonstigesStopp;
   
   
   
   -- Nur als Zwischenlösung gedacht, später wieder entfernen!
   procedure UnschönerStopp
   is begin
            
      KritischesProblemLogik := True;
      KritischesProblemGrafik := True;
      KritischesProblemSound := True;
      raise Program_Error;
      
   end UnschönerStopp;

end Fehler;
