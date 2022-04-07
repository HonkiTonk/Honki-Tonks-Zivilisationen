pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package SystemKonstanten is

   -- Spielenamen und Versionsnummer
   Spielename : constant Wide_Wide_String (1 .. 25) := "Honki Tonk´s Zivilisation";

   Versionsnummer : constant Wide_Wide_String (1 .. 9) := "0.01.0230";
   -- Spielenamen und Versionsnummer



   -- Wird das so überhaupt benötigt?
   -- Wartezeiten
   WartezeitLogik : constant Duration := 0.20;
   WartezeitGrafik : constant Duration := 0.0002;
   WartezeitMusik : constant Duration := 0.20;
   WartezeitSound : constant Duration := 0.20;

   WartezeitMinimal : constant Duration := 0.000000002;
   -- Wartezeiten

end SystemKonstanten;
