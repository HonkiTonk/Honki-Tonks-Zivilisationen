with GlobaleDatentypen, GlobaleRecords, Karten, GlobaleVariablen;
use GlobaleDatentypen;

package BewegungssystemEinheiten is

   procedure BewegungEinheitenRichtung (RasseExtern : GlobaleDatentypen.Rassen; EinheitNummer : in Positive) with
     Pre => EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2);

   procedure BewegungEinheitenBerechnung (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive; NeuePosition : in GlobaleRecords.AchsenAusKartenfeldPositivRecord) with
     Pre => EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2) and NeuePosition.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
     and NeuePosition.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße and NeuePosition.EAchse in Karten.Karten'Range (1);
   
   function ZwischenEbene (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive; ÄnderungExtern : in GlobaleRecords.AchsenAusKartenfeldRecord) return GlobaleDatentypen.LoopRangeMinusEinsZuEins with
     Pre => (ÄnderungExtern.EAchse /= 0 or ÄnderungExtern.YAchse /= 0 or ÄnderungExtern.XAchse /= 0) and EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2);
   
private

   FeldPassierbar : Boolean;
   ErgebnisGegnerAngreifen : Boolean;

   Richtung : Wide_Wide_Character;
      
   RückgabeWert : GlobaleDatentypen.LoopRangeMinusEinsZuEins;
   
   BonusBeiBewegung : Integer;
   Stadtnummer : Integer;
   
   BewegungspunkteModifikator : Float;

   Änderung : GlobaleRecords.AchsenAusKartenfeldRecord;
   KartenWert : GlobaleRecords.AchsenAusKartenfeldRecord;
   GegnerWert : GlobaleRecords.RasseUndPlatznummerRecord;
   GegnerEinheitWert : GlobaleRecords.RasseUndPlatznummerRecord;
   GegnerStadtWert : GlobaleRecords.RasseUndPlatznummerRecord;

   function FeldFürDieseEinheitPassierbar (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive; NeuePosition : in GlobaleRecords.AchsenAusKartenfeldPositivRecord) return Boolean with  
     Pre => EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2) and NeuePosition.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
     and NeuePosition.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße and NeuePosition.EAchse in Karten.Karten'Range (1);
   
   function BefindetSichDortEineEinheit (RasseExtern : GlobaleDatentypen.RassenMitNullwert; NeuePosition : in GlobaleRecords.AchsenAusKartenfeldPositivRecord) return GlobaleRecords.RasseUndPlatznummerRecord with  
     Pre => NeuePosition.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and NeuePosition.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße and NeuePosition.EAchse in Karten.Karten'Range (1);

   function StraßeUndFlussPrüfen (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive; NeuePosition : in GlobaleRecords.AchsenAusKartenfeldPositivRecord) return Integer with
     Pre => EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2) and NeuePosition.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
     and NeuePosition.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße and NeuePosition.EAchse in Karten.Karten'Range (1);

end BewegungssystemEinheiten;
