pragma SPARK_Mode (On);

with Sf.Window.Cursor;
with Sf.Graphics;
with Sf.Graphics.Color;
with Sf.System.Vector2;

with SystemRecords;
with SystemDatentypen;
with SystemKonstanten;

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
   RassenFarbenStandard : constant RassenFarbenArray := [
                                                         SystemKonstanten.MenschenKonstante        => (255, 230, 200, 100),
                                                         SystemKonstanten.KasrodiahKonstante       => (255, 100, 40, 100),
                                                         SystemKonstanten.LasupinKonstante         => (65, 145, 140, 100),
                                                         SystemKonstanten.LamustraKonstante        => (60, 255, 240, 100),
                                                         SystemKonstanten.ManukyKonstante          => (255, 255, 30, 100),
                                                         SystemKonstanten.SurokaKonstante          => (135, 10, 255, 100),
                                                         SystemKonstanten.PryolonKonstante         => (65, 50, 15, 100),
                                                         SystemKonstanten.TalbidahrKonstante       => (255, 20, 255, 100),
                                                         SystemKonstanten.MoruPhisihlKonstante     => (255, 255, 180, 100),
                                                         SystemKonstanten.LarinosLotarisKonstante  => (255, 210, 135, 100),
                                                         SystemKonstanten.CarupexKonstante         => (210, 210, 210, 100),
                                                         SystemKonstanten.AlaryKonstante           => (165, 105, 0, 100),
                                                         SystemKonstanten.TesorahnKonstante        => (10, 60, 240, 100),
                                                         SystemKonstanten.NatriesZermanisKonstante => (170, 120, 130, 100),
                                                         SystemKonstanten.TridatusKonstante        => (20, 95, 20, 100),
                                                         SystemKonstanten.SenelariKonstante        => (0, 210, 0, 100),
                                                         SystemKonstanten.Aspari2Konstante         => (90, 90, 90, 100),
                                                         SystemKonstanten.EkropaKonstante          => (255, 30, 30, 100)
                                                        ];
   
end GrafikEinstellungenSFML;
