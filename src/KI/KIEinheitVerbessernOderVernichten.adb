pragma SPARK_Mode (On);

package body KIEinheitVerbessernOderVernichten is

   function KIEinheitVerbessern
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      return False;
      
   end KIEinheitVerbessern;



   function KIEinheitVernichten
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      return False;
      
   end KIEinheitVernichten;

end KIEinheitVerbessernOderVernichten;
