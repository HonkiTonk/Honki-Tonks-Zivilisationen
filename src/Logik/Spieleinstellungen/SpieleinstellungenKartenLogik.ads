private with RueckgabeDatentypen;
private with KartenDatentypen;
private with SystemRecords;
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
   
   MaximaleEisdicke : KartenDatentypen.KartenfeldPositiv;
   YAchse : KartenDatentypen.KartenfeldPositiv;
   XAchse : KartenDatentypen.KartenfeldPositiv;
   
   ZwischenwertKartenart : Positive;
   
   BenutzerdefinierteGröße : SystemRecords.ZahlenEingabeRecord;
   BenutzerdefinierteKartenart : SystemRecords.ZahlenEingabeRecord;
   
   procedure KartenformZuweisen
     (WelcheAchseExtern : in RueckgabeDatentypen.Kartenform_Enum);
   
   procedure KartenartStandard;
   procedure KartenartNutzerdefinition;
   
      
   
   function Polgrößen
     (YAchseXAchseExtern : in Boolean)
      return KartenDatentypen.KartenfeldNatural;
   
   function GrößeSelbstBestimmen
     return KartenRecords.YXAchsenKartenfeldPositivRecord;

end SpieleinstellungenKartenLogik;
