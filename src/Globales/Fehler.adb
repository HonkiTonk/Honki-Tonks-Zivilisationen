pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

package body Fehler is

   procedure LogikStopp
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
      
      Put_Line ("Fehler.LogikStopp:");
      Put_Line (FehlermeldungExtern);
      
      raise LogikFehler;
      
   end LogikStopp;
   
   
   
   procedure GrafikStopp
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
         
      Put_Line ("Fehler.GrafikStopp:");
      Put_Line (FehlermeldungExtern);
      
      raise GrafikFehler;
      
   end GrafikStopp;
   
   
   
   procedure MusikStopp
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
      
      Put_Line ("Fehler.MusikStopp:");
      Put_Line (FehlermeldungExtern);
      
      raise MusikFehler;
      
   end MusikStopp;
         
   
      
   procedure SoundStopp
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
      
      Put_Line ("Fehler.SoundStopp:");
      Put_Line (FehlermeldungExtern);
      
      raise SoundFehler;
      
   end SoundStopp;
   
   
   
   procedure LogikMeldung
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
      
      Put_Line ("Fehler.LogikMeldung:");
      Put_Line (FehlermeldungExtern);
      
   end LogikMeldung;
   
   
   
   procedure GrafikMeldung
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
      
      Put_Line ("Fehler.GrafikMeldung:");
      Put_Line (FehlermeldungExtern);
      
   end GrafikMeldung;
   
   
   
   procedure MusikMeldung
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
      
      Put_Line ("Fehler.MusikMeldung:");
      Put_Line (FehlermeldungExtern);
      
   end MusikMeldung;
   
   
   
   procedure SoundMeldung
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
      
      Put_Line ("Fehler.SoundMeldung:");
      Put_Line (FehlermeldungExtern);
      
   end SoundMeldung;

end Fehler;
