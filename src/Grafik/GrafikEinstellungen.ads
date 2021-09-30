pragma SPARK_Mode (On);

with Sf.Window.VideoMode, Sf.Window.Cursor, Sf.Graphics, Sf.Graphics.Text;

with NutzerRecords;

package GrafikEinstellungen is
   
   Fenster : Sf.Graphics.sfRenderWindow_Ptr;
   
   Modus : Sf.Window.VideoMode.sfVideoMode := (640, 480, 32);
   MaximaleBilderrate : Sf.sfUint32 := 30;
   Zeiger : Sf.Window.sfCursor_Ptr := Sf.Window.Cursor.createFromSystem (cursorType => Sf.Window.Cursor.sfCursorHand);
   
   Schriftart : Sf.Graphics.sfFont_Ptr;
   Text : Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   
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
