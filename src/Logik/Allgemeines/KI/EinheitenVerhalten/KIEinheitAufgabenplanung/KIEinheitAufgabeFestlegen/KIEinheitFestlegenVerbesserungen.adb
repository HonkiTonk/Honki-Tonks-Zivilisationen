pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SchreibeEinheitenGebaut;

with Vergleiche;

with KIDatentypen;

with KIEinheitAufgabeplanungAllgemeines;

package body KIEinheitFestlegenVerbesserungen is

   function StadtumgebungVerbessern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      VerbesserungKoordinaten := KIEinheitAufgabeplanungAllgemeines.StadtUmgebungPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        Vergleiche.KoordinateLeervergleich (KoordinateExtern => VerbesserungKoordinaten)
      is
         when True =>
            return False;
            
         when False =>
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Verbesserung_Anlegen_Enum);
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       KoordinatenExtern        => VerbesserungKoordinaten);
            return True;
      end case;
      
   end StadtumgebungVerbessern;

end KIEinheitFestlegenVerbesserungen;
