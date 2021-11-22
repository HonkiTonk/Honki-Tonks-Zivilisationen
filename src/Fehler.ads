pragma SPARK_Mode (On);

package Fehler is
   
   -- Weitere Fehlervarianten notwendig?
   KritischesProblemLogik : Boolean := False;
   KritischesProblemGrafik : Boolean := False;
   KritischesProblemSound : Boolean := False;
   
   procedure LogikStopp
     (FehlermeldungExtern : in Wide_Wide_String);
   
   procedure GrafikStopp
     (FehlermeldungExtern : in Wide_Wide_String);
   
   procedure SoundStopp
     (FehlermeldungExtern : in Wide_Wide_String);
   
   procedure SonstigesStopp
     (FehlermeldungExtern : in Wide_Wide_String);
   
private

   -- Die Exceptions sind reichlich nutzlos im aktuellen System, trotzdem drinnen lassen oder entfernen?
   LogikFehler : exception;
   GrafikFehler : exception;
   SoundFehler : exception;
   
   SonstigesFehler : exception;

end Fehler;
