pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenKonstanten;

with KIDatentypen; use KIDatentypen;

with SchreibeEinheitenGebaut;

package body KIEinheitFestlegenNichts is

   function NichtsTun
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      ------------------------------------- Hier eventuell die Bewegungspukte auf 0 setzen?
      SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              AufgabeExtern            => KIDatentypen.Tut_Nichts_Enum);
      SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              BeschäftigungExtern      => EinheitenKonstanten.LeerBeschäftigung);
      
      ------------------------------- Brauchts das hier noch eine Sonderprüfung?
      return True;
      
   end NichtsTun;

end KIEinheitFestlegenNichts;
