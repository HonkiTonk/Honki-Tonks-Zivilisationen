with RassenDatentypen;
with DiplomatieDatentypen;

with LeseRassenbelegung;

package DiplomatischerZustandLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   use type RassenDatentypen.Rassen_Enum;

   type SympathieGrenzenArray is array (DiplomatieDatentypen.Status_Untereinander_Bekannt_Enum'Range) of DiplomatieDatentypen.Meinung;
   SympathieGrenzen : constant SympathieGrenzenArray := (
                                                         DiplomatieDatentypen.Neutral_Enum           => 50,
                                                         DiplomatieDatentypen.Nichtangriffspakt_Enum => DiplomatieDatentypen.Meinung'Last,
                                                         DiplomatieDatentypen.Krieg_Enum             => 0
                                                        );

   procedure DiplomatischenStatusÄndern
     (RasseEinsExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      NeuerStatusExtern : in DiplomatieDatentypen.Status_Untereinander_Enum)
     with
       Pre => (
                 RasseEinsExtern /= RasseZweiExtern
               and
                 LeseRassenbelegung.Belegung (RasseExtern => RasseEinsExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 LeseRassenbelegung.Belegung (RasseExtern => RasseZweiExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

   function GegnerAngreifen
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      GegnerischeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre => (
                 EigeneRasseExtern /= GegnerischeRasseExtern
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EigeneRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 LeseRassenbelegung.Belegung (RasseExtern => GegnerischeRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

end DiplomatischerZustandLogik;
