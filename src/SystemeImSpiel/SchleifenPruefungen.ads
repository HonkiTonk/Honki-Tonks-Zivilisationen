with GlobaleVariablen, Karten, GlobaleDatentypen;
use GlobaleDatentypen;

package SchleifenPruefungen is

   RückgabeWert : constant Integer := -1_000_000;
   
   function KartenUmgebung (YKoordinate, XKoordinate, YÄnderung, XÄnderung, ZusatzYAbstand : in GlobaleDatentypen.Kartenfeld) return GlobaleDatentypen.AchsenAusKartenfeld;
   function KoordinatenStadtMitRasseSuchen (RasseExtern : in Integer; YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) return Integer
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;
   function KoordinatenEinheitMitRasseSuchen (RasseExtern : in Integer; YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) return Integer
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;
   function KoordinatenStadtOhneRasseSuchen (YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) return GlobaleDatentypen.RasseUndPlatznummerRecord;
   function KoordinatenEinheitOhneRasseSuchen (YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) return GlobaleDatentypen.RasseUndPlatznummerRecord;
   function KartenGrund (Ebene : in GlobaleDatentypen.Ebene; YKoordinate, XKoordinate : in GlobaleDatentypen.KartenfeldPositiv) return Boolean;
   
private

   Überhang : Integer;

   Kartenwert : GlobaleDatentypen.AchsenAusKartenfeld;

end SchleifenPruefungen;
