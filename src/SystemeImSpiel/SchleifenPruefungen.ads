with GlobaleVariablen, Karten, GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen;

package SchleifenPruefungen is

   RückgabeWert : constant Integer := -1_000_000;
   
   function KartenUmgebung (YKoordinate, XKoordinate, YÄnderung, XÄnderung, ZusatzYAbstand : in GlobaleDatentypen.Kartenfeld) return GlobaleRecords.AchsenAusKartenfeld with
     Pre => YKoordinate <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XKoordinate <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
   
   function KoordinatenStadtMitRasseSuchen (RasseExtern : in GlobaleDatentypen.Rassen; YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) return Integer with
     Pre => YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

   function KoordinatenEinheitMitRasseSuchen (RasseExtern : in GlobaleDatentypen.Rassen; YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) return Integer with
     Pre => YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
   
   function KoordinatenStadtOhneRasseSuchen (YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) return GlobaleRecords.RasseUndPlatznummerRecord with
     Pre => YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

   function KoordinatenEinheitOhneRasseSuchen (YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) return GlobaleRecords.RasseUndPlatznummerRecord with
     Pre => YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
   
   function KartenGrund (Ebene : in GlobaleDatentypen.Ebene; YKoordinate, XKoordinate : in GlobaleDatentypen.KartenfeldPositiv) return Boolean with
     Pre => Ebene > -3 and YKoordinate <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XKoordinate <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
   
private

   Überhang : Integer;

   Kartenwert : GlobaleRecords.AchsenAusKartenfeld;

end SchleifenPruefungen;
