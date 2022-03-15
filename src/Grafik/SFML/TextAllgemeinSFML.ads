pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf;
with Sf.Graphics;
with Sf.Graphics.Color;

package TextAllgemeinSFML is

   procedure TextAccessEinstellen
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr;
      FontAccessExtern : in Sf.Graphics.sfFont_Ptr;
      SchriftgrößeExtern : in Sf.sfUint32;
      FarbeExtern : in Sf.Graphics.Color.sfColor);

end TextAllgemeinSFML;
