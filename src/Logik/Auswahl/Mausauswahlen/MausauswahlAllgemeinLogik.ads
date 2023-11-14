with Sf.System.Vector2;
with Sf.Graphics.Rect;

package MausauswahlAllgemeinLogik is
   
   function MauszeigerImView
     (MauspositionExtern : in Sf.System.Vector2.sfVector2f;
      BereichExtern : in Sf.System.Vector2.sfVector2f)
      return Boolean;
   
   function MauszeigerImViewVerbessert
     (MauspositionExtern : in Sf.System.Vector2.sfVector2f;
      RechteckExtern : in Sf.Graphics.Rect.sfFloatRect)
      return Boolean;
   
private
   
   Auflösung : Sf.System.Vector2.sfVector2u;

end MausauswahlAllgemeinLogik;
