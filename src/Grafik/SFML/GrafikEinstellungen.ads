pragma SPARK_Mode (On);

with Sf.Window.Cursor;
with Sf.Graphics;
with Sf.Graphics.Text;
with Sf.Graphics.Color;
with Sf.System.Vector2;

with SystemRecords;

package GrafikEinstellungen is
   
   Fenster : Sf.Graphics.sfRenderWindow_Ptr;
   
   FensterEinstellungen : SystemRecords.FensterRecord := (
                                                          FensterBreite    => 640,
                                                          FensterHöhe      => 480,
                                                          Farbtiefe        => 32,
                                                          Bildrate         => 30,
                                                          MausZeiger       => Sf.Window.Cursor.sfCursorCross
                                                         );
   
   Maus : Sf.Window.sfCursor_Ptr;
      
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
                                                                           FensterBreite    => 640,
                                                                           FensterHöhe      => 480,
                                                                           Farbtiefe        => 32,
                                                                           Bildrate         => 30,
                                                                           MausZeiger       => Sf.Window.Cursor.sfCursorCross
                                                                          );

end GrafikEinstellungen;
