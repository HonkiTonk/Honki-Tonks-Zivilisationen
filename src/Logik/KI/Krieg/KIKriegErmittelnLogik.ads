with SpeziesDatentypen;

private with ProduktionDatentypen;

with LeseSpeziesbelegung;

package KIKriegErmittelnLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   function IstImKrieg
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              );

   function KriegAnfangen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return SpeziesDatentypen.Spezies_Enum
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              );

private
   use type SpeziesDatentypen.Spezies_Enum;

   SpeziesGewählt : SpeziesDatentypen.Spezies_Enum;
   Bewertung : ProduktionDatentypen.Feldproduktion;

   type BewertungenArray is array (SpeziesDatentypen.Spezies_Verwendet_Enum'Range) of ProduktionDatentypen.Feldproduktion;
   Bewertungen : BewertungenArray;

   NotwendigeBewertung : constant BewertungenArray := (
                                                       SpeziesDatentypen.Menschen_Enum         => 10,
                                                       SpeziesDatentypen.Kasrodiah_Enum        => 10,
                                                       SpeziesDatentypen.Lasupin_Enum          => 10,
                                                       SpeziesDatentypen.Lamustra_Enum         => 10,
                                                       SpeziesDatentypen.Manuky_Enum           => 10,
                                                       SpeziesDatentypen.Suroka_Enum           => 10,
                                                       SpeziesDatentypen.Pryolon_Enum          => 10,
                                                       SpeziesDatentypen.Talbidahr_Enum        => 10,
                                                       SpeziesDatentypen.Moru_Phisihl_Enum     => 10,
                                                       SpeziesDatentypen.Larinos_Lotaris_Enum  => 10,
                                                       SpeziesDatentypen.Carupex_Enum          => 10,
                                                       SpeziesDatentypen.Alary_Enum            => 10,
                                                       SpeziesDatentypen.Tesorahn_Enum         => 10,
                                                       SpeziesDatentypen.Natries_Zermanis_Enum => 10,
                                                       SpeziesDatentypen.Tridatus_Enum         => 10,
                                                       SpeziesDatentypen.Senelari_Enum         => 10,
                                                       SpeziesDatentypen.Aspari_2_Enum         => 10,
                                                       SpeziesDatentypen.Ekropa_Enum           => 0
                                                      );

   function StärkeVerhältnisErmitteln
     (EigeneSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      FremdeSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return SpeziesDatentypen.Spezies_Enum
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EigeneSpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => FremdeSpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 EigeneSpeziesExtern /= FremdeSpeziesExtern
              );

end KIKriegErmittelnLogik;
