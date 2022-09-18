pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;
with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with ForschungenDatentypen;
with StadtRecords;
with ProduktionDatentypen;

private with KartenDatentypen;

package StadtumgebungsbereichFestlegenLogik is
   
   type TechnologieUmgebungsgrößeArray is array (SystemDatentypen.Anfang_Ende_Enum'Range, RassenDatentypen.Rassen_Verwendet_Enum'Range) of ForschungenDatentypen.ForschungID;
   TechnologieUmgebungsgröße : constant TechnologieUmgebungsgrößeArray := (
                                                                               SystemDatentypen.Anfangswert_Enum =>
                                                                                 (
                                                                                  RassenDatentypen.Menschen_Enum         => 19,
                                                                                  RassenDatentypen.Kasrodiah_Enum        => 19,
                                                                                  RassenDatentypen.Lasupin_Enum          => 19,
                                                                                  RassenDatentypen.Lamustra_Enum         => 19,
                                                                                  RassenDatentypen.Manuky_Enum           => 19,
                                                                                  RassenDatentypen.Suroka_Enum           => 19,
                                                                                  RassenDatentypen.Pryolon_Enum          => 19,
                                                                                  RassenDatentypen.Moru_Phisihl_Enum     => 19,
                                                                                  RassenDatentypen.Larinos_Lotaris_Enum  => 19,
                                                                                  RassenDatentypen.Carupex_Enum          => 19,
                                                                                  RassenDatentypen.Alary_Enum            => 19,
                                                                                  RassenDatentypen.Natries_Zermanis_Enum => 19,
                                                                                  RassenDatentypen.Tridatus_Enum         => 19,
                                                                                  RassenDatentypen.Senelari_Enum         => 19,
                                                                                  RassenDatentypen.Aspari_2_Enum         => 19,
                                                                                  RassenDatentypen.Ekropa_Enum           => 19,
                                                                                  RassenDatentypen.Tesorahn_Enum         => 19,
                                                                                  RassenDatentypen.Talbidahr_Enum        => 19
                                                                                 ),
                                                                               
                                                                               SystemDatentypen.Endwert_Enum =>
                                                                                 (
                                                                                  RassenDatentypen.Menschen_Enum         => 43,
                                                                                  RassenDatentypen.Kasrodiah_Enum        => 43,
                                                                                  RassenDatentypen.Lasupin_Enum          => 43,
                                                                                  RassenDatentypen.Lamustra_Enum         => 43,
                                                                                  RassenDatentypen.Manuky_Enum           => 43,
                                                                                  RassenDatentypen.Suroka_Enum           => 43,
                                                                                  RassenDatentypen.Pryolon_Enum          => 43,
                                                                                  RassenDatentypen.Moru_Phisihl_Enum     => 43,
                                                                                  RassenDatentypen.Larinos_Lotaris_Enum  => 43,
                                                                                  RassenDatentypen.Carupex_Enum          => 43,
                                                                                  RassenDatentypen.Alary_Enum            => 43,
                                                                                  RassenDatentypen.Natries_Zermanis_Enum => 43,
                                                                                  RassenDatentypen.Tridatus_Enum         => 43,
                                                                                  RassenDatentypen.Senelari_Enum         => 43,
                                                                                  RassenDatentypen.Aspari_2_Enum         => 43,
                                                                                  RassenDatentypen.Ekropa_Enum           => 43,
                                                                                  RassenDatentypen.Tesorahn_Enum         => 43,
                                                                                  RassenDatentypen.Talbidahr_Enum        => 43
                                                                                 )
                                                                              );

   procedure StadtumgebungsbereichFestlegen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
private
   
   Umgebung : KartenDatentypen.UmgebungsbereichDrei;
   
   Einwohner : ProduktionDatentypen.Einwohner;
   
   procedure StadtumgebungErmitteln
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

end StadtumgebungsbereichFestlegenLogik;
