pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KIDatentypen; use KIDatentypen;

-------------------------------------- Grenzprüfungen auch für andere Werte einbauen/auslagern.
-------------------------------------- Grenzprüfungen sind nur bei Rechnungen und nicht bei Zuweisungen nötig.
package body KIGrenzpruefungen is

   function AufgabenWichtigkeit
     (AktuellerWertExtern : in KIDatentypen.AufgabenWichtigkeitKlein;
      ÄnderungExtern : in KIDatentypen.AufgabenWichtigkeit)
      return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
     
      if
        AktuellerWertExtern + ÄnderungExtern >= AufgabenWichtigkeitKlein'Last
      then
         return AufgabenWichtigkeitKlein'Last;
         
      elsif
        AktuellerWertExtern + ÄnderungExtern <= AufgabenWichtigkeitKlein'First
      then
         return AufgabenWichtigkeitKlein'First;
         
      else
         return AktuellerWertExtern + ÄnderungExtern;
      end if;
   
   end AufgabenWichtigkeit;

end KIGrenzpruefungen;
