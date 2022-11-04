pragma Warnings (Off, "*array aggregate*");

with AufgabenDatentypen;

with SchreibeEinheitenGebaut;

package body EinheitVerschanzenLogik is

   function Verschanzen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              BeschäftigungExtern     => AufgabenDatentypen.Verschanzen_Enum);
      
      return True;
      
   end Verschanzen;

end EinheitVerschanzenLogik;
