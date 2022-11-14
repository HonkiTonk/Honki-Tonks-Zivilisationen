with RassenDatentypen;
with SpielVariablen;

private with ProduktionDatentypen;

package KIKriegErmittelnLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   function IstImKrieg
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.KI_Spieler_Enum
              );

   function KriegAnfangen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RassenDatentypen.Rassen_Enum
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.KI_Spieler_Enum
              );

private
   use type RassenDatentypen.Rassen_Enum;

   RasseGewählt : RassenDatentypen.Rassen_Enum;
   Bewertung : ProduktionDatentypen.Feldproduktion;

   type BewertungenArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of ProduktionDatentypen.Feldproduktion;
   Bewertungen : BewertungenArray;

   NotwendigeBewertung : constant BewertungenArray := (
                                                       RassenDatentypen.Menschen_Enum         => 10,
                                                       RassenDatentypen.Kasrodiah_Enum        => 10,
                                                       RassenDatentypen.Lasupin_Enum          => 10,
                                                       RassenDatentypen.Lamustra_Enum         => 10,
                                                       RassenDatentypen.Manuky_Enum           => 10,
                                                       RassenDatentypen.Suroka_Enum           => 10,
                                                       RassenDatentypen.Pryolon_Enum          => 10,
                                                       RassenDatentypen.Talbidahr_Enum        => 10,
                                                       RassenDatentypen.Moru_Phisihl_Enum     => 10,
                                                       RassenDatentypen.Larinos_Lotaris_Enum  => 10,
                                                       RassenDatentypen.Carupex_Enum          => 10,
                                                       RassenDatentypen.Alary_Enum            => 10,
                                                       RassenDatentypen.Tesorahn_Enum         => 10,
                                                       RassenDatentypen.Natries_Zermanis_Enum => 10,
                                                       RassenDatentypen.Tridatus_Enum         => 10,
                                                       RassenDatentypen.Senelari_Enum         => 10,
                                                       RassenDatentypen.Aspari_2_Enum         => 10,
                                                       RassenDatentypen.Ekropa_Enum           => 0
                                                      );

   function StärkeVerhältnisErmitteln
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RassenDatentypen.Rassen_Enum
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (EigeneRasseExtern).Belegung = RassenDatentypen.KI_Spieler_Enum
               and
                 SpielVariablen.Rassenbelegung (FremdeRasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 EigeneRasseExtern /= FremdeRasseExtern
              );

end KIKriegErmittelnLogik;
