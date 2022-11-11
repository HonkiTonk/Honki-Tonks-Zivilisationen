package ZeitKonstanten is
   pragma Preelaborate;
   
   -- Wird das so überhaupt benötigt?
   WartezeitLogik : constant Duration := 0.20;
   WartezeitGrafik : constant Duration := 0.0002;
   WartezeitMusik : constant Duration := 0.20;
   WartezeitSound : constant Duration := 0.20;

   WartezeitEingabe : constant Duration := 0.0002;
   
   -- Intervalle durch Nutzer einstellen lassen? äöü
   Blinkintervall : constant Duration := 0.50;
   
   -- Das hier vom Nutzer einstellbar machen. äöü
   AnzeigezeitSpielmeldungen : constant Duration := 2.00;
   
   -- Das hier vom Nutzer einstellbar machen. äöü
   Scrollverzögerung : Duration := 0.02;
   ScrollverzögernMinimalzoom : Duration := 0.05;
   
   Introzeit : constant Duration := 5.00;

end ZeitKonstanten;
