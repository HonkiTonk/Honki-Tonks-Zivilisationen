pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ProduktionDatentypen; use ProduktionDatentypen;

package body Grenzpruefungen is

   function Arbeitszeit
     (AktuellerWertExtern : in ProduktionDatentypen.ArbeitszeitVorhanden;
      ÄnderungExtern : in ProduktionDatentypen.Arbeitszeit)
      return ProduktionDatentypen.ArbeitszeitVorhanden
   is begin
      
      if
        AktuellerWertExtern + ÄnderungExtern >= ProduktionDatentypen.ArbeitszeitVorhanden'Last
      then
         return ProduktionDatentypen.ArbeitszeitVorhanden'Last;
         
      elsif
        AktuellerWertExtern + ÄnderungExtern <= ProduktionDatentypen.ArbeitszeitVorhanden'First
      then
         return ProduktionDatentypen.ArbeitszeitVorhanden'First;
         
      else
         return AktuellerWertExtern + ÄnderungExtern;
      end if;
      
   end Arbeitszeit;

end Grenzpruefungen;
