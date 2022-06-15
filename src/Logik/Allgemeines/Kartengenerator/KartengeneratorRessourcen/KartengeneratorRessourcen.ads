pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen;
with ZahlenDatentypen;

package KartengeneratorRessourcen is
   
   procedure AufteilungRessourcengenerierung;

private
   
   type MultiplikatorArray is array (KartenDatentypen.EbenePlanet'Range) of ZahlenDatentypen.EigenesPositive;
   Multiplikator : MultiplikatorArray;
      
   procedure GenerierungRessourcen;
   procedure RessourcenGenerierung
     (EbeneExtern : in KartenDatentypen.EbenePlanet);

end KartengeneratorRessourcen;
