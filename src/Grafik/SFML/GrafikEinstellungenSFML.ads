pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Window.Cursor;
with Sf.Graphics;
with Sf.Graphics.Color;
with Sf.System.Vector2;

with SystemRecords;
with SystemDatentypen;

package GrafikEinstellungenSFML is
   
   FensterAccess : Sf.Graphics.sfRenderWindow_Ptr;
   MausAccess : Sf.Window.sfCursor_Ptr;
   SchriftartAccess : Sf.Graphics.sfFont_Ptr;
   
   MausPosition : Sf.System.Vector2.sfVector2i := (1, 1);
      
   FensterEinstellungen : SystemRecords.FensterRecord;
   
   -- Hier mal einen globalen Zeilenabstand einbauen. Geht nicht so einfach da hier die Größe und alles noch gar nicht feststeht.
   
   AktuelleFensterAuflösung : Sf.System.Vector2.sfVector2u;
   
   -- Später wie hier überall mehr konstante Standards und dann einfach zuweisen. Nutzereinstellungen dann auch in den Einstellugnen speichern!
   Schriftfarben : SystemRecords.SchriftfarbenRecord;
   
   type RassenFarbenArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range) of Sf.Graphics.Color.sfColor;
   -- Weniger transparente Version für Rahmen bauen. Dann das hier nur leicht transparent machen und den Rahmen dann gar nicht.
   RassenFarben : RassenFarbenArray;
   RassenFarbenRahmen : RassenFarbenArray;
   
   procedure StandardGrafikEinstellungenLaden;
   
private
   
   -- No border / title bar = 0
   -- Title bar + fixed border = 1
   -- Titlebar + resizable border + maximize button = 2
   -- Titlebar + close button = 4
   -- Fullscreen mode = 8
   -- Default window style = 7
      
   FensterStandardEinstellungen : constant SystemRecords.FensterRecord := (
                                                                           FensterVollbild => 7,
                                                                           FensterBreite   => 640,
                                                                           FensterHöhe     => 480,
                                                                           Farbtiefe       => 32,
                                                                           Bildrate        => 30,
                                                                           MausZeiger      => Sf.Window.Cursor.sfCursorCross,
                                                                           
                                                                           Schriftgröße    => 24,
                                                                           Textfarbe       => Sf.Graphics.Color.sfWhite,
                                                                           Textstyle       => 0
                                                                          );
   
   SchriftfarbenStandard : constant SystemRecords.SchriftfarbenRecord := (
                                                                          FarbeÜberschrift    => Sf.Graphics.Color.sfRed,
                                                                          FarbeStandardText   => Sf.Graphics.Color.sfWhite,
                                                                          FarbeAusgewähltText => Sf.Graphics.Color.sfGreen,
                                                                          FarbeMenschText     => Sf.Graphics.Color.sfBlue,
                                                                          FarbeKIText         => Sf.Graphics.Color.sfYellow,
                                                                          FarbeSonstigerText  => Sf.Graphics.Color.sfCyan
                                                                         );
   
   -- Weniger transparente Version für Rahmen bauen. Dann das hier nur leicht transparent machen und den Rahmen dann gar nicht.
   RassenFarbenStandard : constant RassenFarbenArray := (
                                                         SystemDatentypen.Menschen_Enum        => (255, 230, 200, 75),
                                                         SystemDatentypen.Kasrodiah_Enum       => (255, 100, 40, 75),
                                                         SystemDatentypen.Lasupin_Enum         => (65, 145, 140, 75),
                                                         SystemDatentypen.Lamustra_Enum        => (60, 255, 240, 75),
                                                         SystemDatentypen.Manuky_Enum          => (255, 255, 30, 75),
                                                         SystemDatentypen.Suroka_Enum          => (135, 10, 255, 75),
                                                         SystemDatentypen.Pryolon_Enum         => (65, 50, 15, 75),
                                                         SystemDatentypen.Talbidahr_Enum       => (255, 20, 255, 75),
                                                         SystemDatentypen.Moru_Phisihl_Enum     => (255, 255, 180, 75),
                                                         SystemDatentypen.Larinos_Lotaris_Enum  => (255, 210, 135, 75),
                                                         SystemDatentypen.Carupex_Enum         => (210, 210, 210, 75),
                                                         SystemDatentypen.Alary_Enum           => (165, 105, 0, 75),
                                                         SystemDatentypen.Tesorahn_Enum        => (10, 60, 240, 75),
                                                         SystemDatentypen.Natries_Zermanis_Enum => (170, 120, 130, 75),
                                                         SystemDatentypen.Tridatus_Enum        => (20, 95, 20, 75),
                                                         SystemDatentypen.Senelari_Enum        => (0, 210, 0, 75),
                                                         SystemDatentypen.Aspari_2_Enum         => (90, 90, 90, 75),
                                                         SystemDatentypen.Ekropa_Enum          => (255, 30, 30, 75)
                                                        );
   
   RassenFarbenRahmenStandard : constant RassenFarbenArray := (
                                                               SystemDatentypen.Menschen_Enum        => (255, 230, 200, 255),
                                                               SystemDatentypen.Kasrodiah_Enum       => (255, 100, 40, 255),
                                                               SystemDatentypen.Lasupin_Enum         => (65, 145, 140, 255),
                                                               SystemDatentypen.Lamustra_Enum        => (60, 255, 240, 255),
                                                               SystemDatentypen.Manuky_Enum          => (255, 255, 30, 255),
                                                               SystemDatentypen.Suroka_Enum          => (135, 10, 255, 255),
                                                               SystemDatentypen.Pryolon_Enum         => (65, 50, 15, 255),
                                                               SystemDatentypen.Talbidahr_Enum       => (255, 20, 255, 255),
                                                               SystemDatentypen.Moru_Phisihl_Enum     => (255, 255, 180, 255),
                                                               SystemDatentypen.Larinos_Lotaris_Enum  => (255, 210, 135, 255),
                                                               SystemDatentypen.Carupex_Enum         => (210, 210, 210, 255),
                                                               SystemDatentypen.Alary_Enum           => (165, 105, 0, 255),
                                                               SystemDatentypen.Tesorahn_Enum        => (10, 60, 240, 255),
                                                               SystemDatentypen.Natries_Zermanis_Enum => (170, 120, 130, 255),
                                                               SystemDatentypen.Tridatus_Enum        => (20, 95, 20, 255),
                                                               SystemDatentypen.Senelari_Enum        => (0, 210, 0, 255),
                                                               SystemDatentypen.Aspari_2_Enum         => (90, 90, 90, 255),
                                                               SystemDatentypen.Ekropa_Enum          => (255, 30, 30, 255)
                                                              );
   
end GrafikEinstellungenSFML;
