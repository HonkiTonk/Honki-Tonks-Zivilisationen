pragma SPARK_Mode (Off);
pragma Warnings (Off, "*array aggregate*");

with Ada.Numerics.Discrete_Random;

with KartenDatentypen;
with RassenDatentypen;
with SpielDatentypen;
with RueckgabeDatentypen;
with KartenRecords;

package ZufallsgeneratorenSpieleinstellungen is
     
   procedure ZufälligeRassenbelegung;
   procedure ZufälligeKartenform;
   procedure ZufälligePole;
   
   

   function ZufälligeVordefinierteKartengröße
     return RueckgabeDatentypen.Kartengrößen_Standard_Enum;
   
   function ZufälligeKartengröße
     return KartenRecords.YXAchsenKartenfeldPositivRecord;
   
   function ZufälligeKartenart
     return KartenDatentypen.Kartenart_Enum;
   
   function ZufälligeKartentemperatur
     return KartenDatentypen.Kartentemperatur_Enum;
   
   function ZufälligeKartenressourcen
     return KartenDatentypen.Kartenressourcen_Enum;
   
   function ZufälligerSchwiewrigkeitsgrad
     return SpielDatentypen.Schwierigkeitsgrad_Enum;
   
   function ZufälligeRasse
     return RassenDatentypen.Rassen_Verwendet_Enum;

private
   
   SpielerVorhanden : Boolean;
   
   RasseImSpiel : RassenDatentypen.Spieler_Enum;
   
   YAchse : KartenDatentypen.KartenfeldPositiv;
   XAchse : KartenDatentypen.KartenfeldPositiv;
   
   package ZufälligeVordefinierteKartengrößeWählen is new Ada.Numerics.Discrete_Random (RueckgabeDatentypen.Kartengrößen_Standard_Enum);
   package ZufälligeKartengrößeWählen is new Ada.Numerics.Discrete_Random (KartenDatentypen.KartenfeldPositiv);
   package ZufälligeKartenartWählen is new Ada.Numerics.Discrete_Random (KartenDatentypen.Kartenart_Enum);
   package ZufälligeKartentemperaturWählen is new Ada.Numerics.Discrete_Random (KartenDatentypen.Kartentemperatur_Enum);
   package ZufälligeKartenressourcenWählen is new Ada.Numerics.Discrete_Random (KartenDatentypen.Kartenressourcen_Enum);
   package ZufälligeRassenbelegungWählen is new Ada.Numerics.Discrete_Random (RassenDatentypen.Spieler_Enum);
   package ZufälligenSchwierigkeitsgradWählen is new Ada.Numerics.Discrete_Random (SpielDatentypen.Schwierigkeitsgrad_Enum);
   package ZufälligeRasseWählen is new Ada.Numerics.Discrete_Random (RassenDatentypen.Rassen_Verwendet_Enum);
   package ZufälligerEAchsenÜbergangWählen is new Ada.Numerics.Discrete_Random (KartenDatentypen.Kartenform_E_Einstellbar_Enum);
   package ZufälligerYAchsenÜbergangWählen is new Ada.Numerics.Discrete_Random (KartenDatentypen.Kartenform_Y_Einstellbar_Enum);
   package ZufälligerXAchsenÜbergangWählen is new Ada.Numerics.Discrete_Random (KartenDatentypen.Kartenform_X_Einstellbar_Enum);

   ZufälligeVordefinierteKartengrößeGewählt : ZufälligeVordefinierteKartengrößeWählen.Generator;
   ZufälligeKartengrößeGewählt : ZufälligeKartengrößeWählen.Generator;
   ZufälligeKartenartGewählt : ZufälligeKartenartWählen.Generator;
   ZufälligeKartentemperaturGewählt : ZufälligeKartentemperaturWählen.Generator;
   ZufälligeKartenressourcenGewählt : ZufälligeKartenressourcenWählen.Generator;
   ZufälligeRassenbelegungGewählt : ZufälligeRassenbelegungWählen.Generator;
   ZufälligerSchwierigkeitsgradGewählt : ZufälligenSchwierigkeitsgradWählen.Generator;
   ZufälligeRasseGewählt : ZufälligeRasseWählen.Generator;
   ZufälligerEAchsenÜbergangGewählt : ZufälligerEAchsenÜbergangWählen.Generator;
   ZufälligerYAchsenÜbergangGewählt : ZufälligerYAchsenÜbergangWählen.Generator;
   ZufälligerXAchsenÜbergangGewählt : ZufälligerXAchsenÜbergangWählen.Generator;

end ZufallsgeneratorenSpieleinstellungen;
