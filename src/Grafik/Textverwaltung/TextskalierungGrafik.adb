with AllgemeinberechnungenHTB7;

with GrafikRecordKonstanten;

package body TextskalierungGrafik is

   function Verkleinerung
     (AktuelleBreiteExtern : in Float;
      ErlaubteBreiteExtern : in Float)
      return Float
   is begin
     
      if
        AktuelleBreiteExtern > ErlaubteBreiteExtern
      then
         return ErlaubteBreiteExtern / AllgemeinberechnungenHTB7.NullprüfungKommazahl (KommazahlExtern => AktuelleBreiteExtern);
         
      else
         return GrafikRecordKonstanten.Standardskalierung.x;
      end if;
      
   end Verkleinerung;
   
   
   
   function Breitenskalierung
     (AktuelleBreiteExtern : in Float;
      ErlaubteBreiteExtern : in Float)
      return Float
   is begin
     
      if
        AktuelleBreiteExtern > ErlaubteBreiteExtern
      then
         return ErlaubteBreiteExtern / AllgemeinberechnungenHTB7.NullprüfungKommazahl (KommazahlExtern => AktuelleBreiteExtern);
         
      elsif
        AktuelleBreiteExtern < ErlaubteBreiteExtern
      then
         return AktuelleBreiteExtern / AllgemeinberechnungenHTB7.NullprüfungKommazahl (KommazahlExtern => ErlaubteBreiteExtern);
         
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
         return ErlaubteHöheExtern / AllgemeinberechnungenHTB7.NullprüfungKommazahl (KommazahlExtern => AktuelleHöheExtern);
         
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
