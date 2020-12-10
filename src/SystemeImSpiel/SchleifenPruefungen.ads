with GlobaleVariablen, Karten, GlobaleDatentypen;
use GlobaleDatentypen;

package SchleifenPruefungen is

   RückgabeWert : constant Integer := -1_000_000;

   function KartenUmgebung (YKoordinate, XKoordinate, YÄnderung, XÄnderung, ZusatzYAbstand : in GlobaleDatentypen.Kartenfeld) return GlobaleDatentypen.YWertXWertAusKartenfeld;
   function KoordinatenStadtMitRasseSuchen (Rasse : in Integer; YAchse, XAchse : in GlobaleDatentypen.Kartenfeld) return Integer;
   function KoordinatenEinheitMitRasseSuchen (Rasse : in Integer; YAchse, XAchse : in GlobaleDatentypen.Kartenfeld) return Integer;
   function KoordinatenStadtOhneRasseSuchen (YAchse, XAchse : in GlobaleDatentypen.Kartenfeld) return GlobaleDatentypen.RasseUndPlatznummerRecord;
   function KoordinatenEinheitOhneRasseSuchen (YAchse, XAchse : in GlobaleDatentypen.Kartenfeld) return GlobaleDatentypen.RasseUndPlatznummerRecord;
   function KartenGrund (Ebene : in GlobaleDatentypen.Ebene; YKoordinate, XKoordinate : in GlobaleDatentypen.Kartenfeld) return Boolean;
   
private

   Überhang : Integer;

end SchleifenPruefungen;
