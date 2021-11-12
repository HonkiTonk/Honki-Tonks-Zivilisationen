pragma SPARK_Mode (On);

with Sf.Window.Cursor;
with Sf.Graphics;
with Sf.Graphics.Text;
with Sf.Graphics.Color;
with Sf.System.Vector2;

with SystemRecords;

package GrafikEinstellungen is
   
   Fenster : Sf.Graphics.sfRenderWindow_Ptr;
   
   FensterBreite : Sf.sfUint32 := 640;
   FensterHöhe : Sf.sfUint32 := 480;
   PixelBit : Sf.sfUint32 := 32;
   MaximaleBilderrate : Sf.sfUint32 := 30;
   MausZeiger : Sf.Window.sfCursor_Ptr := Sf.Window.Cursor.createFromSystem (cursorType => Sf.Window.Cursor.sfCursorCross);
   
   Schriftart : Sf.Graphics.sfFont_Ptr;
   Schriftgröße : Sf.sfUint32 := 24;
   Textfarbe : Sf.Graphics.Color.sfColor := Sf.Graphics.Color.sfWhite;
   Textstyle : Sf.sfUint32 := 0;
   TextStandard : Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   
   AnzeigeAnfang : Sf.System.Vector2.sfVector2f := (10.00, 10.00);
   
   procedure StandardGrafikEinstellungenLaden;
   
private
   
   SchriftgrößeStandard : constant Sf.sfUint32 := 24;
   TextstyleStandard : constant Sf.sfUint32 := 0;
   
   FensterStandardEinstellungen : constant SystemRecords.FensterRecord := (
                                                                           Breite    => 640,
                                                                           Höhe      => 480,
                                                                           Farbtiefe => 32,
                                                                           Bildrate  => 30,
                                                                           Zeiger    => Sf.Window.Cursor.createFromSystem (cursorType => Sf.Window.Cursor.sfCursorCross)
                                                                          );

end GrafikEinstellungen;
