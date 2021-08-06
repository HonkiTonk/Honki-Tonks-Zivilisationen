pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleDatentypen;
use GlobaleDatentypen;

package EinheitInUmgebung is

   procedure EinheitInUmgebung;
   
private
   
   EinheitInDerNähe : Boolean;
   
   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;
   
   AndereEinheit : GlobaleRecords.RassePlatznummerRecord;
   
   function EinheitFinden
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      UmgebungExtern : in GlobaleDatentypen.Sichtweite;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Boolean;

end EinheitInUmgebung;
