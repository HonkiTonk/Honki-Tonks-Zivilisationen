with GlobaleVariablen, Karten, GlobaleDatentypen;
use GlobaleDatentypen;

package SchleifenPruefungen is

   function KartenUmgebung (YKoordinate, XKoordinate : in GlobaleDatentypen.Kartenfeld; YÄnderung, XÄnderung, ZusatzYAbstand : in Integer) return GlobaleDatentypen.RückgabewertFürSchleifenPrüfungRecord;
   function KoordinatenStadtMitRasseSuchen (Rasse : in Integer; YAchse, XAchse : in GlobaleDatentypen.Kartenfeld) return Integer;
   function KoordinatenEinheitMitRasseSuchen (Rasse : in Integer; YAchse, XAchse : in GlobaleDatentypen.Kartenfeld) return Integer;
   function KoordinatenStadtOhneRasseSuchen (YAchse, XAchse : in GlobaleDatentypen.Kartenfeld) return GlobaleDatentypen.RasseUndPlatznummerRecord;
   function KoordinatenEinheitOhneRasseSuchen (YAchse, XAchse : in GlobaleDatentypen.Kartenfeld) return GlobaleDatentypen.RasseUndPlatznummerRecord;
   
private

   Überhang : Integer;

end SchleifenPruefungen;
