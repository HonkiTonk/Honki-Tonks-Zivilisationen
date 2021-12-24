pragma SPARK_Mode (On);

with Sf;
with Sf.Graphics;
with Sf.Graphics.Color;

package GrafikTextAllgemein is

   procedure TextAccessEinstellen
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr;
      FontAccessExtern : in Sf.Graphics.sfFont_Ptr;
      SchriftgrößeExtern : in Sf.sfUint32;
      FarbeExtern : in Sf.Graphics.Color.sfColor);

end GrafikTextAllgemein;
