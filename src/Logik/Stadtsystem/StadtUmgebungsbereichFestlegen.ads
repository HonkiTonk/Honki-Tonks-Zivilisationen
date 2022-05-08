pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;
with RassenDatentypen; use RassenDatentypen;
with EinheitStadtRecords;
with SpielVariablen;
with SonstigeVariablen;
with ForschungenDatentypen;
with KartenDatentypen;

package StadtUmgebungsbereichFestlegen is
   
   type TechnologieUmgebungsgrößeArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, SystemDatentypen.Anfang_Ende_Enum'Range) of ForschungenDatentypen.ForschungID;
   TechnologieUmgebungsgröße : constant TechnologieUmgebungsgrößeArray := (
                                                                               RassenDatentypen.Menschen_Enum =>
                                                                                 (
                                                                                  SystemDatentypen.Anfangswert_Enum => 19,
                                                                                  SystemDatentypen.Endwert_Enum     => 43
                                                                                 ),
                                                                                             
                                                                               RassenDatentypen.Kasrodiah_Enum =>
                                                                                 (
                                                                                  SystemDatentypen.Anfangswert_Enum => 19,
                                                                                  SystemDatentypen.Endwert_Enum     => 43
                                                                                 ),
            
                                                                               RassenDatentypen.Lasupin_Enum =>
                                                                                 (
                                                                                  SystemDatentypen.Anfangswert_Enum => 19,
                                                                                  SystemDatentypen.Endwert_Enum     => 43
                                                                                 ),
                                                                               
                                                                               RassenDatentypen.Lamustra_Enum =>
                                                                                 (
                                                                                  SystemDatentypen.Anfangswert_Enum => 19,
                                                                                  SystemDatentypen.Endwert_Enum     => 43
                                                                                 ),
            
                                                                               RassenDatentypen.Manuky_Enum =>
                                                                                 (
                                                                                  SystemDatentypen.Anfangswert_Enum => 19,
                                                                                  SystemDatentypen.Endwert_Enum     => 43
                                                                                 ),
            
                                                                               RassenDatentypen.Suroka_Enum =>
                                                                                 (
                                                                                  SystemDatentypen.Anfangswert_Enum => 19,
                                                                                  SystemDatentypen.Endwert_Enum     => 43
                                                                                 ),
            
                                                                               RassenDatentypen.Pryolon_Enum =>
                                                                                 (
                                                                                  SystemDatentypen.Anfangswert_Enum => 19,
                                                                                  SystemDatentypen.Endwert_Enum     => 43
                                                                                 ),
            
                                                                               RassenDatentypen.Talbidahr_Enum =>
                                                                                 (
                                                                                  SystemDatentypen.Anfangswert_Enum => 19,
                                                                                  SystemDatentypen.Endwert_Enum     => 43
                                                                                 ),
            
                                                                               RassenDatentypen.Moru_Phisihl_Enum =>
                                                                                 (
                                                                                  SystemDatentypen.Anfangswert_Enum => 19,
                                                                                  SystemDatentypen.Endwert_Enum     => 43
                                                                                 ),
            
                                                                               RassenDatentypen.Larinos_Lotaris_Enum =>
                                                                                 (
                                                                                  SystemDatentypen.Anfangswert_Enum => 19,
                                                                                  SystemDatentypen.Endwert_Enum     => 43
                                                                                 ),
            
                                                                               RassenDatentypen.Carupex_Enum =>
                                                                                 (
                                                                                  SystemDatentypen.Anfangswert_Enum => 19,
                                                                                  SystemDatentypen.Endwert_Enum     => 43
                                                                                 ),
            
                                                                               RassenDatentypen.Alary_Enum =>
                                                                                 (
                                                                                  SystemDatentypen.Anfangswert_Enum => 19,
                                                                                  SystemDatentypen.Endwert_Enum     => 43
                                                                                 ),
            
                                                                               RassenDatentypen.Tesorahn_Enum =>
                                                                                 (
                                                                                  SystemDatentypen.Anfangswert_Enum => 19,
                                                                                  SystemDatentypen.Endwert_Enum     => 43
                                                                                 ),
            
                                                                               RassenDatentypen.Natries_Zermanis_Enum =>
                                                                                 (
                                                                                  SystemDatentypen.Anfangswert_Enum => 19,
                                                                                  SystemDatentypen.Endwert_Enum     => 43
                                                                                 ),
            
                                                                               RassenDatentypen.Tridatus_Enum =>
                                                                                 (
                                                                                  SystemDatentypen.Anfangswert_Enum => 19,
                                                                                  SystemDatentypen.Endwert_Enum     => 43
                                                                                 ),
            
                                                                               RassenDatentypen.Senelari_Enum =>
                                                                                 (
                                                                                  SystemDatentypen.Anfangswert_Enum => 19,
                                                                                  SystemDatentypen.Endwert_Enum     => 43
                                                                                 ),
            
                                                                               RassenDatentypen.Aspari_2_Enum =>
                                                                                 (
                                                                                  SystemDatentypen.Anfangswert_Enum => 19,
                                                                                  SystemDatentypen.Endwert_Enum     => 43
                                                                                 ),
            
                                                                               RassenDatentypen.Ekropa_Enum =>
                                                                                 (
                                                                                  SystemDatentypen.Anfangswert_Enum => 19,
                                                                                  SystemDatentypen.Endwert_Enum     => 43
                                                                                 )
                                                                              );

   procedure StadtUmgebungsbereichFestlegen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
   
private
   
   Umgebung : KartenDatentypen.UmgebungsbereichDrei;
   
   procedure StadtUmgebungErmitteln
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord);

end StadtUmgebungsbereichFestlegen;
