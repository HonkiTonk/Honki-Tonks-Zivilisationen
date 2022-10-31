pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen;
with StadtDatentypen;
with KampfDatentypen;
with EinheitenRecords;

with KIDatentypen;

package KIRecords is
   pragma Pure;

   type EinheitIDBewertungRecord is record

      ID : EinheitenDatentypen.EinheitenIDMitNullWert;
      Bewertung : KIDatentypen.BauenBewertung;

   end record;



   type GebäudeIDBewertungRecord is record

      ID : StadtDatentypen.GebäudeIDMitNullwert;
      Bewertung : KIDatentypen.BauenBewertung;

   end record;



   type FeindlicheEinheitBewertet is new EinheitenRecords.RasseEinheitnummerRecord with record

      Angriff : KampfDatentypen.Kampfwerte;
      Verteidigung : KampfDatentypen.Kampfwerte;

   end record;

end KIRecords;
