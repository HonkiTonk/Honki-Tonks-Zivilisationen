pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with MeldungSchreiben;

package body Warnung is

   procedure LogikWarnung
     (WarnmeldungExtern : in Wide_Wide_String)
   is begin
      
      Put_Line (Item => "Warnung.LogikWarnung:");
      Put_Line (Item => WarnmeldungExtern);
      MeldungSchreiben.MeldungSchreiben (MeldungExtern => "Logikwarnung: " & WarnmeldungExtern);
      
   end LogikWarnung;
   
   
   
   procedure GrafikWarnung
     (WarnmeldungExtern : in Wide_Wide_String)
   is begin
      
      Put_Line (Item => "Warnung.GrafikWarnung:");
      Put_Line (Item => WarnmeldungExtern);
      MeldungSchreiben.MeldungSchreiben (MeldungExtern => "Grafikwarnung: " & WarnmeldungExtern);
      
   end GrafikWarnung;
   
   
   
   procedure MusikWarnung
     (WarnmeldungExtern : in Wide_Wide_String)
   is begin
      
      Put_Line (Item => "Warnung.MusikWarnung:");
      Put_Line (Item => WarnmeldungExtern);
      MeldungSchreiben.MeldungSchreiben (MeldungExtern => "Musikwarnung: " & WarnmeldungExtern);
      
   end MusikWarnung;
   
   
   
   procedure SoundWarnung
     (WarnmeldungExtern : in Wide_Wide_String)
   is begin
      
      Put_Line (Item => "Warnung.SoundWarnung:");
      Put_Line (Item => WarnmeldungExtern);
      MeldungSchreiben.MeldungSchreiben (MeldungExtern => "Soundwarnung: " & WarnmeldungExtern);
      
   end SoundWarnung;

end Warnung;
