pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, Karten, GlobaleVariablen;
use GlobaleDatentypen;

package BewegungssystemEinheiten is

   procedure BewegungEinheitenRichtung (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Global  => (null),
     Depends => (null => (EinheitRasseNummer)),
     Pre     => (EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen);

   procedure BewegungEinheitenBerechnung (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; NeuePosition : in GlobaleRecords.AchsenKartenfeldPositivRecord) with
     Global  => (null),
     Depends => (null => (EinheitRasseNummer, NeuePosition)),
     Pre     => (EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
                 and NeuePosition.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
                 and NeuePosition.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße and NeuePosition.EAchse in Karten.Karten'Range (1));
   
   function ZwischenEbene (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord) return GlobaleDatentypen.LoopRangeMinusEinsZuEins with
     Global => (null),
     Pre    => (EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
                and (ÄnderungExtern.EAchse /= 0 or ÄnderungExtern.YAchse /= 0 or ÄnderungExtern.XAchse /= 0)),
     Post   => (ZwischenEbene'Result in -1 .. 1);
   
private

   FeldPassierbar : Boolean;
   ErgebnisGegnerAngreifen : Boolean;

   Richtung : Wide_Wide_Character;
      
   RückgabeWert : GlobaleDatentypen.LoopRangeMinusEinsZuEins;
   
   BonusBeiBewegung : Integer;
   Stadtnummer : Integer;
   
   BewegungspunkteModifikator : Float;

   Änderung : GlobaleRecords.AchsenKartenfeldRecord;
   KartenWert : GlobaleRecords.AchsenKartenfeldRecord;
   GegnerWert : GlobaleRecords.RassePlatznummerRecord;
   GegnerEinheitWert : GlobaleRecords.RassePlatznummerRecord;
   GegnerStadtWert : GlobaleRecords.RassePlatznummerRecord;

   function FeldFürDieseEinheitPassierbar (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; NeuePosition : in GlobaleRecords.AchsenKartenfeldPositivRecord) return Boolean  with
     Pre => EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
     and NeuePosition.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
     and NeuePosition.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße and NeuePosition.EAchse in Karten.Karten'Range (1);
   
   function BefindetSichDortEineEinheit (RasseExtern : GlobaleDatentypen.RassenMitNullwert; NeuePosition : in GlobaleRecords.AchsenKartenfeldPositivRecord) return GlobaleRecords.RassePlatznummerRecord with  
     Pre => NeuePosition.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and NeuePosition.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße and NeuePosition.EAchse in Karten.Karten'Range (1);

   function StraßeUndFlussPrüfen (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; NeuePosition : in GlobaleRecords.AchsenKartenfeldPositivRecord) return Integer with
     Pre => EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
     and NeuePosition.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
     and NeuePosition.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße and NeuePosition.EAchse in Karten.Karten'Range (1);

end BewegungssystemEinheiten;
