pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with MenueDatentypen;
with RassenDatentypen;
with StadtDatentypen;
with EinheitenRecords;
with StadtRecords;

package GrafikSFML is

   procedure GrafikSFML;

private

   AktuellesMenü : MenueDatentypen.Welches_Menü_Enum;

   AktuelleRasse : RassenDatentypen.Rassen_Enum;

   AktuelleStadtNummer : StadtDatentypen.MaximaleStädteMitNullWert;

   AktuelleRasseStadt : StadtRecords.RasseStadtnummerRecord;

   AktuelleRasseEinheit : EinheitenRecords.RasseEinheitnummerRecord;

   procedure AnzeigeEingaben;
   procedure AnzeigeEditoren;
   procedure GrafikanpassungenVorFensterleerung;
   procedure Eingaben;



   function AnzeigeAuswahl
     return Boolean;

end GrafikSFML;
