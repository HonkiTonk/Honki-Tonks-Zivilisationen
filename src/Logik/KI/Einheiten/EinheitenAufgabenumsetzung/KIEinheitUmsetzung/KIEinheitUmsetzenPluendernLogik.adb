with BefehleDatentypen;

with LeseEinheitenGebaut;

with AufgabenLogik;

package body KIEinheitUmsetzenPluendernLogik is

   function StadtumgebungZerstören
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is begin
      
      return AufgabenLogik.Aufgabe (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                    BefehlExtern               => BefehleDatentypen.Plündern_Enum,
                                    AnlegenTestenExtern        => True,
                                    KoordinatenExtern          => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern));
      
   end StadtumgebungZerstören;

end KIEinheitUmsetzenPluendernLogik;
