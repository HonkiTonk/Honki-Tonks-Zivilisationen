with SystemDatentypenHTSEB;

with SpeziesDatentypen;

package KartenArrays is
   pragma Preelaborate;

   type SichtbarkeitGesamtArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range, SystemDatentypenHTSEB.AchtElemente) of Boolean;

end KartenArrays;
