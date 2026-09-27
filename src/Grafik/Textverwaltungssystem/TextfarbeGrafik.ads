with Sf.Graphics.Color;

with MenueDatentypen;

package TextfarbeGrafik is
   pragma Elaborate_Body;

   function AuswahlfarbeFestlegen
     (TextnummerExtern : in Natural;
      AuswahlExtern : in Integer)
      return Sf.Graphics.Color.sfColor;
   
   function Standardfarbe
     return Sf.Graphics.Color.sfColor;
   
   function FarbeEinfachmenü
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      AktuelleAuswahlExtern : in Natural;
      AktuellerTextExtern : in Positive)
      return Sf.Graphics.Color.sfColor;
   
   function FarbeDoppelmenü
     (AktuellerTextExtern : in Positive;
      AktuelleAuswahlExtern : in Natural)
      return Sf.Graphics.Color.sfColor;
   
private
   
   AktuelleEinstellung : Natural;

end TextfarbeGrafik;
