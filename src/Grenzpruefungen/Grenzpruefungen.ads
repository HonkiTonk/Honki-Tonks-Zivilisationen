pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ProduktionDatentypen;

package Grenzpruefungen is

   function Arbeitszeit
     (AktuellerWertExtern : in ProduktionDatentypen.ArbeitszeitVorhanden;
      ÄnderungExtern : in ProduktionDatentypen.Arbeitszeit)
      return ProduktionDatentypen.ArbeitszeitVorhanden;

end Grenzpruefungen;
