with SpeziesDatentypen;
with StadtRecords;
with StadtKonstanten;

private with ProduktionDatentypen;

with LeseSpeziesbelegung;
with LeseGrenzen;

package StadtbewohnerwachstumLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure Einwohner
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
private
   
   WachstumSchrumpfung : Boolean;
   
   VorhandeneEinwohner : ProduktionDatentypen.Einwohner;
   
   VorhandeneNahrung : ProduktionDatentypen.Stadtproduktion;
   ProduzierteNahrung : ProduktionDatentypen.Stadtproduktion;
   
   type EinwohnerwachstumArray is array (SpeziesDatentypen.Spezies_Verwendet_Enum'Range) of ProduktionDatentypen.Feldproduktion;
   GrundwertEinwohnerwachstum : constant EinwohnerwachstumArray := (
                                                                    SpeziesDatentypen.Menschen_Enum         => 10,
                                                                    SpeziesDatentypen.Kasrodiah_Enum        => 10,
                                                                    SpeziesDatentypen.Lasupin_Enum          => 10,
                                                                    SpeziesDatentypen.Lamustra_Enum         => 10,
                                                                    SpeziesDatentypen.Manuky_Enum           => 10,
                                                                    SpeziesDatentypen.Suroka_Enum           => 10,
                                                                    SpeziesDatentypen.Pryolon_Enum          => 10,
                                                                    SpeziesDatentypen.Moru_Phisihl_Enum     => 10,
                                                                    SpeziesDatentypen.Larinos_Lotaris_Enum  => 10,
                                                                    SpeziesDatentypen.Carupex_Enum          => 10,
                                                                    SpeziesDatentypen.Alary_Enum            => 10,
                                                                    SpeziesDatentypen.Natries_Zermanis_Enum => 10,
                                                                    SpeziesDatentypen.Tridatus_Enum         => 10,
                                                                    SpeziesDatentypen.Senelari_Enum         => 10,
                                                                    SpeziesDatentypen.Aspari_2_Enum         => 10,
                                                                    SpeziesDatentypen.Ekropa_Enum           => 10,
                                                                    SpeziesDatentypen.Tesorahn_Enum         => 10,
                                                                    SpeziesDatentypen.Talbidahr_Enum        => 10
                                                                   );
   
   MultiplikatorEinwohnerwachstum : constant EinwohnerwachstumArray := (
                                                                        SpeziesDatentypen.Menschen_Enum         => 5,
                                                                        SpeziesDatentypen.Kasrodiah_Enum        => 5,
                                                                        SpeziesDatentypen.Lasupin_Enum          => 5,
                                                                        SpeziesDatentypen.Lamustra_Enum         => 5,
                                                                        SpeziesDatentypen.Manuky_Enum           => 5,
                                                                        SpeziesDatentypen.Suroka_Enum           => 5,
                                                                        SpeziesDatentypen.Pryolon_Enum          => 5,
                                                                        SpeziesDatentypen.Moru_Phisihl_Enum     => 5,
                                                                        SpeziesDatentypen.Larinos_Lotaris_Enum  => 5,
                                                                        SpeziesDatentypen.Carupex_Enum          => 5,
                                                                        SpeziesDatentypen.Alary_Enum            => 5,
                                                                        SpeziesDatentypen.Natries_Zermanis_Enum => 5,
                                                                        SpeziesDatentypen.Tridatus_Enum         => 5,
                                                                        SpeziesDatentypen.Senelari_Enum         => 5,
                                                                        SpeziesDatentypen.Aspari_2_Enum         => 5,
                                                                        SpeziesDatentypen.Ekropa_Enum           => 5,
                                                                        SpeziesDatentypen.Tesorahn_Enum         => 5,
                                                                        SpeziesDatentypen.Talbidahr_Enum        => 5
                                                                       );
            
   procedure EinwohnerÄnderung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      WachstumSchrumpfungExtern : in Boolean)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   
   
   function BenötigteNahrung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return ProduktionDatentypen.Stadtproduktion
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function NeuerEinwohner
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return Boolean
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end StadtbewohnerwachstumLogik;
