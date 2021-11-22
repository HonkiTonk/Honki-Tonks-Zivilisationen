pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

package body Fehler is

   procedure LogikStopp
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
      
      Put_Line (FehlermeldungExtern);
      KritischesProblemLogik := True;
      raise LogikFehler;
      
   end LogikStopp;
   
   
   
   procedure GrafikStopp
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
      
      Put_Line (FehlermeldungExtern);
      KritischesProblemGrafik := True;
      raise GrafikFehler;
      
   end GrafikStopp;
   
   
   
   procedure SoundStopp
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
      
      Put_Line (FehlermeldungExtern);
      KritischesProblemSound := True;
      raise SoundFehler;
      
   end SoundStopp;
   
   
   
   procedure SonstigesStopp
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
      
      Put_Line ("Wofür das verwenden? Eventuell für das manuelle Schließen des Fensters?");
      Put_Line (FehlermeldungExtern);
      KritischesProblemLogik := True;
      KritischesProblemGrafik := True;
      KritischesProblemSound := True;
      raise SonstigesFehler;
      
   end SonstigesStopp;

end Fehler;
