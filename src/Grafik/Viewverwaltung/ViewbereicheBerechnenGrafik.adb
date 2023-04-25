with GrafikKonstanten;

with InteraktionAllgemein;
with FensterGrafik;

package body ViewbereicheBerechnenGrafik is

   function ViewbereichBreiteHöheBerechnen
     (BereichExtern : in Sf.Graphics.Rect.sfFloatRect)
      return Sf.Graphics.Rect.sfFloatRect
   is begin
      
      NeuerBereich := BereichExtern;
      
      if
        InteraktionAllgemein.Mausposition.x = GrafikKonstanten.Nullwert
      then
         NeuerBereich.left := GrafikKonstanten.Nullwert;
            
      else
         NeuerBereich.left := InteraktionAllgemein.Mausposition.x / FensterGrafik.AktuelleAuflösung.x;
      end if;
         
      if
        NeuerBereich.left + NeuerBereich.width > GrafikKonstanten.MaximalerViewbereich
      then
         NeuerBereich.left := NeuerBereich.left - NeuerBereich.width;
            
      else
         null;
      end if;
         
      if
        InteraktionAllgemein.Mausposition.y = GrafikKonstanten.Nullwert
      then
         NeuerBereich.top := GrafikKonstanten.Nullwert;
            
      else
         NeuerBereich.top := InteraktionAllgemein.Mausposition.y / FensterGrafik.AktuelleAuflösung.y;
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
