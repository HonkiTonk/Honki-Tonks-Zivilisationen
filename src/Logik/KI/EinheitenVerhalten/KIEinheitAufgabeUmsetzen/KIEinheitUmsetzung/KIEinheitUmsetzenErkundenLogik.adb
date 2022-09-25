pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with LeseEinheitenGebaut;
with LeseWeltkarte;

with Vergleiche;

package body KIEinheitUmsetzenErkundenLogik is

   function Erkunden
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      ZielKoordinaten := LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      if
        Vergleiche.KoordinateLeervergleich (KoordinateExtern => ZielKoordinaten) = True
      then
         return False;
         
      elsif
        True = Vergleiche.Koordinatenvergleich (KoordinateEinsExtern  => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                KoordinatenZweiExtern => ZielKoordinaten)
      then
         return False;
         
      elsif
        True = LeseWeltkarte.Sichtbar (KoordinatenExtern => ZielKoordinaten,
                                       RasseExtern       => EinheitRasseNummerExtern.Rasse)
      then
         return False;
         
      else
         return True;
      end if;
      
   end Erkunden;

end KIEinheitUmsetzenErkundenLogik;
