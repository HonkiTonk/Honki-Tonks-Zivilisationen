with GlobaleVariablen, Karten, GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen, GlobaleRecords;

package SchleifenPruefungen is

   RückgabeWert : constant Integer := -1_000_000;
   
   function KartenUmgebung (Koordinaten : in GlobaleRecords.AchsenAusKartenfeldPositiv; Änderung : in GlobaleRecords.AchsenAusKartenfeld;
                            ZusatzYAbstand : in GlobaleDatentypen.Kartenfeld) return GlobaleRecords.AchsenAusKartenfeld with
     Pre => Koordinaten.YAchse in Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and Koordinaten.XAchse in Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
     and ZusatzYAbstand >= 0;
   
   function KoordinatenStadtMitRasseSuchen (RasseExtern : in GlobaleDatentypen.Rassen; Koordinaten : in GlobaleRecords.AchsenAusKartenfeldPositiv) return Integer with
     Pre => Koordinaten.YAchse in Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and Koordinaten.XAchse in Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

   function KoordinatenEinheitMitRasseSuchen (RasseExtern : in GlobaleDatentypen.Rassen; Koordinaten : in GlobaleRecords.AchsenAusKartenfeldPositiv) return Integer with
     Pre => Koordinaten.YAchse in Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and Koordinaten.XAchse in Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
   
   function KoordinatenStadtOhneRasseSuchen (Koordinaten : in GlobaleRecords.AchsenAusKartenfeldPositiv) return GlobaleRecords.RasseUndPlatznummerRecord with
     Pre => Koordinaten.YAchse in Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and Koordinaten.XAchse in Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

   function KoordinatenEinheitOhneRasseSuchen (Koordinaten : in GlobaleRecords.AchsenAusKartenfeldPositiv) return GlobaleRecords.RasseUndPlatznummerRecord with
     Pre => Koordinaten.YAchse in Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and Koordinaten.XAchse in Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
   
   function KartenGrund (Koordinaten : in GlobaleRecords.AchsenAusKartenfeldPositiv) return Boolean with
     Pre => Koordinaten.YAchse in Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and Koordinaten.XAchse in Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
   
private

   Überhang : Integer;

   Kartenwert : GlobaleRecords.AchsenAusKartenfeld;

end SchleifenPruefungen;
