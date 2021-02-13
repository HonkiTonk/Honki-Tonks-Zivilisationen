pragma SPARK_Mode (On);

package body KIEinheitVerbessernOderVernichten is

   function KIEinheitVerbessern (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) return Boolean is
   begin
      
      return False;
      
   end KIEinheitVerbessern;



   function KIEinheitVernichten (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) return Boolean is
   begin
      
      return False;
      
   end KIEinheitVernichten;

end KIEinheitVerbessernOderVernichten;
