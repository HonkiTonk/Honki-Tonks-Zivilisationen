private with SystemRecordsHTSEB;

private with RueckgabeDatentypen;

package KartenartEinstellenLogik is
   pragma Elaborate_Body;

   procedure Kartenart;
   
private
   
   KartenartAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
   ZwischenwertKartenart : Positive;
   
   BenutzerdefinierteKartenart : SystemRecordsHTSEB.ZahlenEingabeRecord;
   
   procedure KartenartStandard;
   procedure KartenartNutzerdefinition;

end KartenartEinstellenLogik;
