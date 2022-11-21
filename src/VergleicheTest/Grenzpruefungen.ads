with ProduktionDatentypen;

package Grenzpruefungen is
   pragma Preelaborate;

   generic type GanzeZahl is range <>;

   function Standardprüfung
     (AktuellerWertExtern : in GanzeZahl;
      ÄnderungExtern : in GanzeZahl)
      return GanzeZahl;

   function Arbeitszeit
     (AktuellerWertExtern : in ProduktionDatentypen.Arbeitszeit;
      ÄnderungExtern : in ProduktionDatentypen.Arbeitszeit)
      return ProduktionDatentypen.Arbeitszeit;

end Grenzpruefungen;
