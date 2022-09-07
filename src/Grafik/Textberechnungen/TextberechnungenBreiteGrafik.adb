pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Text;

with EinstellungenGrafik;

package body TextberechnungenBreiteGrafik is
   
   function KleinerSpaltenabstandVariabel
     return Float
   is begin
      
      return 1.50 * EinstellungenGrafik.AktuelleFensterAuflösung.x / 100.00;
      
   end KleinerSpaltenabstandVariabel;
   
   
   
   function SpaltenabstandVariabel
     return Float
   is begin
      
      return 3.50 * EinstellungenGrafik.AktuelleFensterAuflösung.x / 100.00;
      
   end SpaltenabstandVariabel;
      
   

   function MittelpositionBerechnen
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr;
      ViewbreiteExtern : in Float)
      return Float
   is begin
      
      return ViewbreiteExtern / 2.00 - Sf.Graphics.Text.getGlobalBounds (text => TextAccessExtern).width / 2.00;
      
   end MittelpositionBerechnen;
   
   
   
   -- Wird aktuell für die Anzeige des Stadtnamens auf der Weltkarte benötigt, später mal überarbeiten und dann das hier entfernen. äöü
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
      
      NeueTextbreite := SpaltenabstandVariabel + Sf.Graphics.Text.getGlobalBounds (text => TextAccessExtern).width;
      
      if
        NeueTextbreite > TextbreiteExtern
      then
         return NeueTextbreite;
           
      else
         return TextbreiteExtern;
      end if;
      
   end NeueTextbreiteErmitteln;
   
end TextberechnungenBreiteGrafik;
