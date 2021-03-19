pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleVariablen, GlobaleDatentypen;
use GlobaleDatentypen;

with Karten;

package BewegungEinheitenMoeglichPruefen is

   function FeldFürDieseEinheitPassierbarNeu (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
                                               NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord) return GlobaleDatentypen.LoopRangeMinusEinsZuEins with
     Pre => (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2) and EinheitRasseNummerExtern.Rasse in GlobaleDatentypen.Rassen
             and NeuePositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and NeuePositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
             and (if EinheitRasseNummerExtern.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= 0));
   
   function BefindetSichDortEineEinheit (RasseExtern : GlobaleDatentypen.RassenMitNullwert; NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord) return GlobaleRecords.RassePlatznummerRecord with  
     Pre => (NeuePositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and NeuePositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
             and (if RasseExtern > 0 then GlobaleVariablen.RassenImSpiel (RasseExtern) /= 0));

private

   PassierbarkeitNummer : GlobaleDatentypen.PassierbarkeitType;
   
   StadtNummer : GlobaleDatentypen.MaximaleStädteMitNullWert;
   EinheitNummer : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
   Transportplatz : Natural;
   
   GegnerWert : GlobaleRecords.RassePlatznummerRecord;
   GegnerEinheitWert : GlobaleRecords.RassePlatznummerRecord;
   GegnerStadtWert : GlobaleRecords.RassePlatznummerRecord;

end BewegungEinheitenMoeglichPruefen;
