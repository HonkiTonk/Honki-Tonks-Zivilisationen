with Sf.Graphics;

private with Sf.Graphics.Color;

with MenueDatentypen;

package TextfarbeGrafik is
   pragma Elaborate_Body;
   use type Sf.Graphics.sfText_Ptr;

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
   
   procedure FarbeEinfachmenü
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      AktuelleAuswahlExtern : in Natural;
      AktuellerTextExtern : in Positive;
      TextaccessExtern : in Sf.Graphics.sfText_Ptr)
     with
       Pre => (
                 TextaccessExtern /= null
              );
   
private
   
   AktuelleEinstellung : Natural;
   
   Farbe : Sf.Graphics.Color.sfColor;

end TextfarbeGrafik;
