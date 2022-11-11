with EinheitenDatentypen; use EinheitenDatentypen;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with KIDatentypen;

package body KIEinheitFestlegenHeilenLogik is

   -- Um Krieg erweitern oder eine eigene Version davon bauen? äöü
   -- Eigene version die am Ende diese Variante aufruft ist vermutlich am sinnvollsten. äöü
   -- Gilt auch bei den anderen Teilen. äöü
   function Heilen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      if
        LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
        < LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                       IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      then
         SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                 AufgabeExtern            => KIDatentypen.Einheit_Heilen_Enum);
         
         return True;
         
      else
         return False;
      end if;
      
   end Heilen;

end KIEinheitFestlegenHeilenLogik;
