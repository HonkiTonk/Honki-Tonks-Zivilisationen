package body Vergleiche is
   
   function Auswahlposition
     (MauspositionExtern : in Sf.System.Vector2.sfVector2f;
      TextboxExtern : in Sf.Graphics.Rect.sfFloatRect)
      return Boolean
   is begin
            
      if
        MauspositionExtern.x in TextboxExtern.left .. TextboxExtern.left + TextboxExtern.width
        and
          MauspositionExtern.y in TextboxExtern.top .. TextboxExtern.top + TextboxExtern.height
      then
         return True;
         
      else
         return False;
      end if;
      
   end Auswahlposition;

end Vergleiche;
