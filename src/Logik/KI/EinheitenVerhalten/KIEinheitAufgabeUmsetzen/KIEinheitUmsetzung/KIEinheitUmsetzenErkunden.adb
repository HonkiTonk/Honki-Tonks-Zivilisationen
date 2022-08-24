pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with LeseEinheitenGebaut;
with LeseKarten;

with Vergleiche;

package body KIEinheitUmsetzenErkunden is

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
        Vergleiche.Koordinatenvergleich (KoordinateEinsExtern  => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                         KoordinatenZweiExtern => ZielKoordinaten)
        = True
      then
         return False;
         
      elsif
        LeseKarten.Sichtbar (KoordinatenExtern => ZielKoordinaten,
                             RasseExtern       => EinheitRasseNummerExtern.Rasse)
        = True
      then
         return False;
         
      else
         return True;
      end if;
      
   end Erkunden;

end KIEinheitUmsetzenErkunden;
