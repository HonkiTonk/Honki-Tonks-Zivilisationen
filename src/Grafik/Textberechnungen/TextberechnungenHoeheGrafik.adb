pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Text;

with TextKonstanten;

with EinstellungenGrafik;

package body TextberechnungenHoeheGrafik is
   
   function HalbeBildschirmhöhe
     return Float
   is begin
      
      return EinstellungenGrafik.AktuelleFensterAuflösung.y / 2.00;
      
   end HalbeBildschirmhöhe;
   
   
   
   function HalbeHöheBerechnen
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr)
      return Float
   is begin
      
      return Sf.Graphics.Text.getGlobalBounds (text => TextAccessExtern).height / 2.00;
      
   end HalbeHöheBerechnen;
   
   
   
   function KleinerZeilenabstand
     return Float
   is begin
      
      return 28.80; -- 1.20 * Float (TexteinstellungenGrafik.Schriftgrößen.SchriftgrößeStandard);
      
   end KleinerZeilenabstand;
   
   
   
   function Zeilenabstand
     return Float
   is begin
      
      return 36.00; -- 1.50 * Float (TexteinstellungenGrafik.Schriftgrößen.SchriftgrößeStandard);
      
   end Zeilenabstand;
   
   
   
   function GroßerZeilenabstand
     return Float
   is begin
      
      return 52.80; -- 2.20 * Float (TexteinstellungenGrafik.Schriftgrößen.SchriftgrößeStandard);
      
   end GroßerZeilenabstand;
   
   
   
   function Überschriftabstand
     return Float
   is begin
      
      return 90.00; -- 2.50 * Float (TexteinstellungenGrafik.Schriftgrößen.SchriftgrößeÜberschrift);
      
   end Überschriftabstand;
   
   
   
   function ÜberschriftabstandGroß
     return Float
   is begin
      
      return 180.00; -- 5.00 * Float (TexteinstellungenGrafik.Schriftgrößen.SchriftgrößeÜberschrift);
      
   end ÜberschriftabstandGroß;
   
   
   
   function NeueTexthöheErmitteln
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr;
      TexthöheExtern : in Float)
      return Float
   is begin
      
      NeueTexthöhe := TextKonstanten.TexthöheZusatzwert + Sf.Graphics.Text.getGlobalBounds (text => TextAccessExtern).height;
      
      if
        NeueTexthöhe > TexthöheExtern
      then
         return NeueTexthöhe;
           
      else
         return TexthöheExtern;
      end if;
      
   end NeueTexthöheErmitteln;
   
end TextberechnungenHoeheGrafik;
