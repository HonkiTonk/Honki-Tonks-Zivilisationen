pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.System.Vector2;
private with Sf.Graphics.Rect;

with GrafikDatentypen;

package UeberschriftviewSFML is
   
   procedure Überschrift
     (ÜberschriftExtern : in Wide_Wide_String;
      HintergrundExtern : in GrafikDatentypen.Hintergrund_Texturen_Enum);
   
private
   
   Viewfläche : Sf.System.Vector2.sfVector2f := (5.00, 5.00);
   TextPosition : Sf.System.Vector2.sfVector2f;

   Anzeigebereich : constant Sf.Graphics.Rect.sfFloatRect := (0.00, 0.00, 1.00, 0.10);

end UeberschriftviewSFML;
