pragma SPARK_Mode (On);

with EinheitStadtDatentypen;

with KIDatentypen;

package KIRecords is

   type EinheitIDBewertungRecord is record

      ID : EinheitStadtDatentypen.EinheitenIDMitNullWert;
      Bewertung : KIDatentypen.BauenBewertung;

   end record;



   type GebäudeIDBewertungRecord is record

      ID : EinheitStadtDatentypen.GebäudeIDMitNullwert;
      Bewertung : KIDatentypen.BauenBewertung;

   end record;

end KIRecords;
