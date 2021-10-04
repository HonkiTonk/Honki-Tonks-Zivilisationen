pragma SPARK_Mode (On);

with EinheitStadtRecords, GlobaleDatentypen, KartenRecords, SonstigeDatentypen, KartenDatentypen;
use GlobaleDatentypen;

package EinheitInUmgebung is

   procedure EinheitInUmgebung;
   
private
      
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   AndereEinheit : EinheitStadtRecords.RassePlatznummerRecord;
   
   procedure UmgebungStadt
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);
   
   procedure UmgebungEinheit
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);
   
   
   
   function EinheitFinden
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      UmgebungExtern : in KartenDatentypen.Sichtweite;
      RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return Boolean;

end EinheitInUmgebung;
