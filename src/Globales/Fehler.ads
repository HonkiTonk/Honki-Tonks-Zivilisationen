pragma SPARK_Mode (On);

package Fehler is
   
   procedure LogikFehler
     (FehlermeldungExtern : in Wide_Wide_String)
     with
       Pre =>
         (FehlermeldungExtern'Length > 0);
            
   procedure GrafikFehler
     (FehlermeldungExtern : in Wide_Wide_String)
     with
       Pre =>
         (FehlermeldungExtern'Length > 0);
   
   procedure MusikFehler
     (FehlermeldungExtern : in Wide_Wide_String)
     with
       Pre =>
         (FehlermeldungExtern'Length > 0);
   
   procedure SoundFehler
     (FehlermeldungExtern : in Wide_Wide_String)
     with
       Pre =>
         (FehlermeldungExtern'Length > 0);
   
private

   LogikStopp : exception;
   GrafikStopp : exception;
   MusikStopp : exception;
   SoundStopp : exception;

end Fehler;
