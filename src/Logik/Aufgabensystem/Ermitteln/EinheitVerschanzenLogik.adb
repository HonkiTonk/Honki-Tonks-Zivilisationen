with AufgabenDatentypen;

with SchreibeEinheitenGebaut;

package body EinheitVerschanzenLogik is

   function Verschanzen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is begin
      
      SchreibeEinheitenGebaut.Beschäftigung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                              BeschäftigungExtern        => AufgabenDatentypen.Verschanzen_Enum);
      
      return True;
      
   end Verschanzen;

end EinheitVerschanzenLogik;
