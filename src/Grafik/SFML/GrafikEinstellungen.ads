pragma SPARK_Mode (On);

with Sf.Window.Cursor;
with Sf.Graphics;
with Sf.Graphics.Color;

with SystemRecords;

package GrafikEinstellungen is
   
   Fenster : Sf.Graphics.sfRenderWindow_Ptr;
   Maus : Sf.Window.sfCursor_Ptr;
   Schriftart : Sf.Graphics.sfFont_Ptr;
      
   FensterEinstellungen : SystemRecords.FensterRecord;
   
   type AktuelleAuflösung is record
      
      AktuelleFensterBreite : Sf.sfUint32;
      AktuelleFensterHöhe : Sf.sfUint32;
      
   end record;
   
   AktuelleFensterEinstellungen : AktuelleAuflösung;
   
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

end GrafikEinstellungen;
