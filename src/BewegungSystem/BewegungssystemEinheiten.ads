pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, Karten, GlobaleVariablen;
use GlobaleDatentypen;

package BewegungssystemEinheiten is

   procedure BewegungEinheitenRichtung (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) with
     Pre => EinheitRasseUndNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseUndNummer.Rasse in GlobaleDatentypen.Rassen;

   procedure BewegungEinheitenBerechnung (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord; NeuePosition : in GlobaleRecords.AchsenAusKartenfeldPositivRecord) with
     Pre => EinheitRasseUndNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseUndNummer.Rasse in GlobaleDatentypen.Rassen
     and NeuePosition.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
     and NeuePosition.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße and NeuePosition.EAchse in Karten.Karten'Range (1);
   
   function ZwischenEbene (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord; ÄnderungExtern : in GlobaleRecords.AchsenAusKartenfeldRecord) return GlobaleDatentypen.LoopRangeMinusEinsZuEins with
     Pre => EinheitRasseUndNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseUndNummer.Rasse in GlobaleDatentypen.Rassen
     and (ÄnderungExtern.EAchse /= 0 or ÄnderungExtern.YAchse /= 0 or ÄnderungExtern.XAchse /= 0);
   
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

   function FeldFürDieseEinheitPassierbar (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord; NeuePosition : in GlobaleRecords.AchsenAusKartenfeldPositivRecord) return Boolean  with
     Pre => EinheitRasseUndNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseUndNummer.Rasse in GlobaleDatentypen.Rassen
     and NeuePosition.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
     and NeuePosition.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße and NeuePosition.EAchse in Karten.Karten'Range (1);
   
   function BefindetSichDortEineEinheit (RasseExtern : GlobaleDatentypen.RassenMitNullwert; NeuePosition : in GlobaleRecords.AchsenAusKartenfeldPositivRecord) return GlobaleRecords.RasseUndPlatznummerRecord with  
     Pre => NeuePosition.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and NeuePosition.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße and NeuePosition.EAchse in Karten.Karten'Range (1);

   function StraßeUndFlussPrüfen (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord; NeuePosition : in GlobaleRecords.AchsenAusKartenfeldPositivRecord) return Integer with
     Pre => EinheitRasseUndNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseUndNummer.Rasse in GlobaleDatentypen.Rassen
     and NeuePosition.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
     and NeuePosition.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße and NeuePosition.EAchse in Karten.Karten'Range (1);

end BewegungssystemEinheiten;
