with Sf.Graphics;
with Sf.Graphics.Color;

with GrafikRecords;

package TexteinstellungenGrafik is
   pragma Elaborate_Body;

   SchriftartAccess : Sf.Graphics.sfFont_Ptr;
   
   -- Später auch was für den Textstyle einbauen? äöü
   Schriftgrößen : GrafikRecords.SchriftgrößenRecord;
   
   Schriftfarben : GrafikRecords.SchriftfarbenRecord;
   
   procedure StandardLaden;
   procedure SchriftartFestlegen;
   
private
   
   SchriftgrößenStandard : constant GrafikRecords.SchriftgrößenRecord := (
                                                                              SchriftgrößeÜberschrift => 36,
                                                                              SchriftgrößeStandard    => 24,
                                                                              SchriftgrößeKlein       => 12
                                                                             );
   
   SchriftfarbenStandard : constant GrafikRecords.SchriftfarbenRecord := (
                                                                          FarbeÜberschrift    => Sf.Graphics.Color.sfRed,
                                                                          FarbeStandardText   => Sf.Graphics.Color.sfWhite,
                                                                          FarbeAusgewähltText => Sf.Graphics.Color.sfGreen,
                                                                          FarbeMenschText     => Sf.Graphics.Color.sfBlue,
                                                                          FarbeKIText         => Sf.Graphics.Color.sfYellow,
                                                                          FarbeSonstigerText  => Sf.Graphics.Color.sfCyan
                                                                         );

end TexteinstellungenGrafik;
