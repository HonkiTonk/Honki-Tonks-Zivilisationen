pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

package body Fehler is

   procedure LogikFehler
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
      
      Put_Line (FehlermeldungExtern);
      
      raise LogikStopp;
      
   end LogikFehler;
   
   
   
   procedure GrafikFehler
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
         
      Put_Line (FehlermeldungExtern);
      
      raise GrafikStopp;
      
   end GrafikFehler;
   
   
   
   procedure MusikFehler
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
      
      Put_Line (FehlermeldungExtern);
      
      raise MusikStopp;
      
   end MusikFehler;
   
   
   
   procedure SoundFehler
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
      
      Put_Line (FehlermeldungExtern);
      
      raise SoundStopp;
      
   end SoundFehler;

end Fehler;
