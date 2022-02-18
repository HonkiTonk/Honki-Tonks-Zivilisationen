pragma SPARK_Mode (On);

-- with Ada.Task_Identification; use Ada.Task_Identification;
-- with Ada.Task_Termination; use Ada.Task_Termination;
-- with Ada.Exceptions; use Ada.Exceptions;

package Fehler is
   
  -- protected type A is
  --    procedure Test (C : Cause_Of_Termination; T : Task_Id; X : Exception_Occurrence);
 --  end A;
   
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
   
   -- Bei Meldung den Parameter nicht Fehlermeldung nennen? ---------------
   -- Oder Meldungen gleich in einen eigenen Bereich ziehen? Ist ja nicht identisch mit einem stoppenden Fehler.
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
