pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleDatentypen, KartenRecords;
use GlobaleDatentypen;

package EinheitInUmgebung is

   procedure EinheitInUmgebung;
   
private
      
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   AndereEinheit : GlobaleRecords.RassePlatznummerRecord;
   
   procedure UmgebungStadt
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);
   
   procedure UmgebungEinheit
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);
   
   
   
   function EinheitFinden
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      UmgebungExtern : in GlobaleDatentypen.Sichtweite;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Boolean;

end EinheitInUmgebung;
