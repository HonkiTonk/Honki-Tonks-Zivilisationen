with Sf.Graphics.Text;

with GrafikKonstanten;

with FensterGrafik;

package body TextberechnungenBreiteGrafik is
   
   function KleinerSpaltenabstandVariabel
     return Float
   is begin
      
      return 1.50 * FensterGrafik.AktuelleAuflösung.x / 100.00;
      
   end KleinerSpaltenabstandVariabel;
   
   
   
   function SpaltenabstandVariabel
     return Float
   is begin
      
      return 3.50 * FensterGrafik.AktuelleAuflösung.x / 100.00;
      
   end SpaltenabstandVariabel;
      
   

   function MittelpositionBerechnen
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr;
      ViewbreiteExtern : in Float)
      return Float
   is begin
      
      return ViewbreiteExtern / GrafikKonstanten.Halbierung - Sf.Graphics.Text.getLocalBounds (text => TextAccessExtern).width / GrafikKonstanten.Halbierung;
      
   end MittelpositionBerechnen;
   
   
   
   function MittelpositionBerechnenGlobaleGrenzen
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr;
      ViewbreiteExtern : in Float)
      return Float
   is begin
      
      return ViewbreiteExtern / GrafikKonstanten.Halbierung - Sf.Graphics.Text.getGlobalBounds (text => TextAccessExtern).width / GrafikKonstanten.Halbierung;
      
   end MittelpositionBerechnenGlobaleGrenzen;
   
   
   
   -- Wird aktuell nur für die Anzeige des Stadtnamens auf der Weltkarte benötigt.
   -- Dazu ist es nötigt die skalierte Textgröße zu kennen, da sonst der Text zu weit nach links verschoben wird.
   function HalbeBreiteBerechnenGlobaleGrenzen
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr)
      return Float
   is begin
            
      return Sf.Graphics.Text.getGlobalBounds (text => TextAccessExtern).width / GrafikKonstanten.Halbierung;
      
   end HalbeBreiteBerechnenGlobaleGrenzen;
   
   
   
   function NeueTextbreiteErmitteln
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr;
      TextbreiteExtern : in Float)
      return Float
   is begin
      
      NeueTextbreite := SpaltenabstandVariabel + Sf.Graphics.Text.getLocalBounds (text => TextAccessExtern).width;
      
      if
        NeueTextbreite > TextbreiteExtern
      then
         return NeueTextbreite;
           
      else
         return TextbreiteExtern;
      end if;
      
   end NeueTextbreiteErmitteln;
   
end TextberechnungenBreiteGrafik;
