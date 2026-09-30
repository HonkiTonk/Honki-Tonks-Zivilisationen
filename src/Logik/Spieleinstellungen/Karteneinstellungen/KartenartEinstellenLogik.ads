private with SystemRecordsHTSEB;

private with RueckgabeDatentypen;
private with KartenRecords;

package KartenartEinstellenLogik is
   pragma Elaborate_Body;

   procedure Kartenart;
   
private
   
   Inseln : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'First;
   Kontinente : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Inseln);
   Pangäa : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Kontinente);
   Nutzerdefiniert : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Pangäa);
   ZufallVordefiniert : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Nutzerdefiniert);
   Zufall : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (ZufallVordefiniert);
   Standardauswahl : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Zufall);
   
   KartenartAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
   ZwischenwertKartenart : Positive;
   
   Größeneingabe : KartenRecords.LandgrößenRecord;
   
   BenutzerdefinierteKartenart : SystemRecordsHTSEB.ZahlenEingabeRecord;
   
   procedure KartenartStandard;
   procedure KartenartNutzerdefinition;

end KartenartEinstellenLogik;
