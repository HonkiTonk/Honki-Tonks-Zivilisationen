pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Font;

package body TexteinstellungenSFML is

   procedure StandardLaden
   is begin
      
      Schriftgrößen := SchriftgrößenStandard;
      Schriftfarben := SchriftfarbenStandard;
      
   end StandardLaden;
   
   
   
   procedure SchriftartFestlegen
   is begin
      
      TexteinstellungenSFML.SchriftartAccess := Sf.Graphics.Font.createFromFile (filename => "Sprachen/Schriftart/FreeSans.otf");
      
   end SchriftartFestlegen;

end TexteinstellungenSFML;
