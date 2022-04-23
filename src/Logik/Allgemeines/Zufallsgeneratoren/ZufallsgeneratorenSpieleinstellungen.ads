pragma SPARK_Mode (Off);
pragma Warnings (Off, "*array aggregate*");

with Ada.Numerics.Discrete_Random;

with KartenDatentypen;
with RassenDatentypen;
with SpielDatentypen;

package ZufallsgeneratorenSpieleinstellungen is
     
   procedure ZufälligeRassen;
   procedure ZufälligeKartenform;
   
   

   function ZufälligeVordefinierteKartengröße
     return KartenDatentypen.Kartengröße_Verwendet_Enum;
   
   function ZufälligeKartengröße
     return KartenDatentypen.Kartengröße_Verwendet_Enum;
   
   function ZufälligeKartenart
     return KartenDatentypen.Kartenart_Enum;
   
   function ZufälligeKartentemperatur
     return KartenDatentypen.Kartentemperatur_Enum;
   
   function ZufälligeKartenressourcen
     return KartenDatentypen.Kartenressourcen_Enum;
   
   function ZufälligerSchwiewrigkeitsgrad
     return SpielDatentypen.Schwierigkeitsgrad_Enum;

private
   
   SpielerVorhanden : Boolean;
   
   RasseImSpiel : RassenDatentypen.Spieler_Enum;
   
   AuswahlGröße : KartenDatentypen.KartenfeldPositiv;
   
   package ZufälligeVordefinierteKartengrößeWählen is new Ada.Numerics.Discrete_Random (KartenDatentypen.Kartengröße_Standard_Enum);
   package ZufälligeKartengrößeWählen is new Ada.Numerics.Discrete_Random (KartenDatentypen.KartenfeldPositiv);
   package ZufälligeKartenartWählen is new Ada.Numerics.Discrete_Random (KartenDatentypen.Kartenart_Enum);
   package ZufälligeKartentemperaturWählen is new Ada.Numerics.Discrete_Random (KartenDatentypen.Kartentemperatur_Enum);
   package ZufälligeKartenressourcenWählen is new Ada.Numerics.Discrete_Random (KartenDatentypen.Kartenressourcen_Enum);
   package ZufälligeRassenWählen is new Ada.Numerics.Discrete_Random (RassenDatentypen.Spieler_Enum);
   package ZufälligenSchwierigkeitsgradWählen is new Ada.Numerics.Discrete_Random (SpielDatentypen.Schwierigkeitsgrad_Enum);
   package ZufälligerEAchsenÜbergangWählen is new Ada.Numerics.Discrete_Random (KartenDatentypen.Kartenform_E_Achse_Einstellbar_Enum);
   package ZufälligerYAchsenÜbergangWählen is new Ada.Numerics.Discrete_Random (KartenDatentypen.Kartenform_Y_Achse_Einstellbar_Enum);
   package ZufälligerXAchsenÜbergangWählen is new Ada.Numerics.Discrete_Random (KartenDatentypen.Kartenform_X_Achse_Einstellbar_Enum);
   package ZufälligeAchseWählen is new Ada.Numerics.Discrete_Random (Boolean);

   ZufälligeVordefinierteKartengrößeGewählt : ZufälligeVordefinierteKartengrößeWählen.Generator;
   ZufälligeKartengrößeGewählt : ZufälligeKartengrößeWählen.Generator;
   ZufälligeKartenartGewählt : ZufälligeKartenartWählen.Generator;
   ZufälligeKartentemperaturGewählt : ZufälligeKartentemperaturWählen.Generator;
   ZufälligeKartenressourcenGewählt : ZufälligeKartenressourcenWählen.Generator;
   ZufälligeRassenGewählt : ZufälligeRassenWählen.Generator;
   ZufälligerSchwierigkeitsgradGewählt : ZufälligenSchwierigkeitsgradWählen.Generator;
   ZufälligerEAchsenÜbergangGewählt : ZufälligerEAchsenÜbergangWählen.Generator;
   ZufälligerYAchsenÜbergangGewählt : ZufälligerYAchsenÜbergangWählen.Generator;
   ZufälligerXAchsenÜbergangGewählt : ZufälligerXAchsenÜbergangWählen.Generator;
   ZufälligeAchseGewählt : ZufälligeAchseWählen.Generator;

end ZufallsgeneratorenSpieleinstellungen;
