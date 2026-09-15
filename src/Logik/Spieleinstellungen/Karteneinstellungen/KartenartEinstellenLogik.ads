private with SystemRecordsHTSEB;

private with RueckgabeDatentypen;
private with KartenRecords;

package KartenartEinstellenLogik is
   pragma Elaborate_Body;

   procedure Kartenart;
   
private
   
   KartenartAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
   ZwischenwertKartenart : Positive;
   
   Größeneingabe : KartenRecords.LandgrößenRecord;
   
   BenutzerdefinierteKartenart : SystemRecordsHTSEB.ZahlenEingabeRecord;
   
   procedure KartenartStandard;
   procedure KartenartNutzerdefinition;

end KartenartEinstellenLogik;
