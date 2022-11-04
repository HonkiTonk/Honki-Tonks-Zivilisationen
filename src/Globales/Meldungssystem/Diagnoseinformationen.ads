pragma Warnings (Off, "*array aggregate*");

with KartenRecords;
with EinheitenRecords;

package Diagnoseinformationen is
   pragma Elaborate_Body;

   procedure Koordinateninformationen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord);
   
   procedure Einheiteninformationen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord);

end Diagnoseinformationen;
