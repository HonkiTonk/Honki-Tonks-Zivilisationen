pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Text;

with TextKonstanten;

with EinstellungenGrafik;

package body TextberechnungenHoeheGrafik is
   
   function KleinerZeilenabstand
     return Float
   is begin
      
      return 15.00;
      
   end KleinerZeilenabstand;
   
   
   
   function KleinerZeilenabstandVariabel
     return Float
   is begin
      
      return 1.50 * EinstellungenGrafik.AktuelleFensterAuflösung.y / 100.00;
      
   end KleinerZeilenabstandVariabel;
   
   
   
   function Zeilenabstand
     return Float
   is begin
      
      return 35.00;
      
   end Zeilenabstand;
   
   
   
   function ZeilenabstandVariabel
     return Float
   is begin
      
      return 3.50 * EinstellungenGrafik.AktuelleFensterAuflösung.y / 100.00;
      
   end ZeilenabstandVariabel;
   
   
   
   function NeueTextposition
     (PositionExtern : in Float;
      TextAccessExtern : in Sf.Graphics.sfText_Ptr;
      ZusatzwertExtern : in Float)
      return Float
   is begin
      
      return PositionExtern + ZusatzwertExtern + Sf.Graphics.Text.getGlobalBounds (text => TextAccessExtern).height;
      
   end NeueTextposition;
   
   
   
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
