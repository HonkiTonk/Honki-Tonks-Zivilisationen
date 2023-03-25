with GrafikRecordKonstanten;

with PruefungenGrafik;

package body TextskalierungGrafik is

   function Breitenskalierung
     (AktuelleBreiteExtern : in Float;
      ErlaubteBreiteExtern : in Float)
      return Float
   is begin
     
      if
        AktuelleBreiteExtern > ErlaubteBreiteExtern
      then
         return ErlaubteBreiteExtern / PruefungenGrafik.NullprüfungKommazahl (KommazahlExtern => AktuelleBreiteExtern);
         
      else
         return GrafikRecordKonstanten.Standardskalierung.x;
      end if;
      
   end Breitenskalierung;
   
   
   
   function Höhenskalierung
     (AktuelleHöheExtern : in Float;
      ErlaubteHöheExtern : in Float)
      return Float
   is begin
     
      if
        AktuelleHöheExtern > ErlaubteHöheExtern
      then
         return ErlaubteHöheExtern / PruefungenGrafik.NullprüfungKommazahl (KommazahlExtern => AktuelleHöheExtern);
         
      else
         return GrafikRecordKonstanten.Standardskalierung.y;
      end if;
      
   end Höhenskalierung;
   
   
   
   function KompletteSkalierung
     (AktuelleGrößeExtern : in Sf.System.Vector2.sfVector2f;
      ErlaubteGrößeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Skalierung.x := Breitenskalierung (AktuelleBreiteExtern => AktuelleGrößeExtern.x,
                                         ErlaubteBreiteExtern => ErlaubteGrößeExtern.x);
      Skalierung.y := Höhenskalierung (AktuelleHöheExtern => AktuelleGrößeExtern.y,
                                        ErlaubteHöheExtern => ErlaubteGrößeExtern.y);
      
      return Skalierung;
      
   end KompletteSkalierung;

end TextskalierungGrafik;
