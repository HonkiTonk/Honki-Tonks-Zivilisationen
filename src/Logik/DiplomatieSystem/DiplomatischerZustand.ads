pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with EinheitStadtDatentypen;
with SystemKonstanten;

package DiplomatischerZustand is

   type SympathieGrenzenArray is array (SystemDatentypen.Status_Untereinander_Bekannt_Enum'Range) of EinheitStadtDatentypen.ProduktionFeld;
   SympathieGrenzen : constant SympathieGrenzenArray := (
                                                         SystemDatentypen.Neutral           => 50,
                                                         SystemDatentypen.Nichtangriffspakt => EinheitStadtDatentypen.ProduktionFeld'Last,
                                                         SystemDatentypen.Krieg             => 0
                                                        );

   procedure DiplomatischenStatusÄndern
     (RasseEinsExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      NeuerStatusExtern : in SystemDatentypen.Status_Untereinander_Enum)
     with
       Pre =>
         (RasseEinsExtern /= RasseZweiExtern
          and
            GlobaleVariablen.RassenImSpiel (RasseEinsExtern) /= SystemKonstanten.LeerSpielerKonstante
          and
            GlobaleVariablen.RassenImSpiel (RasseZweiExtern) /= SystemKonstanten.LeerSpielerKonstante);

   procedure SympathieÄndern
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      ÄnderungExtern : in EinheitStadtDatentypen.ProduktionFeld)
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) /= SystemKonstanten.LeerSpielerKonstante
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) /= SystemKonstanten.LeerSpielerKonstante);

   procedure VergangeneZeitÄndern
     (RasseEinsExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (RasseEinsExtern /= RasseZweiExtern
          and
            GlobaleVariablen.RassenImSpiel (RasseEinsExtern) /= SystemKonstanten.LeerSpielerKonstante
          and
            GlobaleVariablen.RassenImSpiel (RasseZweiExtern) /= SystemKonstanten.LeerSpielerKonstante);



   function GegnerAngreifen
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      GegnerischeRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre =>
         (EigeneRasseExtern /= GegnerischeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) /= SystemKonstanten.LeerSpielerKonstante
          and
            GlobaleVariablen.RassenImSpiel (GegnerischeRasseExtern) /= SystemKonstanten.LeerSpielerKonstante);

   function DiplomatischenStatusPrüfen
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Status_Untereinander_Enum
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) /= SystemKonstanten.LeerSpielerKonstante
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) /= SystemKonstanten.LeerSpielerKonstante);

   function DiplomatischerStatusLetzteÄnderung
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Natural
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) /= SystemKonstanten.LeerSpielerKonstante
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) /= SystemKonstanten.LeerSpielerKonstante);

   function AktuelleSympathie
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) /= SystemKonstanten.LeerSpielerKonstante
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) /= SystemKonstanten.LeerSpielerKonstante);

end DiplomatischerZustand;
