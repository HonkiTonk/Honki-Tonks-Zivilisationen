pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with MeldungenSchreiben;

package body Fehler is

   procedure LogikFehler
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
      
      Put_Line (Item => FehlermeldungExtern);
      MeldungenSchreiben.MeldungSchreiben (FehlermeldungExtern => "Logikfehler: " & FehlermeldungExtern);
      
      raise LogikStopp;
      
   end LogikFehler;
   
   
   
   procedure GrafikFehler
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
         
      Put_Line (Item => FehlermeldungExtern);
      MeldungenSchreiben.MeldungSchreiben (FehlermeldungExtern => "Grafikfehler: " & FehlermeldungExtern);
      
      raise GrafikStopp;
      
   end GrafikFehler;
   
   
   
   procedure MusikFehler
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
      
      Put_Line (Item => FehlermeldungExtern);
      MeldungenSchreiben.MeldungSchreiben (FehlermeldungExtern => "Musikfehler: " & FehlermeldungExtern);
      
      raise MusikStopp;
      
   end MusikFehler;
   
   
   
   procedure SoundFehler
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
      
      Put_Line (Item => FehlermeldungExtern);
      MeldungenSchreiben.MeldungSchreiben (FehlermeldungExtern => "Soundfehler: " & FehlermeldungExtern);
      
      raise SoundStopp;
      
   end SoundFehler;

end Fehler;
