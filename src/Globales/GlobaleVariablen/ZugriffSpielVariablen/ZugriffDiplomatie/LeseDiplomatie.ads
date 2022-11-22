with RassenDatentypen;
with DiplomatieDatentypen;
with SpielRecords;
with ZahlenDatentypen;

with LeseRassenbelegung;

package LeseDiplomatie is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   use type RassenDatentypen.Rassen_Enum;

   function AktuellerZustand
     (RasseEinsExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return DiplomatieDatentypen.Status_Untereinander_Enum
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseEinsExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 LeseRassenbelegung.Belegung (RasseExtern => RasseZweiExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 RasseEinsExtern /= RasseZweiExtern
              );
   
   function AktuelleSympathie
     (RasseEinsExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return DiplomatieDatentypen.Meinung
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseEinsExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 LeseRassenbelegung.Belegung (RasseExtern => RasseZweiExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 RasseEinsExtern /= RasseZweiExtern
              );
   
   function ZeitSeitÄnderung
     (RasseEinsExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ZahlenDatentypen.EigenesNatural
     with
       Pre => (
                LeseRassenbelegung.Belegung (RasseExtern => RasseEinsExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 LeseRassenbelegung.Belegung (RasseExtern => RasseZweiExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 RasseEinsExtern /= RasseZweiExtern
              );
   
   function GanzerEintrag
     (RasseEinsExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return SpielRecords.DiplomatieRecord
     with
       Pre => (
                 RasseEinsExtern /= RasseZweiExtern
              );

end LeseDiplomatie;
