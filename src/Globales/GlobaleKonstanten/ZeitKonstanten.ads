pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package ZeitKonstanten is

   -- Hier später auch Konstanten für die Ladezeiten reinwerfen.
   
   -- Wird das so überhaupt benötigt?
   WartezeitLogik : constant Duration := 0.20;
   WartezeitGrafik : constant Duration := 0.0002;
   WartezeitMusik : constant Duration := 0.20;
   WartezeitSound : constant Duration := 0.20;

   -- Kleinstmögliche Zeiteinheit
   -- WartezeitMinimal : constant Duration := 0.000000001;

end ZeitKonstanten;
