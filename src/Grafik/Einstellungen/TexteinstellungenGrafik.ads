pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics;
with Sf.Graphics.Color;

with SystemRecords;

package TexteinstellungenGrafik is

   SchriftartAccess : Sf.Graphics.sfFont_Ptr;
   
   -- Später wie hier überall mehr konstante Standards und dann einfach zuweisen. Nutzereinstellungen dann auch in den Einstellugnen speichern! äöü
   -- Lese- und Schreibefunktion/Prozedur dafür anlegen?
   -- Später auch was für den Textstyle einbauen? äöü
   Schriftgrößen : SystemRecords.SchriftgrößenRecord;
   
   Schriftfarben : SystemRecords.SchriftfarbenRecord;
   
   procedure StandardLaden;
   procedure SchriftartFestlegen;
   
private
   
   SchriftgrößenStandard : constant SystemRecords.SchriftgrößenRecord := (
                                                                              SchriftgrößeÜberschrift => 36,
                                                                              SchriftgrößeStandard    => 24,
                                                                              SchriftgrößeKlein       => 12
                                                                             );
   
   SchriftfarbenStandard : constant SystemRecords.SchriftfarbenRecord := (
                                                                          FarbeÜberschrift    => Sf.Graphics.Color.sfRed,
                                                                          FarbeStandardText   => Sf.Graphics.Color.sfWhite,
                                                                          FarbeAusgewähltText => Sf.Graphics.Color.sfGreen,
                                                                          FarbeMenschText     => Sf.Graphics.Color.sfBlue,
                                                                          FarbeKIText         => Sf.Graphics.Color.sfYellow,
                                                                          FarbeSonstigerText  => Sf.Graphics.Color.sfCyan
                                                                         );

end TexteinstellungenGrafik;