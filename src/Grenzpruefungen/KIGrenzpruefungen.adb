with KIDatentypen;

-- Grenzprüfungen auch für andere Werte einbauen/auslagern. äöü
-- Grenzprüfungen sind nur bei Rechnungen und nicht bei Zuweisungen nötig. äöü
-- Geht das nicht auch als Generic? äöü
package body KIGrenzpruefungen is

   function AufgabenWichtigkeit
     (AktuellerWertExtern : in KIDatentypen.AufgabenWichtigkeitKlein;
      ÄnderungExtern : in KIDatentypen.AufgabenWichtigkeit)
      return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
     
      if
        AktuellerWertExtern + ÄnderungExtern >= KIDatentypen.AufgabenWichtigkeitKlein'Last
      then
         return KIDatentypen.AufgabenWichtigkeitKlein'Last;
         
      elsif
        AktuellerWertExtern + ÄnderungExtern <= KIDatentypen.AufgabenWichtigkeitKlein'First
      then
         return KIDatentypen.AufgabenWichtigkeitKlein'First;
         
      else
         return AktuellerWertExtern + ÄnderungExtern;
      end if;
   
   end AufgabenWichtigkeit;

end KIGrenzpruefungen;
