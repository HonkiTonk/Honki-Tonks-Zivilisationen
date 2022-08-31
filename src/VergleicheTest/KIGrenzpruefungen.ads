pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen;

with KIDatentypen;

package KIGrenzpruefungen is

   function AufgabenWichtigkeit
     (AktuellerWertExtern : in KIDatentypen.AufgabenWichtigkeitKlein;
      ÄnderungExtern : in KIDatentypen.AufgabenWichtigkeit)
      return KIDatentypen.AufgabenWichtigkeitKlein;

   function GesamteFeldbewertung
     (AktuellerWertExtern : in KartenDatentypen.GesamteFeldbewertung;
      ÄnderungExtern : in KartenDatentypen.GesamteFeldbewertung)
      return KartenDatentypen.GesamteFeldbewertung;

end KIGrenzpruefungen;
