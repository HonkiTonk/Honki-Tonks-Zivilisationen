pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package DiplomatischerZustand is

   type SympathieGrenzenArray is array (GlobaleDatentypen.Status_Untereinander_Bekannt_Enum'Range) of GlobaleDatentypen.ProduktionFeld;
   SympathieGrenzen : constant SympathieGrenzenArray := (
                                                         GlobaleDatentypen.Neutral           => 50,
                                                         GlobaleDatentypen.Nichtangriffspakt => GlobaleDatentypen.ProduktionFeld'Last,
                                                         GlobaleDatentypen.Krieg             => 0
                                                        );

   procedure DiplomatischenStatusÄndern
     (RasseEinsExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      NeuerStatusExtern : in GlobaleDatentypen.Status_Untereinander_Enum)
     with
       Pre =>
         (RasseEinsExtern /= RasseZweiExtern
          and
            GlobaleVariablen.RassenImSpiel (RasseEinsExtern) /= GlobaleDatentypen.Leer
          and
            GlobaleVariablen.RassenImSpiel (RasseZweiExtern) /= GlobaleDatentypen.Leer);

   procedure SympathieÄndern
     (EigeneRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      ÄnderungExtern : in GlobaleDatentypen.ProduktionFeld)
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) /= GlobaleDatentypen.Leer
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) /= GlobaleDatentypen.Leer);

   procedure VergangeneZeitÄndern
     (RasseEinsExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (RasseEinsExtern /= RasseZweiExtern
          and
            GlobaleVariablen.RassenImSpiel (RasseEinsExtern) /= GlobaleDatentypen.Leer
          and
            GlobaleVariablen.RassenImSpiel (RasseZweiExtern) /= GlobaleDatentypen.Leer);



   function GegnerAngreifen
     (EigeneRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      GegnerischeRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre =>
         (EigeneRasseExtern /= GegnerischeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) /= GlobaleDatentypen.Leer
          and
            GlobaleVariablen.RassenImSpiel (GegnerischeRasseExtern) /= GlobaleDatentypen.Leer);

   function DiplomatischenStatusPrüfen
     (EigeneRasseExtern, FremdeRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.Status_Untereinander_Enum
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) /= GlobaleDatentypen.Leer
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) /= GlobaleDatentypen.Leer);

   function DiplomatischerStatusLetzteÄnderung
     (EigeneRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Natural
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) /= GlobaleDatentypen.Leer
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) /= GlobaleDatentypen.Leer);

   function AktuelleSympathie
     (EigeneRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ProduktionFeld
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) /= GlobaleDatentypen.Leer
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) /= GlobaleDatentypen.Leer);

end DiplomatischerZustand;
