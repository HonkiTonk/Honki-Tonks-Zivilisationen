with KIDatentypen;

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
