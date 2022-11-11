with BefehleDatentypen;

with LeseEinheitenGebaut;

with AufgabenLogik;

package body KIEinheitUmsetzenPluendernLogik is

   function StadtumgebungZerstören
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      return AufgabenLogik.Aufgabe (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                    BefehlExtern             => BefehleDatentypen.Plündern_Enum,
                                    KoordinatenExtern        => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
   end StadtumgebungZerstören;

end KIEinheitUmsetzenPluendernLogik;
