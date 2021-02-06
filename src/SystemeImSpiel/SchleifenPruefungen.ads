pragma SPARK_Mode (On);

with Karten, GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen, GlobaleRecords;

package SchleifenPruefungen is

   RückgabeWert : constant Integer := -1_000_000;
   
   function KartenUmgebung (Koordinaten : in GlobaleRecords.AchsenAusKartenfeldPositivRecord; Änderung : in GlobaleRecords.AchsenAusKartenfeldRecord;
                            ZusatzYAbstand : in GlobaleDatentypen.Kartenfeld) return GlobaleRecords.AchsenAusKartenfeldRecord with
     Pre => Koordinaten.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and Koordinaten.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße and ZusatzYAbstand >= 0;
   
   function KoordinatenStadtMitRasseSuchen (RasseExtern : in GlobaleDatentypen.Rassen; Koordinaten : in GlobaleRecords.AchsenAusKartenfeldPositivRecord) return Integer with
     Pre => Koordinaten.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and Koordinaten.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

   function KoordinatenEinheitMitRasseSuchen (RasseExtern : in GlobaleDatentypen.Rassen; Koordinaten : in GlobaleRecords.AchsenAusKartenfeldPositivRecord) return Integer with
     Pre => Koordinaten.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and Koordinaten.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
   
   function KoordinatenStadtOhneRasseSuchen (Koordinaten : in GlobaleRecords.AchsenAusKartenfeldPositivRecord) return GlobaleRecords.RasseUndPlatznummerRecord with
     Pre => Koordinaten.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and Koordinaten.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

   function KoordinatenEinheitOhneRasseSuchen (Koordinaten : in GlobaleRecords.AchsenAusKartenfeldPositivRecord) return GlobaleRecords.RasseUndPlatznummerRecord with
     Pre => Koordinaten.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and Koordinaten.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
   
   function KartenGrund (Koordinaten : in GlobaleRecords.AchsenAusKartenfeldPositivRecord) return Boolean with
     Pre => Koordinaten.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and Koordinaten.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
   
private

   Überhang : Integer;

   Kartenwert : GlobaleRecords.AchsenAusKartenfeldRecord;

end SchleifenPruefungen;
