private with SystemRecordsHTSEB;

private with RueckgabeDatentypen;
private with KartenDatentypen;
private with KartenRecords;

package KartengroesseEinstellenLogik is
   pragma Elaborate_Body;
   
   procedure Kartengröße;
   
private
   
   Nutzerdefiniert : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (RueckgabeDatentypen.Kartengrößen_Standard_Enum'Last);
   Standardzufall : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Nutzerdefiniert);
   Zufall : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Standardzufall);
   
   KartengrößeAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
   Senkrechte : KartenDatentypen.SenkrechtePositiv;
   Waagerechte : KartenDatentypen.WaagerechtePositiv;
   
   BenutzerdefinierteGröße : SystemRecordsHTSEB.ZahlenEingabeRecord;
   
        
   
   function GrößeSelbstBestimmen
     return KartenRecords.KartenfeldumgebungPositivRecord;

end KartengroesseEinstellenLogik;
