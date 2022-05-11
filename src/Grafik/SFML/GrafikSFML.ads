pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with MenueDatentypen;
with RassenDatentypen;
with StadtDatentypen;

package GrafikSFML is

   procedure GrafikSFML;

private

   AktuellesMenü : MenueDatentypen.Welches_Menü_Enum;

   AktuelleRasse : RassenDatentypen.Rassen_Enum;

   AktuelleStadtNummer : StadtDatentypen.MaximaleStädteMitNullWert;

   procedure AnzeigeEingaben;
   procedure AnzeigeEditoren;



   function AnzeigeAuswahl
     return Boolean;

end GrafikSFML;
