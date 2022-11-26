with EinheitenDatentypen;
with StadtDatentypen;
with KampfDatentypen;
with RassenDatentypen;

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



   type FeindlicheEinheitBewertet is record

      Rasse : RassenDatentypen.Rassen_Enum;
      Nummer : EinheitenDatentypen.MaximaleEinheitenMitNullWert;

      Angriff : KampfDatentypen.KampfwerteGroß;
      Verteidigung : KampfDatentypen.KampfwerteGroß;

   end record;

end KIRecords;
