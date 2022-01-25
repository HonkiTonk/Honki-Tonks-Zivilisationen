pragma SPARK_Mode (On);

package Fehler is
      
   procedure LogikStopp
     (FehlermeldungExtern : in Wide_Wide_String);
   
   procedure GrafikStopp
     (FehlermeldungExtern : in Wide_Wide_String);
   
   procedure MusikStopp
     (FehlermeldungExtern : in Wide_Wide_String);
   
   procedure SoundStopp
     (FehlermeldungExtern : in Wide_Wide_String);
   
private

   LogikFehler : exception;
   GrafikFehler : exception;
   MusikFehler : exception;
   SoundFehler : exception;

end Fehler;
