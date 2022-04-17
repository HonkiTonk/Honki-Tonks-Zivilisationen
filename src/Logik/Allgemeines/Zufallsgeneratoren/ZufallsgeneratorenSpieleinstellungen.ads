pragma SPARK_Mode (Off);
pragma Warnings (Off, "*array aggregate*");

with Ada.Numerics.Discrete_Random;

with RueckgabeDatentypen;
with KartenDatentypen;
with RassenDatentypen;

package ZufallsgeneratorenSpieleinstellungen is
     
   procedure ZufälligeRassen;
   
   

   function ZufälligeVordefinierteKartengröße
     return KartenDatentypen.Kartengröße_Verwendet_Enum;
   
   function ZufälligeKartengröße
     return KartenDatentypen.Kartengröße_Verwendet_Enum;
   
   function ZufälligeKartenart
     return KartenDatentypen.Kartenart_Enum;
   
   -- function ZufälligeKartenform
   --   return KartenDatentypen.Kartenform_Verwendet_Enum;
   
   function ZufälligeKartentemperatur
     return KartenDatentypen.Kartentemperatur_Enum;
   
   function ZufälligeKartenressourcen
     return KartenDatentypen.Kartenressourcen_Enum;
   
   function ZufälligerSchwiewrigkeitsgrad
     return RueckgabeDatentypen.Schwierigkeitsgrad_Verwendet_Enum;

private
   
   SpielerVorhanden : Boolean;
   
   RasseImSpiel : RassenDatentypen.Spieler_Enum;
   
   AuswahlGröße : KartenDatentypen.KartenfeldPositiv;
   
   -- RasseGewählt : RueckgabeDatentypen.Rassen_Verwendet_Enum;
   
   -- Generatoren für zufällige Spieleinstellungen
   package ZufälligeVordefinierteKartengrößeWählen is new Ada.Numerics.Discrete_Random (KartenDatentypen.Kartengröße_Standard_Enum);
   package ZufälligeKartengrößeWählen is new Ada.Numerics.Discrete_Random (KartenDatentypen.KartenfeldPositiv);
   package ZufälligeKartenartWählen is new Ada.Numerics.Discrete_Random (KartenDatentypen.Kartenart_Enum);
   -- package ZufälligeKartenformWählen is new Ada.Numerics.Discrete_Random (KartenDatentypen.Kartenform_Verwendet_Enum);
   package ZufälligeKartentemperaturWählen is new Ada.Numerics.Discrete_Random (KartenDatentypen.Kartentemperatur_Enum);
   package ZufälligeKartenressourcenWählen is new Ada.Numerics.Discrete_Random (KartenDatentypen.Kartenressourcen_Enum);
   package ZufälligeRassenWählen is new Ada.Numerics.Discrete_Random (RassenDatentypen.Spieler_Enum);
   package ZufälligenSchwierigkeitsgradWählen is new Ada.Numerics.Discrete_Random (RueckgabeDatentypen.Schwierigkeitsgrad_Verwendet_Enum);

   ZufälligeVordefinierteKartengrößeGewählt : ZufälligeVordefinierteKartengrößeWählen.Generator;
   ZufälligeKartengrößeGewählt : ZufälligeKartengrößeWählen.Generator;
   ZufälligeKartenartGewählt : ZufälligeKartenartWählen.Generator;
   -- ZufälligeKartenformGewählt : ZufälligeKartenformWählen.Generator;
   ZufälligeKartentemperaturGewählt : ZufälligeKartentemperaturWählen.Generator;
   ZufälligeKartenressourcenGewählt : ZufälligeKartenressourcenWählen.Generator;
   ZufälligeRassenGewählt : ZufälligeRassenWählen.Generator;
   ZufälligerSchwierigkeitsgradGewählt : ZufälligenSchwierigkeitsgradWählen.Generator;
   -- Generatoren für zufällige Spieleinstellungen

end ZufallsgeneratorenSpieleinstellungen;
