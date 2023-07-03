with EinheitenDatentypen;

package EinheitenArrays is
   pragma Pure;

   type PassierbarkeitArray is array (EinheitenDatentypen.Passierbarkeit_Enum'Range) of Boolean;

end EinheitenArrays;
