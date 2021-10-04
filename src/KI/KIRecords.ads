pragma SPARK_Mode (On);

with EinheitStadtDatentypen;

package KIRecords is

   type EinheitIDBewertungRecord is record

      ID : EinheitStadtDatentypen.EinheitenIDMitNullWert;
      Bewertung : EinheitStadtDatentypen.GesamtproduktionStadt;

   end record;



   type GebäudeIDBewertungRecord is record

      ID : EinheitStadtDatentypen.GebäudeIDMitNullwert;
      Bewertung : EinheitStadtDatentypen.GesamtproduktionStadt;

   end record;

end KIRecords;
