pragma SPARK_Mode (On);

with EinheitStadtRecords;
with KartenRecords;
with KartenDatentypen;
with SystemDatentypen;

package EinheitInUmgebung is

   procedure EinheitInUmgebung;
   
private
      
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   AndereEinheit : EinheitStadtRecords.RassePlatznummerRecord;
   
   procedure UmgebungStadt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);
   
   procedure UmgebungEinheit
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);
   
   
   
   function EinheitFinden
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      UmgebungExtern : in KartenDatentypen.Sichtweite;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Boolean;

end EinheitInUmgebung;
