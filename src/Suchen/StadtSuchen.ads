pragma SPARK_Mode (On);

with Karten, GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen, GlobaleRecords;

package StadtSuchen is

   RückgabeWert : constant Integer := -1_000_000;
   RückgabeWertStadtNummer : constant Natural := 0;   
   
   function KoordinatenStadtMitRasseSuchen (RasseExtern : in GlobaleDatentypen.Rassen; Koordinaten : in GlobaleRecords.AchsenKartenfeldPositivRecord) return Natural with
     Pre => Koordinaten.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and Koordinaten.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
   
   function KoordinatenStadtOhneRasseSuchen (Koordinaten : in GlobaleRecords.AchsenKartenfeldPositivRecord) return GlobaleRecords.RassePlatznummerRecord with
     Pre => Koordinaten.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and Koordinaten.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

   function KoordinatenStadtOhneSpezielleRasseSuchen (RasseExtern : in GlobaleDatentypen.Rassen; Koordinaten : in GlobaleRecords.AchsenKartenfeldPositivRecord) return GlobaleRecords.RassePlatznummerRecord with
     Pre => Koordinaten.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and Koordinaten.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

private
   
   

end StadtSuchen;
