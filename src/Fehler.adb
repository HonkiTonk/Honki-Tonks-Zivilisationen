pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

package body Fehler is

   -- Man könnte die Task IDs auch hier oder woanders speichern und dann von hier direkt die Tasks bei einem Fehler abbrechen? Eventuell auch gleich die Läuft Werte aus Start dazu speichern und von hier aus ändern?
   procedure LogikStopp
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
      
      Put_Line ("Fehler.LogikStopp:");
      Put_Line (FehlermeldungExtern);
      KritischesProblemLogik := True;
      raise LogikFehler;
      
   end LogikStopp;
   
   
   
   procedure GrafikStopp
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
      
      Put_Line ("Fehler.GrafikStopp:");
      Put_Line (FehlermeldungExtern);
      KritischesProblemGrafik := True;
      raise GrafikFehler;
      
   end GrafikStopp;
   
   
   
   procedure SoundStopp
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
      
      Put_Line ("Fehler.SoundStopp:");
      Put_Line (FehlermeldungExtern);
      KritischesProblemSound := True;
      raise SoundFehler;
      
   end SoundStopp;
   
   
   
   -- Wird Aktuell nur für die manuelle Schließung des Fensters gebraucht, löschen nachdem eine bessere Lösung gebaut wurde.
   procedure UnschönerStopp
   is begin
            
      KritischesProblemLogik := True;
      KritischesProblemGrafik := True;
      KritischesProblemSound := True;
      raise Program_Error;
      
   end UnschönerStopp;

end Fehler;
