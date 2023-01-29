with EinheitenDatentypen;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with KIDatentypen;

package body KIEinheitFestlegenHeilenLogik is

   -- Um Krieg erweitern oder eine eigene Version davon bauen? äöü
   -- Eigene version die am Ende diese Variante aufruft ist vermutlich am sinnvollsten. äöü
   -- Gilt auch bei den anderen Teilen. äöü
   function Heilen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type EinheitenDatentypen.Lebenspunkte;
   begin
      
      if
        LeseEinheitenGebaut.Lebenspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
        < LeseEinheitenDatenbank.MaximaleLebenspunkte (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                       IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern))
      then
         SchreibeEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                 AufgabeExtern              => KIDatentypen.Einheit_Heilen_Enum);
         
         return True;
         
      else
         return False;
      end if;
      
   end Heilen;

end KIEinheitFestlegenHeilenLogik;
