pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;
with RassenDatentypen; use RassenDatentypen;
with SonstigeVariablen;
with ProduktionDatentypen;

package DiplomatischerZustand is

   type SympathieGrenzenArray is array (SystemDatentypen.Status_Untereinander_Bekannt_Enum'Range) of ProduktionDatentypen.Feldproduktion;
   SympathieGrenzen : constant SympathieGrenzenArray := (
                                                         SystemDatentypen.Neutral_Enum           => 50,
                                                         SystemDatentypen.Nichtangriffspakt_Enum => ProduktionDatentypen.Feldproduktion'Last,
                                                         SystemDatentypen.Krieg_Enum             => 0
                                                        );

   procedure DiplomatischenStatusÄndern
     (RasseEinsExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      NeuerStatusExtern : in SystemDatentypen.Status_Untereinander_Enum)
     with
       Pre => (
                 RasseEinsExtern /= RasseZweiExtern
               and
                 SonstigeVariablen.RassenImSpiel (RasseEinsExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SonstigeVariablen.RassenImSpiel (RasseZweiExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

   procedure SympathieÄndern
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ÄnderungExtern : in ProduktionDatentypen.Feldproduktion)
     with
       Pre => (
                 EigeneRasseExtern /= FremdeRasseExtern
               and
                 SonstigeVariablen.RassenImSpiel (EigeneRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SonstigeVariablen.RassenImSpiel (FremdeRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

   procedure VergangeneZeitÄndern
     (RasseEinsExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 RasseEinsExtern /= RasseZweiExtern
               and
                 SonstigeVariablen.RassenImSpiel (RasseEinsExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SonstigeVariablen.RassenImSpiel (RasseZweiExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );



   function GegnerAngreifen
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      GegnerischeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre => (
                 EigeneRasseExtern /= GegnerischeRasseExtern
               and
                 SonstigeVariablen.RassenImSpiel (EigeneRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SonstigeVariablen.RassenImSpiel (GegnerischeRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

   function DiplomatischenStatusPrüfen
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Status_Untereinander_Enum
     with
       Pre => (
                 EigeneRasseExtern /= FremdeRasseExtern
               and
                 SonstigeVariablen.RassenImSpiel (EigeneRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SonstigeVariablen.RassenImSpiel (FremdeRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

   function DiplomatischerStatusLetzteÄnderung
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Natural
     with
       Pre => (
                 EigeneRasseExtern /= FremdeRasseExtern
               and
                 SonstigeVariablen.RassenImSpiel (EigeneRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SonstigeVariablen.RassenImSpiel (FremdeRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

   function AktuelleSympathie
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.Feldproduktion
     with
       Pre => (
                 EigeneRasseExtern /= FremdeRasseExtern
               and
                 SonstigeVariablen.RassenImSpiel (EigeneRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SonstigeVariablen.RassenImSpiel (FremdeRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

end DiplomatischerZustand;
