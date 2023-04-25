with SpeziesDatentypen;
with KartengrundDatentypen;
with ProduktionDatentypen;

package SpeziesArrays is
   pragma Pure;

   -- Wenn ich diese Zeitarrays in ein dreidimensionales Array packe, könnte ich dann die Beschäftigung mit reinschieben und entsprechend Teile der Arbeitszeitprüfungen zusammenschieben? äöü
   type BasiszeitArray is array (SpeziesDatentypen.Spezies_Verwendet_Enum'Range, KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Range) of ProduktionDatentypen.Arbeitszeit;
   type ZusatzzeitArray is array (SpeziesDatentypen.Spezies_Verwendet_Enum'Range, KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Range) of ProduktionDatentypen.Arbeitszeit;

end SpeziesArrays;
