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
   
   
   
   function Achsenauswahlposition
     (MausachseExtern : in Float;
      BasiswertExtern : in Float;
      AnfangswertExtern : in GanzeZahl;
      EndwertExtern : in GanzeZahl)
      return GanzeZahl
   is begin
      
      AchseSchleife:
      for AchseSchleifenwert in AnfangswertExtern .. EndwertExtern loop
            
         if
           MausachseExtern in Float (AchseSchleifenwert) * BasiswertExtern .. Float (AchseSchleifenwert + 1) * BasiswertExtern
         then
            return AchseSchleifenwert;
               
         else
            null;
         end if;
               
      end loop AchseSchleife;
      
      return GanzeZahl'First;
      
   end Achsenauswahlposition;

end Vergleiche;
