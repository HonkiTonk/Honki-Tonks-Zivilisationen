private with SystemRecordsHTSEB;

private with RueckgabeDatentypen;
private with KartenDatentypen;
private with KartenRecords;

package SpieleinstellungenKartenLogik is
   pragma Elaborate_Body;
   
   procedure KartenpoleWählen;
   procedure KartengrößeWählen;
   procedure KartenartWählen;
   procedure KartenformWählen;
   procedure KartentemperaturWählen;
   procedure KartenressourcenWählen;
   
private
   
   KartenpoleAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   KartengrößeAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   KartenartAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   KartenformAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   KartentemperaturAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   KartenressourcenAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
   Senkrechte : KartenDatentypen.SenkrechtePositiv;
   Waagerechte : KartenDatentypen.WaagerechtePositiv;
   
   ZwischenwertKartenart : Positive;
   
   BenutzerdefinierteGröße : SystemRecordsHTSEB.ZahlenEingabeRecord;
   BenutzerdefinierteKartenart : SystemRecordsHTSEB.ZahlenEingabeRecord;
   
   procedure KartenformZuweisen
     (WelchEbeneExtern : in RueckgabeDatentypen.Kartenform_Enum);
   
   procedure KartenartStandard;
   procedure KartenartNutzerdefinition;
   
      
   
   function SenkrechtePolgrößen
     return KartenDatentypen.SenkrechteNatural;
   
   function WaagerechtePolgrößen
     return KartenDatentypen.WaagerechteNatural;
   
   function GrößeSelbstBestimmen
     return KartenRecords.KartenfeldumgebungPositivRecord;

end SpieleinstellungenKartenLogik;
