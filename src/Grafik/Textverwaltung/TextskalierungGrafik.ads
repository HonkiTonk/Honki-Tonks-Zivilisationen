with Sf.System.Vector2;

package TextskalierungGrafik is
   pragma Elaborate_Body;

   function Breitenskalierung
     (AktuelleBreiteExtern : in Float;
      ErlaubteBreiteExtern : in Float)
      return Float
     with
       Pre => (
                 AktuelleBreiteExtern >= 0.00
               and
                 ErlaubteBreiteExtern >= 0.00
              ),
         
       Post => (
                  Breitenskalierung'Result >= 0.00
               );
   
   function Höhenskalierung
     (AktuelleHöheExtern : in Float;
      ErlaubteHöheExtern : in Float)
      return Float
     with
       Pre => (
                 AktuelleHöheExtern >= 0.00
               and
                 ErlaubteHöheExtern >= 0.00
              ),
         
       Post => (
                  Höhenskalierung'Result >= 0.00
               );
   
   function KompletteSkalierung
     (AktuelleGrößeExtern : in Sf.System.Vector2.sfVector2f;
      ErlaubteGrößeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 AktuelleGrößeExtern.x >= 0.00
               and
                 AktuelleGrößeExtern.y >= 0.00
               and
                 ErlaubteGrößeExtern.x >= 0.00
               and
                 ErlaubteGrößeExtern.y >= 0.00
              ),
         
       Post => (
                  KompletteSkalierung'Result.x >= 0.00
                and
                  KompletteSkalierung'Result.y >= 0.00
               );
   
private
      
   Skalierung : Sf.System.Vector2.sfVector2f;

end TextskalierungGrafik;
