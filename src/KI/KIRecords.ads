pragma SPARK_Mode (On);

with GlobaleDatentypen;

package KIRecords is

   type EinheitIDBewertungRecord is record

      ID : GlobaleDatentypen.EinheitenIDMitNullWert;
      Bewertung : GlobaleDatentypen.GesamtproduktionStadt;

   end record;



   type GebäudeIDBewertungRecord is record

      ID : GlobaleDatentypen.GebäudeIDMitNullwert;
      Bewertung : GlobaleDatentypen.GesamtproduktionStadt;

   end record;

end KIRecords;
