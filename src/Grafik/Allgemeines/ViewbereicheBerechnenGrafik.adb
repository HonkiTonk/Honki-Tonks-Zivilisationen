with GrafikKonstanten;

with InteraktionAllgemein;
with EinstellungenGrafik;

package body ViewbereicheBerechnenGrafik is

   function ViewbereichBreiteHöheBerechnen
     (BereichExtern : in Sf.Graphics.Rect.sfFloatRect)
      return Sf.Graphics.Rect.sfFloatRect
   is begin
      
      NeuerBereich := BereichExtern;
      
      if
        InteraktionAllgemein.Mausposition.x = GrafikKonstanten.Nullposition
      then
         NeuerBereich.left := GrafikKonstanten.Nullposition;
            
      else
         NeuerBereich.left := InteraktionAllgemein.Mausposition.x / EinstellungenGrafik.AktuelleFensterAuflösung.x;
      end if;
         
      if
        NeuerBereich.left + NeuerBereich.width > GrafikKonstanten.MaximalerViewbereich
      then
         NeuerBereich.left := NeuerBereich.left - NeuerBereich.width;
            
      else
         null;
      end if;
         
      if
        InteraktionAllgemein.Mausposition.y = GrafikKonstanten.Nullposition
      then
         NeuerBereich.top := GrafikKonstanten.Nullposition;
            
      else
         NeuerBereich.top := InteraktionAllgemein.Mausposition.y / EinstellungenGrafik.AktuelleFensterAuflösung.y;
      end if;
         
      if
        NeuerBereich.top + NeuerBereich.height > GrafikKonstanten.MaximalerViewbereich
      then
         NeuerBereich.top := NeuerBereich.top - NeuerBereich.height;
            
      else
         null;
      end if;
      
      return NeuerBereich;
      
   end ViewbereichBreiteHöheBerechnen;

end ViewbereicheBerechnenGrafik;
