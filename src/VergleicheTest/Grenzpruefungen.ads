pragma Warnings (Off, "*array aggregate*");

with ProduktionDatentypen;

package Grenzpruefungen is
   pragma Preelaborate;

   function Arbeitszeit
     (AktuellerWertExtern : in ProduktionDatentypen.Arbeitszeit;
      ÄnderungExtern : in ProduktionDatentypen.Arbeitszeit)
      return ProduktionDatentypen.Arbeitszeit;

end Grenzpruefungen;
