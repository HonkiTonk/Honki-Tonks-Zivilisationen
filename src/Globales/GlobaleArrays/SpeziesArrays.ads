with SystemDatentypenHTSEB;

with SpeziesDatentypen;
with KartenzusatzgrundDatentypen;
with ProduktionDatentypen;
with KartenbasisgrundDatentypen;


package SpeziesArrays is
   pragma Pure;

   type BasiszeitArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range, KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum'Range) of ProduktionDatentypen.ArbeitszeitBasis;
   type ZusatzzeitArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range, KartenzusatzgrundDatentypen.Zusatzgrund_Vorhanden_Enum'Range) of ProduktionDatentypen.ArbeitszeitBasis;

   -- Später auslagern und wenn möglich zusammenfassen. äöü
   type SpeziesByteArray is array (1 .. 3) of SystemDatentypenHTSEB.EinByte;

   type SoeziesSichtbarkeitVorzeichenArray is array (1 .. 3) of SystemDatentypenHTSEB.EinByteVorzeichen;
   -- Bis hier. äöü

end SpeziesArrays;
