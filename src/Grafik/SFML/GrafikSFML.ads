pragma SPARK_Mode (On);

with SystemDatentypen;
with EinheitStadtDatentypen;

package GrafikSFML is

   procedure GrafikSFML;

private

   AktuelleRasse : SystemDatentypen.Rassen_Enum;
   AktuelleStadtNummer : EinheitStadtDatentypen.MaximaleStädteMitNullWert;

   -- Wird die irgendwann einmal benötigt?
   AktuelleEinheitNummer : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;

   procedure AnzeigeEingaben;
   procedure AnzeigeEditoren;



   function AnzeigeAuswahl
     return Boolean;

end GrafikSFML;
