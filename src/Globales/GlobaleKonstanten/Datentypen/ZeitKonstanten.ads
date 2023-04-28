package ZeitKonstanten is
   pragma Pure;
   
   WartezeitStart : constant Duration := 0.002;
   
   -- Wird das so überhaupt benötigt?
   WartezeitLogik : constant Duration := 0.002;
   WartezeitGrafik : constant Duration := 0.002;
   WartezeitMusik : constant Duration := 0.002;
   WartezeitSound : constant Duration := 0.002;

   WartezeitEingabe : constant Duration := 0.002;
   
   -- Intervalle durch Nutzer einstellen lassen? äöü
   Blinkintervall : constant Duration := 0.500;
   
   -- Das hier vom Nutzer einstellbar machen. äöü
   AnzeigeInformationen : constant Duration := 0.500;
   AnzeigezeitSpielmeldungen : constant Duration := 2.000;
   
   -- Das hier vom Nutzer einstellbar machen. äöü
   Scrollverzögerung : constant Duration := 0.020;
   ScrollverzögernMinimalzoom : constant Duration := 0.050;
   
   Introzeit : constant Duration := 5.000;
   
end ZeitKonstanten;
