with GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen;

package BewegungssystemEinheiten is

   procedure BewegungEinheitenRichtung (RasseExtern : GlobaleDatentypen.Rassen; EinheitNummer : in Positive);
   procedure BewegungEinheitenBerechnung (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive; YPosition, XPosition : in GlobaleDatentypen.KartenfeldPositiv);
   
   function ZwischenEbene (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive; YÄnderung, XÄnderung : in GlobaleDatentypen.LoopRangeMinusEinsZuEins) return GlobaleDatentypen.LoopRangeMinusEinsZuEins with
     Pre => (YÄnderung /= 0 or XÄnderung /= 0);
   
private

   FeldPassierbar : Boolean;
   ErgebnisGegnerAngreifen : Boolean;

   Richtung : Wide_Wide_Character;
      
   XÄnderung : GlobaleDatentypen.LoopRangeMinusEinsZuEins;
   YÄnderung : GlobaleDatentypen.LoopRangeMinusEinsZuEins;
   RückgabeWert : GlobaleDatentypen.LoopRangeMinusEinsZuEins;
   
   Stadtnummer : Integer;

   KartenWert : GlobaleRecords.AchsenAusKartenfeldRecord;
   GegnerWert : GlobaleRecords.RasseUndPlatznummerRecord;
   GegnerEinheitWert : GlobaleRecords.RasseUndPlatznummerRecord;
   GegnerStadtWert : GlobaleRecords.RasseUndPlatznummerRecord;

   function FeldFürDieseEinheitPassierbar (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive; YPosition, XPosition : in GlobaleDatentypen.KartenfeldPositiv) return Boolean;
   function BefindetSichDortEineEinheit (RasseExtern : GlobaleDatentypen.RassenMitNullwert; YPosition, XPosition : in GlobaleDatentypen.KartenfeldPositiv) return GlobaleRecords.RasseUndPlatznummerRecord;

end BewegungssystemEinheiten;
