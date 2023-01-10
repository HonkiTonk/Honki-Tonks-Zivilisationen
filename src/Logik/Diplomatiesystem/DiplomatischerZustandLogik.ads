with SpeziesDatentypen;
with DiplomatieDatentypen;

with LeseSpeziesbelegung;

package DiplomatischerZustandLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type SpeziesDatentypen.Spezies_Enum;

   type SympathieGrenzenArray is array (DiplomatieDatentypen.Status_Untereinander_Bekannt_Enum'Range) of DiplomatieDatentypen.Meinung;
   SympathieGrenzen : constant SympathieGrenzenArray := (
                                                         DiplomatieDatentypen.Neutral_Enum           => 50,
                                                         DiplomatieDatentypen.Nichtangriffspakt_Enum => DiplomatieDatentypen.Meinung'Last,
                                                         DiplomatieDatentypen.Krieg_Enum             => 0
                                                        );

   procedure DiplomatischenStatusÄndern
     (SpeziesEinsExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      SpeziesZweiExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      NeuerStatusExtern : in DiplomatieDatentypen.Status_Untereinander_Enum)
     with
       Pre => (
                 SpeziesEinsExtern /= SpeziesZweiExtern
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesEinsExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesZweiExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   function GegnerAngreifen
     (EigeneSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      GegnerischeSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Boolean
     with
       Pre => (
                 EigeneSpeziesExtern /= GegnerischeSpeziesExtern
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EigeneSpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => GegnerischeSpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end DiplomatischerZustandLogik;
