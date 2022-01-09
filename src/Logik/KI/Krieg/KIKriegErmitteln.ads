pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with EinheitStadtDatentypen;


package KIKriegErmitteln is

   function IstImKrieg
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemDatentypen.Spieler_KI);

   function KriegAnfangen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Rassen_Enum
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemDatentypen.Spieler_KI);

private

   RasseGewählt : SystemDatentypen.Rassen_Enum;
   Bewertung : EinheitStadtDatentypen.ProduktionFeld;

   type BewertungenArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range) of EinheitStadtDatentypen.ProduktionFeld;
   Bewertungen : BewertungenArray;

   NotwendigeBewertung : constant BewertungenArray := (
                                                       SystemDatentypen.Menschen         => 10,
                                                       SystemDatentypen.Kasrodiah        => 10,
                                                       SystemDatentypen.Lasupin          => 10,
                                                       SystemDatentypen.Lamustra         => 10,
                                                       SystemDatentypen.Manuky           => 10,
                                                       SystemDatentypen.Suroka           => 10,
                                                       SystemDatentypen.Pryolon          => 10,
                                                       SystemDatentypen.Talbidahr        => 10,
                                                       SystemDatentypen.Moru_Phisihl     => 10,
                                                       SystemDatentypen.Larinos_Lotaris  => 10,
                                                       SystemDatentypen.Carupex          => 10,
                                                       SystemDatentypen.Alary            => 10,
                                                       SystemDatentypen.Tesorahn         => 10,
                                                       SystemDatentypen.Natries_Zermanis => 10,
                                                       SystemDatentypen.Tridatus         => 10,
                                                       SystemDatentypen.Senelari         => 10,
                                                       SystemDatentypen.Aspari_2         => 10,
                                                       SystemDatentypen.Ekropa           => 0
                                                      );

   function StärkeVerhältnisErmitteln
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Rassen_Enum
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = SystemDatentypen.Spieler_KI
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) /= SystemDatentypen.Leer
          and
            EigeneRasseExtern /= FremdeRasseExtern);

end KIKriegErmitteln;
