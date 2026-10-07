with SystemDatentypenHTSEB;
with ZufallsgeneratorenDatentypenHTSEB;

with SpeziesDatentypen;
with KartenRecords;
with KarteneffekteDatentypen;
with KartenrohstoffeDatentypen;
with KartenverbesserungDatentypen;

package KartenArrays is
   pragma Preelaborate;

   type FeldeffektArray is array (KarteneffekteDatentypen.Effekt_Kartenfeld_Vorhanden_Enum'Range) of Boolean;



   type FelderwertungArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range) of ZufallsgeneratorenDatentypenHTSEB.Bewertung_Enum;



   type SichtbarkeitGesamtArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range, SystemDatentypenHTSEB.AchtElemente'Range) of Boolean;

   type SichtbarkeitKoordinatenArray is array (SystemDatentypenHTSEB.AchtElemente'Range) of KartenRecords.KartenfeldNaturalRecord;

   type RohstoffeArray is array (KartenrohstoffeDatentypen.Rohstoffanzahl_Enum'Range) of KartenrohstoffeDatentypen.Rohstoffe_Enum;
   type VerbesserungenArray is array (KartenverbesserungDatentypen.Verbesserungenanzahl_Enum) of KartenverbesserungDatentypen.Verbesserungen_Enum;

end KartenArrays;
