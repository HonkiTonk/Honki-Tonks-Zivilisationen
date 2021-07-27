pragma SPARK_Mode (Off);

with Ada.Numerics.Discrete_Random;

with GlobaleDatentypen;

package ZufallGeneratorenSpieleinstellungen is

   function ZufälligeKartengröße
     return GlobaleDatentypen.Kartengröße_Verwendet_Enum;
   
   function ZufälligeKartenart
     return GlobaleDatentypen.Kartenart_Verwendet_Enum;
   
   function ZufälligeKartenform
     return GlobaleDatentypen.Kartenform_Verwendet_Enum;
   
   function ZufälligeKartentemperatur
     return GlobaleDatentypen.Kartentemperatur_Verwendet_Enum;
   
   function ZufälligeSpieleranzahl
     return Positive;
     
   function ZufälligeRasse
     return GlobaleDatentypen.Rassen_Verwendet_Enum;
   
   function ZufälligerSchwiewrigkeitsgrad
     return GlobaleDatentypen.Schwierigkeitsgrad_Verwendet_Enum;

private
   
   RasseGewählt : GlobaleDatentypen.Rassen_Verwendet_Enum;
   
   -- Generatoren für zufällige Spieleinstellungen
   package ZufälligeKartengrößeWählen is new Ada.Numerics.Discrete_Random (GlobaleDatentypen.Kartengröße_Zufall_Enum);
   package ZufälligeKartenartWählen is new Ada.Numerics.Discrete_Random (GlobaleDatentypen.Kartenart_Verwendet_Enum);
   package ZufälligeKartenformWählen is new Ada.Numerics.Discrete_Random (GlobaleDatentypen.Kartenform_Verwendet_Enum);
   package ZufälligeKartentemperaturWählen is new Ada.Numerics.Discrete_Random (GlobaleDatentypen.Kartentemperatur_Verwendet_Enum);
   package ZufälligeSpieleranzahlRasseWählen is new Ada.Numerics.Discrete_Random (GlobaleDatentypen.Rassen_Verwendet_Enum);
   package ZufälligenSchwierigkeitsgradWählen is new Ada.Numerics.Discrete_Random (GlobaleDatentypen.Schwierigkeitsgrad_Verwendet_Enum);

   ZufälligeKartengrößeGewählt : ZufälligeKartengrößeWählen.Generator;
   ZufälligeKartenartGewählt : ZufälligeKartenartWählen.Generator;
   ZufälligeKartenformGewählt : ZufälligeKartenformWählen.Generator;
   ZufälligeKartentemperaturGewählt : ZufälligeKartentemperaturWählen.Generator;
   ZufälligeSpieleranzahlRasseGewählt : ZufälligeSpieleranzahlRasseWählen.Generator;
   ZufälligerSchwierigkeitsgradGewählt : ZufälligenSchwierigkeitsgradWählen.Generator;
   -- Generatoren für zufällige Spieleinstellungen

end ZufallGeneratorenSpieleinstellungen;
