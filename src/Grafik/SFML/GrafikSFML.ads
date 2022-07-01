pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with MenueDatentypen;
private with RassenDatentypen;
private with StadtDatentypen;
private with EinheitenRecords;
private with StadtRecords;

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
