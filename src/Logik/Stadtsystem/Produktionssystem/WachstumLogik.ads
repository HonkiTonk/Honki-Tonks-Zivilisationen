with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;

private with ProduktionDatentypen;
private with StadtRecords;

package WachstumLogik is
   -- pragma Elaborate_Body; äöü
   
   procedure StadtWachstum;
   
   procedure WachstumWichtiges
     (RasseExtern : in RassenDatentypen.Rassen_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
private
   
   WachstumSchrumpfung : Boolean;
   
   VorhandeneEinwohner : ProduktionDatentypen.Einwohner;
   
   VorhandeneNahrung : ProduktionDatentypen.Stadtproduktion;
   
   Bauprojekt : StadtRecords.BauprojektRecord;
   
   type EinwohnerwachstumArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of ProduktionDatentypen.Feldproduktion;
   GrundwertEinwohnerwachstum : constant EinwohnerwachstumArray := (
                                                                    RassenDatentypen.Menschen_Enum         => 10,
                                                                    RassenDatentypen.Kasrodiah_Enum        => 10,
                                                                    RassenDatentypen.Lasupin_Enum          => 10,
                                                                    RassenDatentypen.Lamustra_Enum         => 10,
                                                                    RassenDatentypen.Manuky_Enum           => 10,
                                                                    RassenDatentypen.Suroka_Enum           => 10,
                                                                    RassenDatentypen.Pryolon_Enum          => 10,
                                                                    RassenDatentypen.Moru_Phisihl_Enum     => 10,
                                                                    RassenDatentypen.Larinos_Lotaris_Enum  => 10,
                                                                    RassenDatentypen.Carupex_Enum          => 10,
                                                                    RassenDatentypen.Alary_Enum            => 10,
                                                                    RassenDatentypen.Natries_Zermanis_Enum => 10,
                                                                    RassenDatentypen.Tridatus_Enum         => 10,
                                                                    RassenDatentypen.Senelari_Enum         => 10,
                                                                    RassenDatentypen.Aspari_2_Enum         => 10,
                                                                    RassenDatentypen.Ekropa_Enum           => 10,
                                                                    RassenDatentypen.Tesorahn_Enum         => 10,
                                                                    RassenDatentypen.Talbidahr_Enum        => 10
                                                                   );
   
   MultiplikatorEinwohnerwachstum : constant EinwohnerwachstumArray := (
                                                                        RassenDatentypen.Menschen_Enum         => 5,
                                                                        RassenDatentypen.Kasrodiah_Enum        => 5,
                                                                        RassenDatentypen.Lasupin_Enum          => 5,
                                                                        RassenDatentypen.Lamustra_Enum         => 5,
                                                                        RassenDatentypen.Manuky_Enum           => 5,
                                                                        RassenDatentypen.Suroka_Enum           => 5,
                                                                        RassenDatentypen.Pryolon_Enum          => 5,
                                                                        RassenDatentypen.Moru_Phisihl_Enum     => 5,
                                                                        RassenDatentypen.Larinos_Lotaris_Enum  => 5,
                                                                        RassenDatentypen.Carupex_Enum          => 5,
                                                                        RassenDatentypen.Alary_Enum            => 5,
                                                                        RassenDatentypen.Natries_Zermanis_Enum => 5,
                                                                        RassenDatentypen.Tridatus_Enum         => 5,
                                                                        RassenDatentypen.Senelari_Enum         => 5,
                                                                        RassenDatentypen.Aspari_2_Enum         => 5,
                                                                        RassenDatentypen.Ekropa_Enum           => 5,
                                                                        RassenDatentypen.Tesorahn_Enum         => 5,
                                                                        RassenDatentypen.Talbidahr_Enum        => 5
                                                                       );
   
   procedure WachstumEinwohner
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

   procedure WachstumProduktion
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure WachstumsratenBerechnen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure EinwohnerÄnderung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      WachstumSchrumpfungExtern : in Boolean)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   
   
   function BenötigteNahrung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return ProduktionDatentypen.Stadtproduktion
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function NeuerEinwohner
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Boolean
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

end WachstumLogik;
