pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen;

with Karten;

package BewegungssystemEinheiten is

   procedure BewegungEinheitenRichtung (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) = 1));

   procedure BewegungEinheitenBerechnung (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; NeuePosition : in GlobaleRecords.AchsenKartenfeldPositivRecord) with
     Pre => (EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and NeuePosition.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and NeuePosition.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) /= 0));
   
   function ZwischenEbene (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord) return GlobaleDatentypen.LoopRangeMinusEinsZuEins with
     Pre => (EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (ÄnderungExtern.EAchse /= 0 or ÄnderungExtern.YAchse /= 0 or ÄnderungExtern.XAchse /= 0) and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) /= 0));
   
private

   FeldPassierbar : Boolean;
   ErgebnisGegnerAngreifen : Boolean;

   Richtung : Wide_Wide_Character;
      
   RückgabeWert : GlobaleDatentypen.LoopRangeMinusEinsZuEins;
   
   BonusBeiBewegung : Integer;
   Stadtnummer : Integer;
   
   BewegungspunkteModifikator : Float;

   Änderung : GlobaleRecords.AchsenKartenfeldRecord;
   KartenWert : GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord;
   GegnerWert : GlobaleRecords.RassePlatznummerRecord;
   GegnerEinheitWert : GlobaleRecords.RassePlatznummerRecord;
   GegnerStadtWert : GlobaleRecords.RassePlatznummerRecord;

   function FeldFürDieseEinheitPassierbar (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; NeuePosition : in GlobaleRecords.AchsenKartenfeldPositivRecord) return Boolean  with
     Pre => (EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and NeuePosition.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and NeuePosition.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) /= 0));
   
   function BefindetSichDortEineEinheit (RasseExtern : GlobaleDatentypen.RassenMitNullwert; NeuePosition : in GlobaleRecords.AchsenKartenfeldPositivRecord) return GlobaleRecords.RassePlatznummerRecord with  
     Pre => (NeuePosition.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and NeuePosition.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
             and (if RasseExtern > 0 then GlobaleVariablen.RassenImSpiel (RasseExtern) /= 0));

   function StraßeUndFlussPrüfen (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; NeuePosition : in GlobaleRecords.AchsenKartenfeldPositivRecord) return Integer with
     Pre => (EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and NeuePosition.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and NeuePosition.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) /= 0)); 

end BewegungssystemEinheiten;
