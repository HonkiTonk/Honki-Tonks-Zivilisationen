with MeldungssystemHTB1;

with GrafikKonstanten;

package body Vergleiche is
   
   function Auswahlposition
     (MauspositionExtern : in Sf.System.Vector2.sfVector2f;
      RechteckExtern : in Sf.Graphics.Rect.sfFloatRect)
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
        MauspositionExtern.x in RechteckExtern.left .. RechteckExtern.left + RechteckExtern.width
        and
          MauspositionExtern.y in RechteckExtern.top .. RechteckExtern.top + RechteckExtern.height
      then
         return True;
         
      else
         return False;
      end if;
      
   end Auswahlposition;
   
   
   
   function AuswahlpositionVereinfacht
     (MauspositionExtern : in Sf.System.Vector2.sfVector2f;
      VektorExtern : in Sf.System.Vector2.sfVector2f)
      return Boolean
   is begin
      
      if
        MauspositionExtern.x'Valid = False
        or
          MauspositionExtern.y'Valid = False
      then
         return False;
            
      elsif
        MauspositionExtern.x in GrafikKonstanten.Nullwert .. VektorExtern.x
        and
          MauspositionExtern.y in GrafikKonstanten.Nullwert .. VektorExtern.y
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
   
   
   
   function FreieEinwohner
     (EinwohnerExtern : in StadtDatentypen.Einwohner;
      ArbeiterExtern : in StadtDatentypen.Einwohner)
      return StadtDatentypen.Einwohner
   is begin
      
      if
        ArbeiterExtern > EinwohnerExtern
      then
         MeldungssystemHTB1.Sonstiges (MeldungExtern => "Vergleiche.FreieEinwohner: Einwohner < Arbeiter:" & EinwohnerExtern'Wide_Wide_Image & "," & ArbeiterExtern'Wide_Wide_Image);
         return StadtDatentypen.Einwohner'First;
         
      else
         return EinwohnerExtern - ArbeiterExtern;
      end if;
      
   end FreieEinwohner;

end Vergleiche;
