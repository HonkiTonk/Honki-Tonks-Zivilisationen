private with SystemRecordsHTSEB;

private with RueckgabeDatentypen;
private with KartenDatentypen;

package KartenpoleEinstellenLogik is
   pragma Elaborate_Body;

   procedure Kartenpole;
     
private
   
   Nordpol : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'First;
   Südpol : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Nordpol);
   Westpol : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Südpol);
   Ostpol : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Westpol);
   Zufall : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Ostpol);
   Standardpol : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Zufall);
   
   KartenpoleAuswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
   BenutzerdefinierteGröße : SystemRecordsHTSEB.ZahlenEingabeRecord;
   
   
   
   function SenkrechtePolgrößen
     return KartenDatentypen.SenkrechteNatural;
   
   function WaagerechtePolgrößen
     return KartenDatentypen.WaagerechteNatural;

end KartenpoleEinstellenLogik;
