pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KIDatentypen; use KIDatentypen;
with KIBewertungDatentypen; use KIBewertungDatentypen;

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
   
   
   
   function GesamteFeldbewertung
     (AktuellerWertExtern : in KIBewertungDatentypen.GesamteFeldbewertung;
      ÄnderungExtern : in KIBewertungDatentypen.GesamteFeldbewertung)
      return KIBewertungDatentypen.GesamteFeldbewertung
   is begin
      
      if
        AktuellerWertExtern + ÄnderungExtern >= KIBewertungDatentypen.GesamteFeldbewertung'Last
      then
         return KIBewertungDatentypen.GesamteFeldbewertung'Last;
       
         -- Doch noch negative Bereiche einbauen. äöü
     -- elsif
       -- AktuellerWertExtern + ÄnderungExtern <= KIBewertungDatentypen.GesamteFeldbewertung'First
     -- then
         -- return KIBewertungDatentypen.GesamteFeldbewertung'First;
         
      else
         return AktuellerWertExtern + ÄnderungExtern;
      end if;
      
   end GesamteFeldbewertung;

end KIGrenzpruefungen;
