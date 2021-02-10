pragma SPARK_Mode (On);

package body KIEinheitVerbessernOderVernichten is

   function KIEinheitVerbessern (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) return Boolean is
   begin
      
      return False;
      
   end KIEinheitVerbessern;



   function KIEinheitVernichten (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) return Boolean is
   begin
      
      return False;
      
   end KIEinheitVernichten;

end KIEinheitVerbessernOderVernichten;
