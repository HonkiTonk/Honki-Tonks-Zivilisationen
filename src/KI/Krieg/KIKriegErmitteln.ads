pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package KIKriegErmitteln is

   function IstImKrieg
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = GlobaleDatentypen.Spieler_KI);

   function KriegAnfangen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.Rassen_Enum
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = GlobaleDatentypen.Spieler_KI);

private

   RasseGewählt : GlobaleDatentypen.Rassen_Enum;
   Bewertung : GlobaleDatentypen.ProduktionFeld;

   type BewertungenArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range) of GlobaleDatentypen.ProduktionFeld;
   Bewertungen : BewertungenArray;

   NotwendigeBewertung : constant BewertungenArray := (
                                                       GlobaleDatentypen.Menschen         => 10,
                                                       GlobaleDatentypen.Kasrodiah        => 10,
                                                       GlobaleDatentypen.Lasupin          => 10,
                                                       GlobaleDatentypen.Lamustra         => 10,
                                                       GlobaleDatentypen.Manuky           => 10,
                                                       GlobaleDatentypen.Suroka           => 10,
                                                       GlobaleDatentypen.Pryolon          => 10,
                                                       GlobaleDatentypen.Talbidahr        => 10,
                                                       GlobaleDatentypen.Moru_Phisihl     => 10,
                                                       GlobaleDatentypen.Larinos_Lotaris  => 10,
                                                       GlobaleDatentypen.Carupex          => 10,
                                                       GlobaleDatentypen.Alary            => 10,
                                                       GlobaleDatentypen.Tesorahn         => 10,
                                                       GlobaleDatentypen.Natries_Zermanis => 10,
                                                       GlobaleDatentypen.Tridatus         => 10,
                                                       GlobaleDatentypen.Senelari         => 10,
                                                       GlobaleDatentypen.Aspari_2         => 10,
                                                       GlobaleDatentypen.Ekropa           => 0
                                                      );

   function StärkeVerhältnisErmitteln
     (EigeneRasseExtern, FremdeRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.Rassen_Enum
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = GlobaleDatentypen.Spieler_KI
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) /= GlobaleDatentypen.Leer
          and
            EigeneRasseExtern /= FremdeRasseExtern);

end KIKriegErmitteln;
