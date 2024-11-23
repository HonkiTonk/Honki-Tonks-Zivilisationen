with GrafikKonstanten;

package body PruefungenGrafik is
      
   function NullprüfungFloatvektor
     (GrößeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      if
        GrößeExtern.x = GrafikKonstanten.Nullwert
      then
         Floatvektor.x := GrafikKonstanten.Einswert;
         
      else
         Floatvektor.x := GrößeExtern.x;
      end if;
      
      if
        GrößeExtern.y = GrafikKonstanten.Nullwert
      then
         Floatvektor.y := GrafikKonstanten.Einswert;
         
      else
         Floatvektor.y := GrößeExtern.y;
      end if;
      
      return Floatvektor;
      
   end NullprüfungFloatvektor;

end PruefungenGrafik;
