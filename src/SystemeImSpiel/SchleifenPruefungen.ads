with GlobaleVariablen, Karten, GlobaleDatentypen;

package SchleifenPruefungen is

   function KartenUmgebung (YKoordinate, XKoordinate, YÄnderung, XÄnderung : in Integer) return GlobaleDatentypen.RückgabewertFürSchleifenPrüfungRecord;
   function KoordinatenStadtMitRasseSuchen (Rasse, YAchse, XAchse : in Integer) return Integer;
   function KoordinatenEinheitMitRasseSuchen (Rasse, YAchse, XAchse : in Integer) return Integer;
   function KoordinatenStadtOhneRasseSuchen (YAchse, XAchse : in Integer) return GlobaleDatentypen.RasseUndPlatznummerRecord;
   function KoordinatenEinheitOhneRasseSuchen (YAchse, XAchse : in Integer) return GlobaleDatentypen.RasseUndPlatznummerRecord;
   
private

   Überhang : Integer;

end SchleifenPruefungen;
