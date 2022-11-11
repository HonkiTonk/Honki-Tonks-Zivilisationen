with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with DiplomatieDatentypen;

package DiplomatischerZustandLogik is
   pragma Elaborate_Body;

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
                 SpielVariablen.Rassenbelegung (RasseEinsExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SpielVariablen.Rassenbelegung (RasseZweiExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

   procedure SympathieÄndern
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ÄnderungExtern : in DiplomatieDatentypen.Meinung)
     with
       Pre => (
                 EigeneRasseExtern /= FremdeRasseExtern
               and
                 SpielVariablen.Rassenbelegung (EigeneRasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SpielVariablen.Rassenbelegung (FremdeRasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

   procedure VergangeneZeitÄndern
     (RasseEinsExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 RasseEinsExtern /= RasseZweiExtern
               and
                 SpielVariablen.Rassenbelegung (RasseEinsExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SpielVariablen.Rassenbelegung (RasseZweiExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );



   function GegnerAngreifen
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      GegnerischeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre => (
                 EigeneRasseExtern /= GegnerischeRasseExtern
               and
                 SpielVariablen.Rassenbelegung (EigeneRasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SpielVariablen.Rassenbelegung (GegnerischeRasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

   function DiplomatischenStatusPrüfen
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return DiplomatieDatentypen.Status_Untereinander_Enum
     with
       Pre => (
                 EigeneRasseExtern /= FremdeRasseExtern
               and
                 SpielVariablen.Rassenbelegung (EigeneRasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SpielVariablen.Rassenbelegung (FremdeRasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

   function DiplomatischerStatusLetzteÄnderung
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Natural
     with
       Pre => (
                 EigeneRasseExtern /= FremdeRasseExtern
               and
                 SpielVariablen.Rassenbelegung (EigeneRasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SpielVariablen.Rassenbelegung (FremdeRasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

   function AktuelleSympathie
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return DiplomatieDatentypen.Meinung
     with
       Pre => (
                 EigeneRasseExtern /= FremdeRasseExtern
               and
                 SpielVariablen.Rassenbelegung (EigeneRasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SpielVariablen.Rassenbelegung (FremdeRasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

end DiplomatischerZustandLogik;
