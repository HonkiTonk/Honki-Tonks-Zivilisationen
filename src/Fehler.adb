pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with SystemKonstanten;

package body Fehler is

   procedure LogikStopp
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
      
      if
        FehlermeldungExtern = SystemKonstanten.LeerString
      then
         null;
         
      else      
         Put_Line ("Fehler.LogikStopp:");
         Put_Line (FehlermeldungExtern);
      end if;
      
      raise LogikFehler;
      
   end LogikStopp;
   
   
   
   procedure GrafikStopp
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
      
      if
        FehlermeldungExtern = SystemKonstanten.LeerString
      then
         null;
         
      else   
         Put_Line ("Fehler.GrafikStopp:");
         Put_Line (FehlermeldungExtern);
      end if;
      
      raise GrafikFehler;
      
   end GrafikStopp;
   
   
   
   procedure SoundStopp
     (FehlermeldungExtern : in Wide_Wide_String)
   is begin
      
      if
        FehlermeldungExtern = SystemKonstanten.LeerString
      then
         null;
         
      else   
         Put_Line ("Fehler.SoundStopp:");
         Put_Line (FehlermeldungExtern);
      end if;
      
      raise SoundFehler;
      
   end SoundStopp;

end Fehler;
