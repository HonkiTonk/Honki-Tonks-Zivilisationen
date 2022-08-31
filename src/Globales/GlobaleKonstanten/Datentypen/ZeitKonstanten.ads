pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package ZeitKonstanten is
   
   -- Wird das so überhaupt benötigt?
   WartezeitLogik : constant Duration := 0.20;
   WartezeitGrafik : constant Duration := 0.0002;
   WartezeitMusik : constant Duration := 0.20;
   WartezeitSound : constant Duration := 0.20;

   -- Kleinstmögliche Zeiteinheit
   -- WartezeitMinimal : constant Duration := 0.000000001;
   
   -- Intervalle durch Nutzer einstellen lassen? äöü
   Blinkintervall : constant Duration := 0.50;
   
   -- Das hier vom Nutzer einstellbar machen. äöü
   AnzeigezeitSpielmeldungen : constant Duration := 2.00;

end ZeitKonstanten;
