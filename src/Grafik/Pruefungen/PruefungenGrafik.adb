with GrafikKonstanten;

-- In Nullprüfung umbenennen? äöü
package body PruefungenGrafik is

   -- Das hier und ähnliche Prüfungen bei allen/mehr Teilern einbauen? äöü
   -- Benötigt aber einen Grafik und eine Logikvariante, oder doch mal protected einbauen? äöü
   -- Eventuell auch eigene Varianten für die aktuell verwendeten Orte einbauen? Dann wäre eine bessere Anpassung auf den jeweiligen Bereich möglich. äöü
   function NullprüfungKommazahl
     (KommazahlExtern : in Float)
      return Float
   is begin
      
      if
        KommazahlExtern = GrafikKonstanten.Nullwert
      then
         return GrafikKonstanten.Einswert;
         
      else
         return KommazahlExtern;
      end if;
      
   end NullprüfungKommazahl;
   
   
   
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
