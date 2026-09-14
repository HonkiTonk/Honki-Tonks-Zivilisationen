private with SystemRecordsHTSEB;

private with RueckgabeDatentypen;
private with KartenDatentypen;

package KartenpoleEinstellenLogik is
   pragma Elaborate_Body;

   procedure Kartenpole;
     
private
   
   KartenpoleAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
   BenutzerdefinierteGröße : SystemRecordsHTSEB.ZahlenEingabeRecord;
   
   
   
   function SenkrechtePolgrößen
     return KartenDatentypen.SenkrechteNatural;
   
   function WaagerechtePolgrößen
     return KartenDatentypen.WaagerechteNatural;

end KartenpoleEinstellenLogik;
