with LeseEinstellungenGrafik;

with Vergleiche;

package body MausauswahlAllgemeinLogik is

   -- Verursacht Probleme wenn der Bereich nicht bei (0.00, 0.00) anfängt.
   function MauszeigerImView
     (MauspositionExtern : in Sf.System.Vector2.sfVector2f;
      BereichExtern : in Sf.System.Vector2.sfVector2f)
      return Boolean
   is begin
     
      Auflösung := LeseEinstellungenGrafik.Auflösung;
      
      return Vergleiche.AuswahlpositionVereinfacht (MauspositionExtern => MauspositionExtern,
                                                    VektorExtern       => (Float (Auflösung.x) * BereichExtern.x, Float (Auflösung.y) * BereichExtern.y));
      
   end MauszeigerImView;
   
   
   
   function MauszeigerImViewVerbessert
     (MauspositionExtern : in Sf.System.Vector2.sfVector2f;
      RechteckExtern : in Sf.Graphics.Rect.sfFloatRect)
      return Boolean
   is begin
      
      Auflösung := LeseEinstellungenGrafik.Auflösung;
      
      return Vergleiche.Auswahlposition (MauspositionExtern => MauspositionExtern,
                                         RechteckExtern     => (RechteckExtern.left * Float (Auflösung.x), RechteckExtern.top * Float (Auflösung.y), RechteckExtern.width * Float (Auflösung.x),
                                                                RechteckExtern.height * Float (Auflösung.y)));
      
   end MauszeigerImViewVerbessert;

end MausauswahlAllgemeinLogik;
