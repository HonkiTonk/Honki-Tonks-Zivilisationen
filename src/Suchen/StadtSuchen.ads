pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen, GlobaleRecords;

with Karten;

package StadtSuchen is

   RückgabeWert : constant Integer := -1_000_000;
   RückgabeWertStadtNummer : constant Natural := 0;   
   
   function KoordinatenStadtMitRasseSuchen (RasseExtern : in GlobaleDatentypen.Rassen; Koordinaten : in GlobaleRecords.AchsenKartenfeldPositivRecord) return Natural with
     Pre => (Koordinaten.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and Koordinaten.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße and GlobaleVariablen.RassenImSpiel (RasseExtern) /= 0);
   
   function KoordinatenStadtOhneRasseSuchen (Koordinaten : in GlobaleRecords.AchsenKartenfeldPositivRecord) return GlobaleRecords.RassePlatznummerRecord with
     Pre  => (Koordinaten.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and Koordinaten.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße),
     Post => ((if KoordinatenStadtOhneRasseSuchen'Result.Rasse > 0 then GlobaleVariablen.RassenImSpiel (KoordinatenStadtOhneRasseSuchen'Result.Rasse) /= 0));

   function KoordinatenStadtOhneSpezielleRasseSuchen (RasseExtern : in GlobaleDatentypen.Rassen; Koordinaten : in GlobaleRecords.AchsenKartenfeldPositivRecord) return GlobaleRecords.RassePlatznummerRecord with
     Pre  => (Koordinaten.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and Koordinaten.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße and GlobaleVariablen.RassenImSpiel (RasseExtern) /= 0),
     Post => ((if KoordinatenStadtOhneSpezielleRasseSuchen'Result.Rasse > 0 then GlobaleVariablen.RassenImSpiel (KoordinatenStadtOhneSpezielleRasseSuchen'Result.Rasse) /= 0));

private
   
   

end StadtSuchen;
