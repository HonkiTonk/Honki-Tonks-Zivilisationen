pragma SPARK_Mode (On);

with Sf.Window.Cursor;
with Sf.Graphics;
with Sf.Graphics.Color;
with Sf.System.Vector2;

with SystemRecords;

package GrafikEinstellungen is
   
   Fenster : Sf.Graphics.sfRenderWindow_Ptr;
   Maus : Sf.Window.sfCursor_Ptr;
   Schriftart : Sf.Graphics.sfFont_Ptr;
   
   MausPosition : Sf.System.Vector2.sfVector2i;
      
   FensterEinstellungen : SystemRecords.FensterRecord;
   
   -- Hier mal einen globalen Zeilenabstand einbauen. Geht nicht so einfach da hier die Größe und alles noch gar nicht feststeht.
   
   AktuelleFensterAuflösung : Sf.System.Vector2.sfVector2u;
   
   type SchriftfarbenRecord is record
      
      FarbeÜberschrift : Sf.Graphics.Color.sfColor;
      FarbeStandardText : Sf.Graphics.Color.sfColor;
      FarbeAusgewähltText : Sf.Graphics.Color.sfColor;
      FarbeMenschText : Sf.Graphics.Color.sfColor;
      FarbeKIText : Sf.Graphics.Color.sfColor;
      FarbeSonstigerText : Sf.Graphics.Color.sfColor;
      
   end record;
   
   -- Später wie hier überall mehr konstante Standards und dann einfach zuweisen. Nutzereinstellungen dann auch in den Einstellugnen speichern!
   Schriftfarben : SchriftfarbenRecord := (
                                           FarbeÜberschrift    => Sf.Graphics.Color.sfRed,
                                           FarbeStandardText   => Sf.Graphics.Color.sfWhite,
                                           FarbeAusgewähltText => Sf.Graphics.Color.sfGreen,
                                           FarbeMenschText     => Sf.Graphics.Color.sfBlue,
                                           FarbeKIText         => Sf.Graphics.Color.sfYellow,
                                           FarbeSonstigerText  => Sf.Graphics.Color.sfCyan
                                          );
   
   procedure StandardGrafikEinstellungenLaden;
   
private
      
   FensterStandardEinstellungen : constant SystemRecords.FensterRecord := (
                                                                           FensterBreite => 640,
                                                                           FensterHöhe   => 480,
                                                                           Farbtiefe     => 32,
                                                                           Bildrate      => 30,
                                                                           MausZeiger    => Sf.Window.Cursor.sfCursorCross,
                                                                           
                                                                           Schriftgröße  => 24,
                                                                           Textfarbe     => Sf.Graphics.Color.sfWhite,
                                                                           Textstyle     => 0
                                                                          );
   
   SchriftfarbenStandard : constant SchriftfarbenRecord := (
                                                            FarbeÜberschrift    => Sf.Graphics.Color.sfRed,
                                                            FarbeStandardText   => Sf.Graphics.Color.sfWhite,
                                                            FarbeAusgewähltText => Sf.Graphics.Color.sfGreen,
                                                            FarbeMenschText     => Sf.Graphics.Color.sfBlue,
                                                            FarbeKIText         => Sf.Graphics.Color.sfYellow,
                                                            FarbeSonstigerText  => Sf.Graphics.Color.sfCyan
                                                           );
   

end GrafikEinstellungen;
