with KartenartDatentypen;
with MenueKonstanten;
with SpielDatentypen;
with SpeziesKonstanten;
with SpeziesDatentypen;
with TextDatentypen;
with AuswahlKonstanten;

with LeseAllgemeines;
with LeseSpeziesbelegung;

with KartengeneratorVariablenLogik;
with TexteinstellungenGrafik;

package body TextfarbeGrafik is

   function AuswahlfarbeFestlegen
     (TextnummerExtern : in Natural;
      AuswahlExtern : in Integer)
      return Sf.Graphics.Color.sfColor
   is begin
      
      if
        AuswahlExtern = TextnummerExtern
      then
         return TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Ausgewählt_Enum);
            
      else
         return Standardfarbe;
      end if;
      
   end AuswahlfarbeFestlegen;
   
   
   
   function Standardfarbe
     return Sf.Graphics.Color.sfColor
   is begin
      
      return TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Standard_Enum);
      
   end Standardfarbe;
   
   
   
   function FarbeEinfachmenü
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      AktuelleAuswahlExtern : in Natural;
      AktuellerTextExtern : in Positive)
      return Sf.Graphics.Color.sfColor
   is begin
            
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Kartenart_Menü_Enum =>
            AktuelleEinstellung := MenueKonstanten.StandardArrayanpassung + KartenartDatentypen.Kartenart_Enum'Pos (KartengeneratorVariablenLogik.Kartenparameter.Kartenart);
            
         when MenueDatentypen.Kartentemperatur_Menü_Enum =>
            AktuelleEinstellung := MenueKonstanten.StandardArrayanpassung + KartenartDatentypen.Kartentemperatur_Enum'Pos (KartengeneratorVariablenLogik.Kartenparameter.Kartentemperatur);
            
         when MenueDatentypen.Kartenressourcen_Menü_Enum =>
            AktuelleEinstellung := MenueKonstanten.StandardArrayanpassung + KartenartDatentypen.Kartenressourcenmenge_Enum'Pos (KartengeneratorVariablenLogik.Kartenparameter.Kartenressourcen);
            
         when MenueDatentypen.Schwierigkeitsgrad_Menü_Enum =>
            AktuelleEinstellung := MenueKonstanten.StandardArrayanpassung + SpielDatentypen.Schwierigkeitsgrad_Enum'Pos (LeseAllgemeines.Schwierigkeitsgrad);
            
         when others =>
            AktuelleEinstellung := AuswahlKonstanten.LeerAuswahl;
      end case;
      
      if
        AktuellerTextExtern = AktuelleAuswahlExtern
      then
         return TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Ausgewählt_Enum);
         
      elsif
        AktuelleEinstellung = AktuellerTextExtern
      then
         return TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Mensch_Enum);
      
      else
         return Standardfarbe;
      end if;
      
   end FarbeEinfachmenü;
   
   
   
   function FarbeDoppelmenü
     (AktuellerTextExtern : in Positive;
      AktuelleAuswahlExtern : in Natural)
      return Sf.Graphics.Color.sfColor
   is begin
      
      if
        AktuelleAuswahlExtern = AktuellerTextExtern
      then
         return TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Ausgewählt_Enum);
         
      elsif
        AktuellerTextExtern - 1 in SpeziesKonstanten.Speziesanfang .. SpeziesKonstanten.Speziesende
      then
         case
           LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesDatentypen.Spezies_Verwendet_Enum'Val (AktuellerTextExtern - 1))
         is
            when SpeziesDatentypen.Mensch_Spieler_Enum =>
               return TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Mensch_Enum);
               
            when SpeziesDatentypen.KI_Spieler_Enum =>
               return TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.KI_Enum);
               
            when others =>
               null;
         end case;
               
      else
         null;
      end if;
      
      return Standardfarbe;
      
   end FarbeDoppelmenü;

end TextfarbeGrafik;
