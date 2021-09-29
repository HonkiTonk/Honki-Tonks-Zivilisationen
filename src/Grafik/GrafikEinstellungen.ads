pragma SPARK_Mode (On);

with Sf.Window.VideoMode, Sf.Window.Cursor, Sf.Graphics;

with NutzerRecords;

package GrafikEinstellungen is
   
   Fenster : Sf.Graphics.sfRenderWindow_Ptr;
   
   Modus : Sf.Window.VideoMode.sfVideoMode := (640, 480, 32);
   MaximaleBilderrate : Sf.sfUint32 := 30;
   Zeiger : Sf.Window.sfCursor_Ptr := Sf.Window.Cursor.createFromSystem (cursorType => Sf.Window.Cursor.sfCursorHand);
   
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
