pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

package body Warnung is

   procedure LogikWarnung
     (WarnmeldungExtern : in Wide_Wide_String)
   is begin
      
      Put_Line ("Warnung.LogikWarnung:");
      Put_Line (WarnmeldungExtern);
      
   end LogikWarnung;
   
   
   
   procedure GrafikWarnung
     (WarnmeldungExtern : in Wide_Wide_String)
   is begin
      
      Put_Line ("Warnung.GrafikWarnung:");
      Put_Line (WarnmeldungExtern);
      
   end GrafikWarnung;
   
   
   
   procedure MusikWarnung
     (WarnmeldungExtern : in Wide_Wide_String)
   is begin
      
      Put_Line ("Warnung.MusikWarnung:");
      Put_Line (WarnmeldungExtern);
      
   end MusikWarnung;
   
   
   
   procedure SoundWarnung
     (WarnmeldungExtern : in Wide_Wide_String)
   is begin
      
      Put_Line ("Warnung.SoundWarnung:");
      Put_Line (WarnmeldungExtern);
      
   end SoundWarnung;

end Warnung;
