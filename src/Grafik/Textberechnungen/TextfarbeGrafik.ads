pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics; use Sf.Graphics;

private with Sf.Graphics.Color;

package TextfarbeGrafik is

   procedure AuswahlfarbeFestlegen
     (TextnummerExtern : in Natural;
      AuswahlExtern : in Integer;
      TextaccessExtern : in Sf.Graphics.sfText_Ptr)
     with
       Pre => (
                 TextaccessExtern /= null
              );
   
   procedure Standardfarbe
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr)
     with
       Pre => (
                 TextaccessExtern /= null
              );
   
private
   
   Farbe : Sf.Graphics.Color.sfColor;

end TextfarbeGrafik;
