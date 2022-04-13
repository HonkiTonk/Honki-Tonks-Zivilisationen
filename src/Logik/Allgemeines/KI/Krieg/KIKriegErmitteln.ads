pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with EinheitStadtDatentypen;

package KIKriegErmitteln is

   function IstImKrieg
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemDatentypen.Spieler_KI_Enum);

   function KriegAnfangen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Rassen_Enum
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemDatentypen.Spieler_KI_Enum);

private

   RasseGewählt : SystemDatentypen.Rassen_Enum;
   Bewertung : EinheitStadtDatentypen.ProduktionFeld;

   type BewertungenArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range) of EinheitStadtDatentypen.ProduktionFeld;
   Bewertungen : BewertungenArray;

   NotwendigeBewertung : constant BewertungenArray := (
                                                       SystemDatentypen.Menschen_Enum         => 10,
                                                       SystemDatentypen.Kasrodiah_Enum        => 10,
                                                       SystemDatentypen.Lasupin_Enum          => 10,
                                                       SystemDatentypen.Lamustra_Enum         => 10,
                                                       SystemDatentypen.Manuky_Enum           => 10,
                                                       SystemDatentypen.Suroka_Enum           => 10,
                                                       SystemDatentypen.Pryolon_Enum          => 10,
                                                       SystemDatentypen.Talbidahr_Enum        => 10,
                                                       SystemDatentypen.Moru_Phisihl_Enum     => 10,
                                                       SystemDatentypen.Larinos_Lotaris_Enum  => 10,
                                                       SystemDatentypen.Carupex_Enum          => 10,
                                                       SystemDatentypen.Alary_Enum            => 10,
                                                       SystemDatentypen.Tesorahn_Enum         => 10,
                                                       SystemDatentypen.Natries_Zermanis_Enum => 10,
                                                       SystemDatentypen.Tridatus_Enum         => 10,
                                                       SystemDatentypen.Senelari_Enum         => 10,
                                                       SystemDatentypen.Aspari_2_Enum         => 10,
                                                       SystemDatentypen.Ekropa_Enum           => 0
                                                      );

   function StärkeVerhältnisErmitteln
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Rassen_Enum
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = SystemDatentypen.Spieler_KI_Enum
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) /= SystemDatentypen.Leer_Spieler_Enum
          and
            EigeneRasseExtern /= FremdeRasseExtern);

end KIKriegErmitteln;
