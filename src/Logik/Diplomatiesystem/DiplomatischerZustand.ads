pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with EinheitStadtDatentypen;

package DiplomatischerZustand is

   type SympathieGrenzenArray is array (SystemDatentypen.Status_Untereinander_Bekannt_Enum'Range) of EinheitStadtDatentypen.ProduktionFeld;
   SympathieGrenzen : constant SympathieGrenzenArray := (
                                                         SystemDatentypen.Neutral_Enum           => 50,
                                                         SystemDatentypen.Nichtangriffspakt_Enum => EinheitStadtDatentypen.ProduktionFeld'Last,
                                                         SystemDatentypen.Krieg_Enum             => 0
                                                        );

   procedure DiplomatischenStatusÄndern
     (RasseEinsExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      NeuerStatusExtern : in SystemDatentypen.Status_Untereinander_Enum)
     with
       Pre =>
         (RasseEinsExtern /= RasseZweiExtern
          and
            GlobaleVariablen.RassenImSpiel (RasseEinsExtern) /= SystemDatentypen.Leer_Spieler_Enum
          and
            GlobaleVariablen.RassenImSpiel (RasseZweiExtern) /= SystemDatentypen.Leer_Spieler_Enum);

   procedure SympathieÄndern
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      ÄnderungExtern : in EinheitStadtDatentypen.ProduktionFeld)
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) /= SystemDatentypen.Leer_Spieler_Enum
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) /= SystemDatentypen.Leer_Spieler_Enum);

   procedure VergangeneZeitÄndern
     (RasseEinsExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (RasseEinsExtern /= RasseZweiExtern
          and
            GlobaleVariablen.RassenImSpiel (RasseEinsExtern) /= SystemDatentypen.Leer_Spieler_Enum
          and
            GlobaleVariablen.RassenImSpiel (RasseZweiExtern) /= SystemDatentypen.Leer_Spieler_Enum);



   function GegnerAngreifen
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      GegnerischeRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre =>
         (EigeneRasseExtern /= GegnerischeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) /= SystemDatentypen.Leer_Spieler_Enum
          and
            GlobaleVariablen.RassenImSpiel (GegnerischeRasseExtern) /= SystemDatentypen.Leer_Spieler_Enum);

   function DiplomatischenStatusPrüfen
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Status_Untereinander_Enum
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) /= SystemDatentypen.Leer_Spieler_Enum
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) /= SystemDatentypen.Leer_Spieler_Enum);

   function DiplomatischerStatusLetzteÄnderung
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Natural
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) /= SystemDatentypen.Leer_Spieler_Enum
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) /= SystemDatentypen.Leer_Spieler_Enum);

   function AktuelleSympathie
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) /= SystemDatentypen.Leer_Spieler_Enum
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) /= SystemDatentypen.Leer_Spieler_Enum);

end DiplomatischerZustand;
