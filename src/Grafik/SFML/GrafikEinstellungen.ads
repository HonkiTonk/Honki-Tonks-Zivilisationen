pragma SPARK_Mode (On);

with Sf.Window.Cursor;
with Sf.Graphics;
with Sf.Graphics.Color;
with Sf.System.Vector2;

with SystemRecords;
with SystemDatentypen;

package GrafikEinstellungen is
   
   FensterAccess : Sf.Graphics.sfRenderWindow_Ptr;
   MausAccess : Sf.Window.sfCursor_Ptr;
   SchriftartAccess : Sf.Graphics.sfFont_Ptr;
   
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
   
   type RassenFarbenArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range) of Sf.Graphics.Color.sfColor;
   -- Weniger transparente Version für Rahmen bauen.
   RassenFarben : RassenFarbenArray := (
                                        SystemDatentypen.Menschen         => (0, 0, 255, 40),
                                        SystemDatentypen.Kasrodiah        => (0, 0, 255, 40),
                                        SystemDatentypen.Lasupin          => (0, 0, 255, 40),
                                        SystemDatentypen.Lamustra         => (0, 0, 255, 40),
                                        SystemDatentypen.Manuky           => (0, 0, 255, 40),
                                        SystemDatentypen.Suroka           => (0, 0, 255, 40),
                                        SystemDatentypen.Pryolon          => (0, 0, 255, 40),
                                        SystemDatentypen.Talbidahr        => (0, 0, 255, 40),
                                        SystemDatentypen.Moru_Phisihl     => (0, 0, 255, 40),
                                        SystemDatentypen.Larinos_Lotaris  => (0, 0, 255, 40),
                                        SystemDatentypen.Carupex          => (0, 0, 255, 40),
                                        SystemDatentypen.Alary            => (0, 0, 255, 40),
                                        SystemDatentypen.Tesorahn         => (0, 0, 255, 40),
                                        SystemDatentypen.Natries_Zermanis => (0, 0, 255, 40),
                                        SystemDatentypen.Tridatus         => (0, 0, 255, 40),
                                        SystemDatentypen.Senelari         => (0, 255, 0, 40),
                                        SystemDatentypen.Aspari_2         => (0, 0, 255, 40),
                                        SystemDatentypen.Ekropa           => (255, 0, 0, 40)
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
   
   RassenFarbenStandard : constant RassenFarbenArray := (
                                                         SystemDatentypen.Menschen         => (0, 0, 255, 40),
                                                         SystemDatentypen.Kasrodiah        => (0, 0, 255, 40),
                                                         SystemDatentypen.Lasupin          => (0, 0, 255, 40),
                                                         SystemDatentypen.Lamustra         => (0, 0, 255, 40),
                                                         SystemDatentypen.Manuky           => (0, 0, 255, 40),
                                                         SystemDatentypen.Suroka           => (0, 0, 255, 40),
                                                         SystemDatentypen.Pryolon          => (0, 0, 255, 40),
                                                         SystemDatentypen.Talbidahr        => (0, 0, 255, 40),
                                                         SystemDatentypen.Moru_Phisihl     => (0, 0, 255, 40),
                                                         SystemDatentypen.Larinos_Lotaris  => (0, 0, 255, 40),
                                                         SystemDatentypen.Carupex          => (0, 0, 255, 40),
                                                         SystemDatentypen.Alary            => (0, 0, 255, 40),
                                                         SystemDatentypen.Tesorahn         => (0, 0, 255, 40),
                                                         SystemDatentypen.Natries_Zermanis => (0, 0, 255, 40),
                                                         SystemDatentypen.Tridatus         => (0, 0, 255, 40),
                                                         SystemDatentypen.Senelari         => (0, 255, 0, 40),
                                                         SystemDatentypen.Aspari_2         => (0, 0, 255, 40),
                                                         SystemDatentypen.Ekropa           => (255, 0, 0, 40)
                                                        );
   
end GrafikEinstellungen;
