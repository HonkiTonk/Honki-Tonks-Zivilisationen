private with Ada.Numerics.Discrete_Random;

with KartenartDatentypen;
with SpeziesDatentypen;
with SpielDatentypen;
with RueckgabeDatentypen;
with KartenRecords;

private with KartenDatentypen;

package ZufallsgeneratorenSpieleinstellungenLogik is
   pragma Elaborate_Body;
     
   procedure ZufälligeSpeziesbelegung;
   procedure ZufälligeKartenform;
   procedure ZufälligePole;
   procedure ZufälligeKartenart;
   
   

   function ZufälligeVordefinierteKartengröße
     return RueckgabeDatentypen.Kartengrößen_Standard_Enum;
   
   function ZufälligeKartengröße
     return KartenRecords.YXAchsenKartenfeldPositivRecord;
   
   function ZufälligeVordefinierteKartenart
     return KartenartDatentypen.Kartenart_Normal_Enum;
   
   function ZufälligeKartentemperatur
     return KartenartDatentypen.Kartentemperatur_Enum;
   
   function ZufälligeKartenressourcen
     return KartenartDatentypen.Kartenressourcenmenge_Enum;
   
   function ZufälligerSchwiewrigkeitsgrad
     return SpielDatentypen.Schwierigkeitsgrad_Enum;
   
   function ZufälligeSpezies
     return SpeziesDatentypen.Spezies_Verwendet_Enum;

private
   
   SpielerVorhanden : Boolean;
   
   SpeziesImSpiel : SpeziesDatentypen.Spieler_Enum;
   
   Poldicke : KartenDatentypen.KartenfeldNatural;
   
   package ZufälligeVordefinierteKartengrößeWählen is new Ada.Numerics.Discrete_Random (Result_Subtype => RueckgabeDatentypen.Kartengrößen_Standard_Enum);
   package ZufälligeKartengrößeWählen is new Ada.Numerics.Discrete_Random (Result_Subtype => KartenDatentypen.KartenfeldPositiv);
   package ZufälligeKartenartWählen is new Ada.Numerics.Discrete_Random (Result_Subtype => KartenartDatentypen.Kartenart_Normal_Enum);
   package ZufälligeKartentemperaturWählen is new Ada.Numerics.Discrete_Random (Result_Subtype => KartenartDatentypen.Kartentemperatur_Enum);
   package ZufälligeKartenressourcenWählen is new Ada.Numerics.Discrete_Random (Result_Subtype => KartenartDatentypen.Kartenressourcenmenge_Enum);
   package ZufälligeSpeziesbelegungWählen is new Ada.Numerics.Discrete_Random (Result_Subtype => SpeziesDatentypen.Spieler_Enum);
   package ZufälligenSchwierigkeitsgradWählen is new Ada.Numerics.Discrete_Random (Result_Subtype => SpielDatentypen.Schwierigkeitsgrad_Enum);
   package ZufälligeSpeziesWählen is new Ada.Numerics.Discrete_Random (Result_Subtype => SpeziesDatentypen.Spezies_Verwendet_Enum);
   
   package ZufälligerEAchsenÜbergangWählen is new Ada.Numerics.Discrete_Random (Result_Subtype => KartenartDatentypen.Kartenform_E_Einstellbar_Enum);
   package ZufälligerYAchsenÜbergangWählen is new Ada.Numerics.Discrete_Random (Result_Subtype => KartenartDatentypen.Kartenform_Y_Einstellbar_Enum);
   package ZufälligerXAchsenÜbergangWählen is new Ada.Numerics.Discrete_Random (Result_Subtype => KartenartDatentypen.Kartenform_X_Einstellbar_Enum);
   
   package ZufälligePolgrößenWählen is new Ada.Numerics.Discrete_Random (Result_Subtype => KartenDatentypen.KartenfeldNatural);

   ZufälligeVordefinierteKartengrößeGewählt : ZufälligeVordefinierteKartengrößeWählen.Generator;
   ZufälligeKartengrößeGewählt : ZufälligeKartengrößeWählen.Generator;
   ZufälligeKartenartGewählt : ZufälligeKartenartWählen.Generator;
   ZufälligeKartentemperaturGewählt : ZufälligeKartentemperaturWählen.Generator;
   ZufälligeKartenressourcenGewählt : ZufälligeKartenressourcenWählen.Generator;
   ZufälligeSpeziesbelegungGewählt : ZufälligeSpeziesbelegungWählen.Generator;
   ZufälligerSchwierigkeitsgradGewählt : ZufälligenSchwierigkeitsgradWählen.Generator;
   ZufälligeSpeziesGewählt : ZufälligeSpeziesWählen.Generator;
   
   ZufälligerEAchsenÜbergangGewählt : ZufälligerEAchsenÜbergangWählen.Generator;
   ZufälligerYAchsenÜbergangGewählt : ZufälligerYAchsenÜbergangWählen.Generator;
   ZufälligerXAchsenÜbergangGewählt : ZufälligerXAchsenÜbergangWählen.Generator;
   
   ZufälligePolgrößeGewählt : ZufälligePolgrößenWählen.Generator;

end ZufallsgeneratorenSpieleinstellungenLogik;
