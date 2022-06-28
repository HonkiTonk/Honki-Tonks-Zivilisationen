pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;

with KIDatentypen; use KIDatentypen;

-------------------------------------- Grenzprüfungen auch für andere Werte einbauen/auslagern.
-------------------------------------- Grenzprüfungen sind nur bei Rechnungen und nicht bei Zuweisungen nötig.
-------------------------------------- Geht das nicht auch als Generic?
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
   
   
   
   function GesamteFeldbewertung
     (AktuellerWertExtern : in KartenDatentypen.GesamteFeldbewertung;
      ÄnderungExtern : in KartenDatentypen.GesamteFeldbewertung)
      return KartenDatentypen.GesamteFeldbewertung
   is begin
      
      if
        AktuellerWertExtern + ÄnderungExtern >= KartenDatentypen.GesamteFeldbewertung'Last
      then
         return KartenDatentypen.GesamteFeldbewertung'Last;
       
         --------------------------------------------- Doch noch negative Bereiche einbauen.         
     -- elsif
       -- AktuellerWertExtern + ÄnderungExtern <= KartenDatentypen.GesamteFeldbewertung'First
     -- then
         -- return KartenDatentypen.GesamteFeldbewertung'First;
         
      else
         return AktuellerWertExtern + ÄnderungExtern;
      end if;
      
   end GesamteFeldbewertung;

end KIGrenzpruefungen;
