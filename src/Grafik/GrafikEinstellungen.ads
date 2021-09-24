pragma SPARK_Mode (On);

with GlobaleRecords;

with Sf.Window.VideoMode, Sf.Window.Cursor;

package GrafikEinstellungen is
   
   Modus : Sf.Window.VideoMode.sfVideoMode := (640, 480, 32);
   MaximaleBilderrate : Sf.sfUint32 := 30;
   Zeiger : Sf.Window.sfCursor_Ptr := Sf.Window.Cursor.createFromSystem (cursorType => Sf.Window.Cursor.sfCursorHand);
   
   procedure StandardGrafikEinstellungenLaden;
   
private
   
   FensterStandardEinstellungen : constant GlobaleRecords.FensterRecord := (
                                                                            Breite    => 640,
                                                                            Höhe      => 480,
                                                                            Farbtiefe => 32,
                                                                            Bildrate  => 30,
                                                                            Zeiger    => Sf.Window.Cursor.createFromSystem (cursorType => Sf.Window.Cursor.sfCursorHand)
                                                                           );

end GrafikEinstellungen;
