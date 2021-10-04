pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package KIKriegErmitteln is

   function IstImKrieg
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SonstigeDatentypen.Spieler_KI);

   function KriegAnfangen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return SonstigeDatentypen.Rassen_Enum
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SonstigeDatentypen.Spieler_KI);

private

   RasseGewählt : SonstigeDatentypen.Rassen_Enum;
   Bewertung : EinheitStadtDatentypen.ProduktionFeld;

   type BewertungenArray is array (SonstigeDatentypen.Rassen_Verwendet_Enum'Range) of EinheitStadtDatentypen.ProduktionFeld;
   Bewertungen : BewertungenArray;

   NotwendigeBewertung : constant BewertungenArray := (
                                                       SonstigeDatentypen.Menschen         => 10,
                                                       SonstigeDatentypen.Kasrodiah        => 10,
                                                       SonstigeDatentypen.Lasupin          => 10,
                                                       SonstigeDatentypen.Lamustra         => 10,
                                                       SonstigeDatentypen.Manuky           => 10,
                                                       SonstigeDatentypen.Suroka           => 10,
                                                       SonstigeDatentypen.Pryolon          => 10,
                                                       SonstigeDatentypen.Talbidahr        => 10,
                                                       SonstigeDatentypen.Moru_Phisihl     => 10,
                                                       SonstigeDatentypen.Larinos_Lotaris  => 10,
                                                       SonstigeDatentypen.Carupex          => 10,
                                                       SonstigeDatentypen.Alary            => 10,
                                                       SonstigeDatentypen.Tesorahn         => 10,
                                                       SonstigeDatentypen.Natries_Zermanis => 10,
                                                       SonstigeDatentypen.Tridatus         => 10,
                                                       SonstigeDatentypen.Senelari         => 10,
                                                       SonstigeDatentypen.Aspari_2         => 10,
                                                       SonstigeDatentypen.Ekropa           => 0
                                                      );

   function StärkeVerhältnisErmitteln
     (EigeneRasseExtern, FremdeRasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return SonstigeDatentypen.Rassen_Enum
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = SonstigeDatentypen.Spieler_KI
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) /= GlobaleDatentypen.Leer
          and
            EigeneRasseExtern /= FremdeRasseExtern);

end KIKriegErmitteln;
