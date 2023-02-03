with BefehleDatentypen;

with LeseEinheitenGebaut;

with AufgabenLogik;

package body KIEinheitUmsetzenBewachenLogik is

   function StadtBewachen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is begin
      
      return AufgabenLogik.Aufgabe (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                    BefehlExtern               => BefehleDatentypen.Verschanzen_Enum,
                                    AnlegenTestenExtern        => True,
                                    KoordinatenExtern          => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern));
      
   end StadtBewachen;
     
end KIEinheitUmsetzenBewachenLogik;
