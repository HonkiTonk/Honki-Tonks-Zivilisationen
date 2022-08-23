pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Text;

with TextKonstanten;

package body TextberechnungenBreiteSFML is

   function MittelpositionBerechnen
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr;
      ViewbreiteExtern : in Float)
      return Float
   is begin
      
      return ViewbreiteExtern / 2.00 - HalbeBreiteBerechnen (TextAccessExtern => TextAccessExtern);
      
   end MittelpositionBerechnen;
   
   
   
   function HalbeBreiteBerechnen
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr)
      return Float
   is begin
      
      return Sf.Graphics.Text.getGlobalBounds (text => TextAccessExtern).width / 2.00;
      
   end HalbeBreiteBerechnen;
   
   
   
   function NeueTextbreiteErmitteln
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr;
      TextbreiteExtern : in Float)
      return Float
   is begin
      
      NeueTextbreite := TextKonstanten.TextbreiteZusatzwert + Sf.Graphics.Text.getGlobalBounds (text => TextAccessExtern).width;
      
      if
        NeueTextbreite > TextbreiteExtern
      then
         return NeueTextbreite;
           
      else
         return TextbreiteExtern;
      end if;
      
   end NeueTextbreiteErmitteln;
   
end TextberechnungenBreiteSFML;
