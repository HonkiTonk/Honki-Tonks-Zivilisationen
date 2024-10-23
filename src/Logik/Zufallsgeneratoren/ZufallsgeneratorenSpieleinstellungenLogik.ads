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
     return KartenRecords.KartenfeldumgebungPositivRecord;
   
   function ZufälligeVordefinierteKartenart
     return KartenartDatentypen.Kartenart_Normal_Enum;
   
   function ZufälligeKartentemperatur
     return KartenartDatentypen.Kartentemperatur_Enum;
   
   function ZufälligeKartenressourcen
     return KartenartDatentypen.Kartenressourcenmenge_Enum;
   
   function ZufälligerSchwiewrigkeitsgrad
     return SpielDatentypen.Schwierigkeitsgrad_Enum;
   
   function ZufälligeSpezies
     return SpeziesDatentypen.Spezies_Vorhanden_Enum;

private
   
   SpielerVorhanden : Boolean;
   
   SpeziesImSpiel : SpeziesDatentypen.Spieler_Enum;
   
   Poldicke : KartenDatentypen.SenkrechteNatural;
   
   package ZufälligeVordefinierteKartengrößeWählen is new Ada.Numerics.Discrete_Random (Result_Subtype => RueckgabeDatentypen.Kartengrößen_Standard_Enum);
   package ZufälligeKartensenkrechteWählen is new Ada.Numerics.Discrete_Random (Result_Subtype => KartenDatentypen.SenkrechtePositiv);
   package ZufälligeKartenwaagerechteWählen is new Ada.Numerics.Discrete_Random (Result_Subtype => KartenDatentypen.WaagerechtePositiv);
   package ZufälligeKartenartWählen is new Ada.Numerics.Discrete_Random (Result_Subtype => KartenartDatentypen.Kartenart_Normal_Enum);
   package ZufälligeKartentemperaturWählen is new Ada.Numerics.Discrete_Random (Result_Subtype => KartenartDatentypen.Kartentemperatur_Enum);
   package ZufälligeKartenressourcenWählen is new Ada.Numerics.Discrete_Random (Result_Subtype => KartenartDatentypen.Kartenressourcenmenge_Enum);
   package ZufälligeSpeziesbelegungWählen is new Ada.Numerics.Discrete_Random (Result_Subtype => SpeziesDatentypen.Spieler_Enum);
   package ZufälligenSchwierigkeitsgradWählen is new Ada.Numerics.Discrete_Random (Result_Subtype => SpielDatentypen.Schwierigkeitsgrad_Enum);
   package ZufälligeSpeziesWählen is new Ada.Numerics.Discrete_Random (Result_Subtype => SpeziesDatentypen.Spezies_Vorhanden_Enum);
   
   package ZufälligerEbeneÜbergangWählen is new Ada.Numerics.Discrete_Random (Result_Subtype => KartenartDatentypen.Kartenform_Ebene_Einstellbar_Enum);
   package ZufälligerSenkrechteÜbergangWählen is new Ada.Numerics.Discrete_Random (Result_Subtype => KartenartDatentypen.Kartenform_Senkrechte_Einstellbar_Enum);
   package ZufälligerWaagerechteÜbergangWählen is new Ada.Numerics.Discrete_Random (Result_Subtype => KartenartDatentypen.Kartenform_Waagerechte_Einstellbar_Enum);
   
   package ZufälligeSenkrechtePolgrößenWählen is new Ada.Numerics.Discrete_Random (Result_Subtype => KartenDatentypen.SenkrechteNatural);
   package ZufälligeWaagerechtePolgrößenWählen is new Ada.Numerics.Discrete_Random (Result_Subtype => KartenDatentypen.WaagerechteNatural);

   ZufälligeVordefinierteKartengrößeGewählt : ZufälligeVordefinierteKartengrößeWählen.Generator;
   ZufälligeKartensenkrechteGewählt : ZufälligeKartensenkrechteWählen.Generator;
   ZufälligeKartenwaagerechteGewählt : ZufälligeKartenwaagerechteWählen.Generator;
   ZufälligeKartenartGewählt : ZufälligeKartenartWählen.Generator;
   ZufälligeKartentemperaturGewählt : ZufälligeKartentemperaturWählen.Generator;
   ZufälligeKartenressourcenGewählt : ZufälligeKartenressourcenWählen.Generator;
   ZufälligeSpeziesbelegungGewählt : ZufälligeSpeziesbelegungWählen.Generator;
   ZufälligerSchwierigkeitsgradGewählt : ZufälligenSchwierigkeitsgradWählen.Generator;
   ZufälligeSpeziesGewählt : ZufälligeSpeziesWählen.Generator;
   
   ZufälligerEbeneÜbergangGewählt : ZufälligerEbeneÜbergangWählen.Generator;
   ZufälligerSenkrechteÜbergangGewählt : ZufälligerSenkrechteÜbergangWählen.Generator;
   ZufälligerWaagerechteÜbergangGewählt : ZufälligerWaagerechteÜbergangWählen.Generator;
   
   ZufälligeSenkrechtePolgrößeGewählt : ZufälligeSenkrechtePolgrößenWählen.Generator;
   ZufälligeWaagerechtePolgrößeGewählt : ZufälligeWaagerechtePolgrößenWählen.Generator;

end ZufallsgeneratorenSpieleinstellungenLogik;
