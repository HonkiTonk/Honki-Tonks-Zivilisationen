pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen, GlobaleRecords;

with Karten;

package EinheitSuchen is

   function KoordinatenEinheitMitRasseSuchen (RasseExtern : in GlobaleDatentypen.Rassen; Koordinaten : in GlobaleRecords.AchsenKartenfeldPositivRecord) return Natural with
     Pre => (Koordinaten.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and Koordinaten.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße and GlobaleVariablen.RassenImSpiel (RasseExtern) /= 0);

   function KoordinatenEinheitOhneRasseSuchen (Koordinaten : in GlobaleRecords.AchsenKartenfeldPositivRecord) return GlobaleRecords.RassePlatznummerRecord with
     Pre  => ((if Karten.Kartengröße /= 10 then Koordinaten.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße) 
              and (if Karten.Kartengröße /= 10 then Koordinaten.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße)),
     Post => ((if KoordinatenEinheitOhneRasseSuchen'Result.Rasse > 0 then GlobaleVariablen.RassenImSpiel (KoordinatenEinheitOhneRasseSuchen'Result.Rasse) /= 0));

   function KoordinatenEinheitOhneSpezielleRasseSuchen (RasseExtern : in GlobaleDatentypen.Rassen; Koordinaten : in GlobaleRecords.AchsenKartenfeldPositivRecord) return GlobaleRecords.RassePlatznummerRecord with
     Pre  => (Koordinaten.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and Koordinaten.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße and GlobaleVariablen.RassenImSpiel (RasseExtern) /= 0),
     Post => ((if KoordinatenEinheitOhneSpezielleRasseSuchen'Result.Rasse > 0 then GlobaleVariablen.RassenImSpiel (KoordinatenEinheitOhneSpezielleRasseSuchen'Result.Rasse) /= 0));

private
   
   

end EinheitSuchen;
