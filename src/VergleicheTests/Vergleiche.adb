with GrafikKonstanten;

package body Vergleiche is
   
   function Auswahlposition
     (MauspositionExtern : in Sf.System.Vector2.sfVector2f;
      TextboxExtern : in Sf.Graphics.Rect.sfFloatRect)
      return Boolean
   is begin
      
      -- Die Prüfung auf Valid muss hier drin sein, da bei der Mausauswahl die mapPixelToCoords scheinbar zu nicht validen Werten führen kann. äöü
      -- Später noch einmal genauer prüfen warum das so ist. Funktioniert beispielsweise im Baumenü auch ohne Valid, im Forschungsmenü allerdings nicht. äöü
      -- Oder liegt das einfach daran dass das durch die Logik und Grafik aufgerufen wird? Aber müsste es dann nicht auch beim Förschungsmenü Probleme bereiten? äöü
      if
        MauspositionExtern.x'Valid = False
        or
          MauspositionExtern.y'Valid = False
      then
         return False;
            
      elsif
        MauspositionExtern.x in TextboxExtern.left .. TextboxExtern.left + TextboxExtern.width
        and
          MauspositionExtern.y in TextboxExtern.top .. TextboxExtern.top + TextboxExtern.height
      then
         return True;
         
      else
         return False;
      end if;
      
   end Auswahlposition;
   
   
   
   function AuswahlpositionVereinfacht
     (MauspositionExtern : in Sf.System.Vector2.sfVector2f;
      TextboxExtern : in Sf.System.Vector2.sfVector2f)
      return Boolean
   is begin
      
      if
        MauspositionExtern.x'Valid = False
        or
          MauspositionExtern.y'Valid = False
      then
         return False;
            
      elsif
        MauspositionExtern.x in GrafikKonstanten.Nullwert .. TextboxExtern.x
        and
          MauspositionExtern.y in GrafikKonstanten.Nullwert .. TextboxExtern.y
      then
         return True;
         
      else
         return False;
      end if;
      
   end AuswahlpositionVereinfacht;
   
   
   
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
