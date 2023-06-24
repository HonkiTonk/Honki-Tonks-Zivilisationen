with Sf.System.Vector2;

package MausauswahlAllgemeinLogik is
   
   function MauszeigerImView
     (MauspositionExtern : in Sf.System.Vector2.sfVector2f;
      BereichExtern : in Sf.System.Vector2.sfVector2f)
      return Boolean;
   
private
   
   Auflösung : Sf.System.Vector2.sfVector2u;

end MausauswahlAllgemeinLogik;
