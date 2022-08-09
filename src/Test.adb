with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with TexteinstellungenSFML;

package body Test is

   procedure Test
   is begin
      
      Sf.Graphics.Text.setFont (text => TestAccess,
                                font => TexteinstellungenSFML.SchriftartAccess);
      Sf.Graphics.Text.setCharacterSize (text => TestAccess,
                                         size => TexteinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
      Sf.Graphics.Text.setUnicodeString (text => TestAccess,
                                         str  => Text);
      Sf.Graphics.Text.setPosition (text     => TestAccess,
                                    position => (0.00, 0.00));
      
      Put_Line ("X: " & Sf.Graphics.Text.getPosition (text => TestAccess).x'Wide_Wide_Image);
      Put_Line ("Y: " & Sf.Graphics.Text.getPosition (text => TestAccess).y'Wide_Wide_Image);
      Put_Line ("Gleft: " & Sf.Graphics.Text.getGlobalBounds (text => TestAccess).left'Wide_Wide_Image);
      Put_Line ("Gtop: " & Sf.Graphics.Text.getGlobalBounds (text => TestAccess).top'Wide_Wide_Image);
      Put_Line ("Gwidth: " & Sf.Graphics.Text.getGlobalBounds (text => TestAccess).width'Wide_Wide_Image);
      Put_Line ("Gheight: " & Sf.Graphics.Text.getGlobalBounds (text => TestAccess).height'Wide_Wide_Image);
      Put_Line ("Lleft: " & Sf.Graphics.Text.getLocalBounds (text => TestAccess).left'Wide_Wide_Image);
      Put_Line ("Ltop: " & Sf.Graphics.Text.getLocalBounds (text => TestAccess).top'Wide_Wide_Image);
      Put_Line ("Lwidth: " & Sf.Graphics.Text.getLocalBounds (text => TestAccess).width'Wide_Wide_Image);
      Put_Line ("Lheight: " & Sf.Graphics.Text.getLocalBounds (text => TestAccess).height'Wide_Wide_Image);
      New_Line (2);
      
   end Test;

end Test;
