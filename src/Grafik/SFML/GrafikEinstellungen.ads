pragma SPARK_Mode (On);

with Sf.Window.VideoMode;
with Sf.Window.Cursor;
with Sf.Graphics;
with Sf.Graphics.Text;
with Sf.Graphics.Color;

with NutzerRecords;

package GrafikEinstellungen is
   
   Fenster : Sf.Graphics.sfRenderWindow_Ptr;
   
   FensterBreite : Sf.sfUint32 := 640;
   FensterHöhe : Sf.sfUint32 := 480;
   PixelBit : Sf.sfUint32 := 32;
   EinstellungenFenster : Sf.Window.VideoMode.sfVideoMode := (FensterBreite, FensterHöhe, PixelBit);
   Modus : Sf.Window.VideoMode.sfVideoMode := EinstellungenFenster;
   MaximaleBilderrate : Sf.sfUint32 := 30;
   MausZeiger : Sf.Window.sfCursor_Ptr := Sf.Window.Cursor.createFromSystem (cursorType => Sf.Window.Cursor.sfCursorHand);
   
   Schriftart : Sf.Graphics.sfFont_Ptr;
   Schriftgröße : Sf.sfUint32;
   Textfarbe : Sf.Graphics.Color.sfColor;
   Textstyle : Sf.sfUint32;
   TextStandard : Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   
   procedure StandardGrafikEinstellungenLaden;
   
private
   
   FensterStandardEinstellungen : constant NutzerRecords.FensterRecord := (
                                                                           Breite    => 640,
                                                                           Höhe      => 480,
                                                                           Farbtiefe => 32,
                                                                           Bildrate  => 30,
                                                                           Zeiger    => Sf.Window.Cursor.createFromSystem (cursorType => Sf.Window.Cursor.sfCursorHand)
                                                                          );

end GrafikEinstellungen;
