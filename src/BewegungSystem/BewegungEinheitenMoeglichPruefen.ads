pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleVariablen, GlobaleDatentypen;
use GlobaleDatentypen;

with Karten;

package BewegungEinheitenMoeglichPruefen is

   function FeldFürDieseEinheitPassierbar (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; NeuePosition : in GlobaleRecords.AchsenKartenfeldPositivRecord) return Boolean with
     Pre => (EinheitRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and NeuePosition.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and NeuePosition.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) /= 0));
   
   function BefindetSichDortEineEinheit (RasseExtern : GlobaleDatentypen.RassenMitNullwert; NeuePosition : in GlobaleRecords.AchsenKartenfeldPositivRecord) return GlobaleRecords.RassePlatznummerRecord with  
     Pre => (NeuePosition.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and NeuePosition.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
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
