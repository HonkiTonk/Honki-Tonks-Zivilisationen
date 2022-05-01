pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SchreibeKarten;
with LeseEinheitenGebaut;
with LeseKarten;

package body RodenAnlegen is

   procedure RodenAnlegen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      SchreibeKarten.Grund (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                            GrundExtern       => HügelSetzen (LeseKarten.Hügel (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern))));
      
   end RodenAnlegen;

end RodenAnlegen;
