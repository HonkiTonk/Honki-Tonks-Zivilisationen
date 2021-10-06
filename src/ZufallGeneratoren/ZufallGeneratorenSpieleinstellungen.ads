pragma SPARK_Mode (Off);

with Ada.Numerics.Discrete_Random;

with SystemDatentypen;
with KartenDatentypen;
with SonstigeDatentypen;

package ZufallGeneratorenSpieleinstellungen is

   function ZufälligeKartengröße
     return KartenDatentypen.Kartengröße_Verwendet_Enum;
   
   function ZufälligeKartenart
     return KartenDatentypen.Kartenart_Verwendet_Enum;
   
   function ZufälligeKartenform
     return KartenDatentypen.Kartenform_Verwendet_Enum;
   
   function ZufälligeKartentemperatur
     return KartenDatentypen.Kartentemperatur_Verwendet_Enum;
   
   function ZufälligeKartenressourcen
     return KartenDatentypen.Karten_Ressourcen_Reichtum_Verwendet_Enum;
   
   function ZufälligeSpieleranzahl
     return Positive;
     
   function ZufälligeRasse
     return SonstigeDatentypen.Rassen_Verwendet_Enum;
   
   function ZufälligerSchwiewrigkeitsgrad
     return SystemDatentypen.Schwierigkeitsgrad_Verwendet_Enum;

private
   
   RasseGewählt : SonstigeDatentypen.Rassen_Verwendet_Enum;
   
   -- Generatoren für zufällige Spieleinstellungen
   package ZufälligeKartengrößeWählen is new Ada.Numerics.Discrete_Random (KartenDatentypen.Kartengröße_Zufall_Enum);
   package ZufälligeKartenartWählen is new Ada.Numerics.Discrete_Random (KartenDatentypen.Kartenart_Verwendet_Enum);
   package ZufälligeKartenformWählen is new Ada.Numerics.Discrete_Random (KartenDatentypen.Kartenform_Verwendet_Enum);
   package ZufälligeKartentemperaturWählen is new Ada.Numerics.Discrete_Random (KartenDatentypen.Kartentemperatur_Verwendet_Enum);
   package ZufälligeKartenressourcenWählen is new Ada.Numerics.Discrete_Random (KartenDatentypen.Karten_Ressourcen_Reichtum_Verwendet_Enum);
   package ZufälligeSpieleranzahlRasseWählen is new Ada.Numerics.Discrete_Random (SonstigeDatentypen.Rassen_Verwendet_Enum);
   package ZufälligenSchwierigkeitsgradWählen is new Ada.Numerics.Discrete_Random (SystemDatentypen.Schwierigkeitsgrad_Verwendet_Enum);

   ZufälligeKartengrößeGewählt : ZufälligeKartengrößeWählen.Generator;
   ZufälligeKartenartGewählt : ZufälligeKartenartWählen.Generator;
   ZufälligeKartenformGewählt : ZufälligeKartenformWählen.Generator;
   ZufälligeKartentemperaturGewählt : ZufälligeKartentemperaturWählen.Generator;
   ZufälligeKartenressourcenGewählt : ZufälligeKartenressourcenWählen.Generator;
   ZufälligeSpieleranzahlRasseGewählt : ZufälligeSpieleranzahlRasseWählen.Generator;
   ZufälligerSchwierigkeitsgradGewählt : ZufälligenSchwierigkeitsgradWählen.Generator;
   -- Generatoren für zufällige Spieleinstellungen

end ZufallGeneratorenSpieleinstellungen;
