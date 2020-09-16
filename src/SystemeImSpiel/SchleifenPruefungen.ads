with GlobaleVariablen, Karten, ProzedurenListe;

package SchleifenPruefungen is

   type RasseUndPlatznummerRecord is record
      
      Rasse : Integer;
      Platznummer : Integer;
      
   end record;

   procedure KartenUmgebung (Rasse, StadtOderEinheitNummer, YKoordinate, XKoordinate, SchleifenBereich, WelcheProzedur : in Integer);

   function KoordinatenStadtMitRasseSuchen (Rasse, YAchse, XAchse : in Integer) return Integer;
   function KoordinatenEinheitMitRasseSuchen (Rasse, YAchse, XAchse : in Integer) return Integer;
   function KoordinatenStadtOhneRasseSuchen (YAchse, XAchse : in Integer) return RasseUndPlatznummerRecord;
   function KoordinatenEinheitOhneRasseSuchen (YAchse, XAchse : in Integer) return RasseUndPlatznummerRecord;
   
private

   Überhang : Integer;

end SchleifenPruefungen;
