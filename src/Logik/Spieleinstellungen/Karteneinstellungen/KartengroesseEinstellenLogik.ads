private with SystemRecordsHTSEB;

private with RueckgabeDatentypen;
private with KartenDatentypen;
private with KartenRecords;

package KartengroesseEinstellenLogik is
   pragma Elaborate_Body;
   
   procedure Kartengröße;
   
private
   
   KartengrößeAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
   Senkrechte : KartenDatentypen.SenkrechtePositiv;
   Waagerechte : KartenDatentypen.WaagerechtePositiv;
   
   BenutzerdefinierteGröße : SystemRecordsHTSEB.ZahlenEingabeRecord;
   
        
   
   function GrößeSelbstBestimmen
     return KartenRecords.KartenfeldumgebungPositivRecord;

end KartengroesseEinstellenLogik;
