pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleDatentypen;
use GlobaleDatentypen;

package EinheitInUmgebung is

   procedure EinheitInUmgebung;
   
private
      
   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;
   
   AndereEinheit : GlobaleRecords.RassePlatznummerRecord;
   
   procedure UmgebungStadt
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);
   
   procedure UmgebungEinheit
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);
   
   
   
   function EinheitFinden
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      UmgebungExtern : in GlobaleDatentypen.Sichtweite;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Boolean;

end EinheitInUmgebung;
