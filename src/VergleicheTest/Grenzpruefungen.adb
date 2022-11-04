pragma Warnings (Off, "*array aggregate*");

with ProduktionDatentypen; use ProduktionDatentypen;
with EinheitenKonstanten;

package body Grenzpruefungen is

   function Arbeitszeit
     (AktuellerWertExtern : in ProduktionDatentypen.Arbeitszeit;
      ÄnderungExtern : in ProduktionDatentypen.Arbeitszeit)
      return ProduktionDatentypen.Arbeitszeit
   is begin
      
      if
        AktuellerWertExtern + ÄnderungExtern >= ProduktionDatentypen.Arbeitszeit'Last
      then
         return ProduktionDatentypen.Arbeitszeit'Last;
         
      elsif
        AktuellerWertExtern + ÄnderungExtern <= EinheitenKonstanten.MinimaleArbeitszeit
      then
         return EinheitenKonstanten.MinimaleArbeitszeit;
         
      else
         return AktuellerWertExtern + ÄnderungExtern;
      end if;
      
   end Arbeitszeit;

end Grenzpruefungen;
