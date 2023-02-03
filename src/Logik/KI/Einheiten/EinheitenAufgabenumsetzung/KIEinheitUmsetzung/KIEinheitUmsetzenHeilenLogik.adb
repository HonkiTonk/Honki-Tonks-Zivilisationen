with BefehleDatentypen;

with LeseEinheitenGebaut;

with AufgabenLogik;

package body KIEinheitUmsetzenHeilenLogik is

   function Heilen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is begin
      
      return AufgabenLogik.Aufgabe (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                    BefehlExtern               => BefehleDatentypen.Heilen_Enum,
                                    AnlegenTestenExtern        => True,
                                    KoordinatenExtern          => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern));
      
   end Heilen;

end KIEinheitUmsetzenHeilenLogik;
