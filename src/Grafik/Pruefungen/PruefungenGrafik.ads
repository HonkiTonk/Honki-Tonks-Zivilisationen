with Sf.System.Vector2;

package PruefungenGrafik is
   pragma Elaborate_Body;
   
   function NullprüfungKommazahl
     (KommazahlExtern : in Float)
      return Float
     with
       Post => (
                  NullprüfungKommazahl'Result /= 0.00
               );

   function NullprüfungFloatvektor
     (GrößeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  NullprüfungFloatvektor'Result.x /= 0.00
                and
                  NullprüfungFloatvektor'Result.y /= 0.00
               );
   
private
   
   Floatvektor : Sf.System.Vector2.sfVector2f;

end PruefungenGrafik;
