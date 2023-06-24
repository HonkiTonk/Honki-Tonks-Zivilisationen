with LeseEinstellungenGrafik;

with Vergleiche;

package body MausauswahlAllgemeinLogik is

   function MauszeigerImView
     (MauspositionExtern : in Sf.System.Vector2.sfVector2f;
      BereichExtern : in Sf.System.Vector2.sfVector2f)
      return Boolean
   is begin
     
      -- Verursacht eventuell Probleme wenn der Bereich nicht bei (0.00, 0.00) anfängt, mal nachprüfen. äöü
      -- Ist das bei den Views überhaupt jemals der Fall? äöü
      Auflösung := LeseEinstellungenGrafik.Auflösung;
      
      return Vergleiche.AuswahlpositionVereinfacht (MauspositionExtern => MauspositionExtern,
                                                    VektorExtern       => (Float (Auflösung.x) * BereichExtern.x, Float (Auflösung.y) * BereichExtern.y));
      
   end MauszeigerImView;

end MausauswahlAllgemeinLogik;
