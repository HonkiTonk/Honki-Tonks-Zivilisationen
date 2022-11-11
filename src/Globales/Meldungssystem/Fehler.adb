with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with MeldungSchreiben;

package body Fehler is

   procedure LogikFehler
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
      
      Put_Line (Item => "Fehler.LogikFehler: " & FehlermeldungExtern);
      MeldungSchreiben.MeldungSchreiben (MeldungExtern => "Logikfehler: " & FehlermeldungExtern);
      
      raise LogikStopp;
      
   end LogikFehler;
   
   
   
   procedure GrafikFehler
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
         
      Put_Line (Item => "Fehler.GrafikFehler: " & FehlermeldungExtern);
      MeldungSchreiben.MeldungSchreiben (MeldungExtern => "Grafikfehler: " & FehlermeldungExtern);
      
      raise GrafikStopp;
      
   end GrafikFehler;
   
   
   
   procedure MusikFehler
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
      
      Put_Line (Item => "Fehler.MusikFehler: " & FehlermeldungExtern);
      MeldungSchreiben.MeldungSchreiben (MeldungExtern => "Musikfehler: " & FehlermeldungExtern);
      
      raise MusikStopp;
      
   end MusikFehler;
   
   
   
   procedure SoundFehler
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
      
      Put_Line (Item => "Fehler.SoundFehler: " & FehlermeldungExtern);
      MeldungSchreiben.MeldungSchreiben (MeldungExtern => "Soundfehler: " & FehlermeldungExtern);
      
      raise SoundStopp;
      
   end SoundFehler;

end Fehler;
