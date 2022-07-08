pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ProduktionDatentypen; use ProduktionDatentypen;
with EinheitenKonstanten;

package body Grenzpruefungen is

   -- Minimum ist die minimale Arbeitszeit.
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
        AktuellerWertExtern + ÄnderungExtern <= EinheitenKonstanten.MinimaleArbeitszeit
      then
         return EinheitenKonstanten.MinimaleArbeitszeit;
         
      else
         return AktuellerWertExtern + ÄnderungExtern;
      end if;
      
   end Arbeitszeit;

end Grenzpruefungen;
