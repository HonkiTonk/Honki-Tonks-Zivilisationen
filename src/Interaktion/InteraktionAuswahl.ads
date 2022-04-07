pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;

package InteraktionAuswahl is

   -- Das hier müsste doch einmal reichen, oder?
   ------------------------ Muss das hier überhaupt sein? Kann ich das nicht lokal bei der Grafik einbauen und dann hier nur die Positionswerte speichern?
   AuswahlMenüsOhneÜberschrift : Sf.System.Vector2.sfVector2u := (0, 0);

end InteraktionAuswahl;
