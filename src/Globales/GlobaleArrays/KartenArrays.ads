with SystemDatentypenHTSEB;
with ZufallsgeneratorenDatentypenHTSEB;

with SpeziesDatentypen;
with KartenRecords;
with KartenextraDatentypen;

package KartenArrays is
   pragma Preelaborate;

   type FeldeffektArray is array (KartenextraDatentypen.Effekt_Kartenfeld_Vorhanden_Enum'Range) of Boolean;



   type FelderwertungArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range) of ZufallsgeneratorenDatentypenHTSEB.Bewertung_Enum;



   type SichtbarkeitGesamtArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range, SystemDatentypenHTSEB.AchtElemente'Range) of Boolean;

   type SichtbarkeitKoordinatenArray is array (SystemDatentypenHTSEB.AchtElemente'Range) of KartenRecords.KartenfeldNaturalRecord;

end KartenArrays;
