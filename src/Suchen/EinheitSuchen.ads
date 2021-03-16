pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen, GlobaleRecords;

with Karten;

package EinheitSuchen is

   function KoordinatenEinheitMitRasseSuchen (RasseExtern : in GlobaleDatentypen.Rassen; KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord) return GlobaleDatentypen.MaximaleEinheitenMitNullWert with
     Pre => (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
             and GlobaleVariablen.RassenImSpiel (RasseExtern) /= 0);

   function KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord) return GlobaleRecords.RassePlatznummerRecord with
     Pre  => (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße),
     Post => ((if KoordinatenEinheitOhneRasseSuchen'Result.Rasse > 0 then GlobaleVariablen.RassenImSpiel (KoordinatenEinheitOhneRasseSuchen'Result.Rasse) /= 0));

   function KoordinatenEinheitOhneSpezielleRasseSuchen (RasseExtern : in GlobaleDatentypen.Rassen; KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord) return GlobaleRecords.RassePlatznummerRecord with
     Pre  => (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
              and GlobaleVariablen.RassenImSpiel (RasseExtern) /= 0),
     Post => ((if KoordinatenEinheitOhneSpezielleRasseSuchen'Result.Rasse > 0 then GlobaleVariablen.RassenImSpiel (KoordinatenEinheitOhneSpezielleRasseSuchen'Result.Rasse) /= 0));

private
   
   

end EinheitSuchen;
