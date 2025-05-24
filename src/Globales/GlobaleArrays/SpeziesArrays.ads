with SystemDatentypenHTSEB;

with SpeziesDatentypen;
with KartengrundDatentypen;
with ProduktionDatentypen;

package SpeziesArrays is
   pragma Pure;

   type BasiszeitArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range, KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Range) of ProduktionDatentypen.Arbeitszeit;
   type ZusatzzeitArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range, KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Range) of ProduktionDatentypen.Arbeitszeit;

   -- Auslagern. äöü
   type SpeziesByteArray is array (1 .. 3) of SystemDatentypenHTSEB.EinByte;

end SpeziesArrays;
