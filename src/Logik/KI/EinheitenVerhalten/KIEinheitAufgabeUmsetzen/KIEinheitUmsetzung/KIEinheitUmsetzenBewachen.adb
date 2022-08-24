pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TastenbelegungDatentypen;

with LeseEinheitenGebaut;

with Aufgaben;

package body KIEinheitUmsetzenBewachen is

   function StadtBewachen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      return Aufgaben.Aufgabe (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                           BefehlExtern             => TastenbelegungDatentypen.Verschanzen_Enum,
                                           KoordinatenExtern        => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
   end StadtBewachen;
     
end KIEinheitUmsetzenBewachen;
