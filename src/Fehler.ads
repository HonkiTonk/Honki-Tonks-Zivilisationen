pragma SPARK_Mode (On);

package Fehler is
   
   KritischesProblemLogik : Boolean := False;
   KritischesProblemGrafik : Boolean := False;
   KritischesProblemSound : Boolean := False;
   
   procedure LogikStopp
     (FehlermeldungExtern : in Wide_Wide_String);
   
   procedure GrafikStopp
     (FehlermeldungExtern : in Wide_Wide_String);
   
   procedure SoundStopp
     (FehlermeldungExtern : in Wide_Wide_String);
   
   -- Wird Aktuell nur für die manuelle Schließung des Fensters gebraucht, löschen nachdem eine bessere Lösung gebaut wurde.
   procedure UnschönerStopp;
   -- Wird Aktuell nur für die manuelle Schließung des Fensters gebraucht, löschen nachdem eine bessere Lösung gebaut wurde.
   
private

   LogikFehler : exception;
   GrafikFehler : exception;
   SoundFehler : exception;

end Fehler;
