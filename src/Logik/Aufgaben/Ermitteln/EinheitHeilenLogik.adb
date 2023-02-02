with EinheitenDatentypen;
with AufgabenDatentypen;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with SchreibeEinheitenGebaut;

package body EinheitHeilenLogik is

   function EinheitHeilen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is
      use type EinheitenDatentypen.Lebenspunkte;
   begin
      
      if
        LeseEinheitenGebaut.Lebenspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
        >= LeseEinheitenDatenbank.MaximaleLebenspunkte (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                        IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern))
      then
         return False;
         
      else
         null;
      end if;
      
      case
        AnlegenTestenExtern
      is
         when True =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    BeschäftigungExtern        => AufgabenDatentypen.Heilen_Enum);
            
         when False =>
            null;
      end case;
      
      return True;
      
   end EinheitHeilen;

end EinheitHeilenLogik;
