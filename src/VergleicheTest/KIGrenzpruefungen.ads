pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KIDatentypen;

package KIGrenzpruefungen is

   function AufgabenWichtigkeit
     (AktuellerWertExtern : in KIDatentypen.AufgabenWichtigkeitKlein;
      ÄnderungExtern : in KIDatentypen.AufgabenWichtigkeit)
      return KIDatentypen.AufgabenWichtigkeitKlein;

end KIGrenzpruefungen;
