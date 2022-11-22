with Sf.Graphics.Text;

with KartenartDatentypen;
with SystemKonstanten;
with SpielDatentypen;

with LeseAllgemeines;

with KartengeneratorVariablenLogik;
with TexteinstellungenGrafik;

package body TextfarbeGrafik is

   procedure AuswahlfarbeFestlegen
     (TextnummerExtern : in Natural;
      AuswahlExtern : in Integer;
      TextaccessExtern : in Sf.Graphics.sfText_Ptr)
   is begin
      
      if
        AuswahlExtern = TextnummerExtern
      then
         Farbe := TexteinstellungenGrafik.Schriftfarben.FarbeAusgewähltText;
            
      else
         Farbe := TexteinstellungenGrafik.Schriftfarben.FarbeStandardText;
      end if;
      
      Sf.Graphics.Text.setColor (text  => TextaccessExtern,
                                 color => Farbe);
      
   end AuswahlfarbeFestlegen;
   
   
   
   procedure Standardfarbe
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr)
   is begin
      
      Sf.Graphics.Text.setColor (text  => TextaccessExtern,
                                 color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
      
   end Standardfarbe;
   
   
   
   procedure FarbeEinfachmenü
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      AktuelleAuswahlExtern : in Natural;
      AktuellerTextExtern : in Positive;
      TextaccessExtern : in Sf.Graphics.sfText_Ptr)
   is begin
            
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Kartenart_Menü_Enum =>
            AktuelleEinstellung := SystemKonstanten.StandardArrayanpassung + KartenartDatentypen.Kartenart_Enum'Pos (KartengeneratorVariablenLogik.Kartenparameter.Kartenart);
            
         when MenueDatentypen.Kartentemperatur_Menü_Enum =>
            AktuelleEinstellung := SystemKonstanten.StandardArrayanpassung + KartenartDatentypen.Kartentemperatur_Enum'Pos (KartengeneratorVariablenLogik.Kartenparameter.Kartentemperatur);
            
         when MenueDatentypen.Kartenressourcen_Menü_Enum =>
            AktuelleEinstellung := SystemKonstanten.StandardArrayanpassung + KartenartDatentypen.Kartenressourcen_Enum'Pos (KartengeneratorVariablenLogik.Kartenparameter.Kartenressourcen);
            
         when MenueDatentypen.Schwierigkeitsgrad_Menü_Enum =>
            AktuelleEinstellung := SystemKonstanten.StandardArrayanpassung + SpielDatentypen.Schwierigkeitsgrad_Enum'Pos (LeseAllgemeines.Schwierigkeitsgrad);
            
         when others =>
            AktuelleEinstellung := 0;
      end case;
      
      if
        AktuellerTextExtern = AktuelleAuswahlExtern
      then
         Farbe := TexteinstellungenGrafik.Schriftfarben.FarbeAusgewähltText;
         
      elsif
        AktuelleEinstellung = AktuellerTextExtern
      then
         Farbe := TexteinstellungenGrafik.Schriftfarben.FarbeMenschText;
      
      else
         Farbe := TexteinstellungenGrafik.Schriftfarben.FarbeStandardText;
      end if;
   
      Sf.Graphics.Text.setColor (text  => TextaccessExtern,
                                 color => Farbe);
      
   end FarbeEinfachmenü;

end TextfarbeGrafik;
