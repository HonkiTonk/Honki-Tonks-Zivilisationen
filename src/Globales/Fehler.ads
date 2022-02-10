pragma SPARK_Mode (On);

package Fehler is
      
   procedure LogikStopp
     (FehlermeldungExtern : in Wide_Wide_String)
     with
       Pre =>
         (FehlermeldungExtern'Length > 0);
            
   procedure GrafikStopp
     (FehlermeldungExtern : in Wide_Wide_String)
     with
       Pre =>
         (FehlermeldungExtern'Length > 0);
   
   procedure MusikStopp
     (FehlermeldungExtern : in Wide_Wide_String)
     with
       Pre =>
         (FehlermeldungExtern'Length > 0);
   
   procedure SoundStopp
     (FehlermeldungExtern : in Wide_Wide_String)
     with
       Pre =>
         (FehlermeldungExtern'Length > 0);
   
   procedure LogikMeldung
     (FehlermeldungExtern : in Wide_Wide_String)
     with
       Pre =>
         (FehlermeldungExtern'Length > 0);
   
   procedure GrafikMeldung
     (FehlermeldungExtern : in Wide_Wide_String)
     with
       Pre =>
         (FehlermeldungExtern'Length > 0);
   
   procedure MusikMeldung
     (FehlermeldungExtern : in Wide_Wide_String)
     with
       Pre =>
         (FehlermeldungExtern'Length > 0);
   
   procedure SoundMeldung
     (FehlermeldungExtern : in Wide_Wide_String)
     with
       Pre =>
         (FehlermeldungExtern'Length > 0);
   
private

   LogikFehler : exception;
   GrafikFehler : exception;
   MusikFehler : exception;
   SoundFehler : exception;

end Fehler;
