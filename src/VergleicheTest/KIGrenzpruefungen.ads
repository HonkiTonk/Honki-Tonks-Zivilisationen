pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KIBewertungDatentypen;
with KIDatentypen;

package KIGrenzpruefungen is

   function AufgabenWichtigkeit
     (AktuellerWertExtern : in KIDatentypen.AufgabenWichtigkeitKlein;
      ÄnderungExtern : in KIDatentypen.AufgabenWichtigkeit)
      return KIDatentypen.AufgabenWichtigkeitKlein;

   function GesamteFeldbewertung
     (AktuellerWertExtern : in KIBewertungDatentypen.GesamteFeldbewertung;
      ÄnderungExtern : in KIBewertungDatentypen.GesamteFeldbewertung)
      return KIBewertungDatentypen.GesamteFeldbewertung;

end KIGrenzpruefungen;
