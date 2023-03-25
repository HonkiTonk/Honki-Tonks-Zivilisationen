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
        KommazahlExtern = 0.00
      then
         return 1.00;
         
      else
         return KommazahlExtern;
      end if;
      
   end NullprüfungKommazahl;
   
   
   
   function NullprüfungFloatvektor
     (GrößeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      if
        GrößeExtern.x = 0.00
      then
         Floatvektor.x := 1.00;
         
      else
         Floatvektor.x := GrößeExtern.x;
      end if;
      
      if
        GrößeExtern.y = 0.00
      then
         Floatvektor.y := 1.00;
         
      else
         Floatvektor.y := GrößeExtern.y;
      end if;
      
      return Floatvektor;
      
   end NullprüfungFloatvektor;

end PruefungenGrafik;
