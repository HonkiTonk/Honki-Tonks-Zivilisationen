with GrafikKonstanten;
with InteraktionAuswahl;

with FensterGrafik;

package body ViewbereicheBerechnenGrafik is

   function ViewbereichBreiteHöheBerechnen
     (BereichExtern : in Sf.Graphics.Rect.sfFloatRect)
      return Sf.Graphics.Rect.sfFloatRect
   is begin
      
      NeuerBereich := BereichExtern;
      
      if
        InteraktionAuswahl.LeseXMausachse = GrafikKonstanten.Nullwert
      then
         NeuerBereich.left := GrafikKonstanten.Nullwert;
            
      else
         NeuerBereich.left := InteraktionAuswahl.LeseXMausachse / FensterGrafik.AktuelleAuflösung.x;
      end if;
         
      if
        NeuerBereich.left + NeuerBereich.width > GrafikKonstanten.MaximalerViewbereich
      then
         NeuerBereich.left := NeuerBereich.left - NeuerBereich.width;
            
      else
         null;
      end if;
         
      if
        InteraktionAuswahl.LeseYMausachse = GrafikKonstanten.Nullwert
      then
         NeuerBereich.top := GrafikKonstanten.Nullwert;
            
      else
         NeuerBereich.top := InteraktionAuswahl.LeseYMausachse / FensterGrafik.AktuelleAuflösung.y;
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
