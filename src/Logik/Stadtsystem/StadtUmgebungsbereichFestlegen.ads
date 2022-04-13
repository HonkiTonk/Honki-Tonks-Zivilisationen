pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;
with EinheitStadtDatentypen;
with KartenDatentypen;

package StadtUmgebungsbereichFestlegen is
   
   type TechnologieUmgebungsgrößeArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range, SystemDatentypen.Anfang_Ende_Enum'Range) of EinheitStadtDatentypen.ForschungID;
   TechnologieUmgebungsgröße : constant TechnologieUmgebungsgrößeArray := (
                                                                               SystemDatentypen.Menschen_Enum =>
                                                                                 (
                                                                                  SystemDatentypen.Anfangswert_Enum => 19,
                                                                                  SystemDatentypen.Endwert_Enum     => 43
                                                                                 ),
                                                                                             
                                                                               SystemDatentypen.Kasrodiah_Enum =>
                                                                                 (
                                                                                  SystemDatentypen.Anfangswert_Enum => 19,
                                                                                  SystemDatentypen.Endwert_Enum     => 43
                                                                                 ),
            
                                                                               SystemDatentypen.Lasupin_Enum =>
                                                                                 (
                                                                                  SystemDatentypen.Anfangswert_Enum => 19,
                                                                                  SystemDatentypen.Endwert_Enum     => 43
                                                                                 ),
                                                                               
                                                                               SystemDatentypen.Lamustra_Enum =>
                                                                                 (
                                                                                  SystemDatentypen.Anfangswert_Enum => 19,
                                                                                  SystemDatentypen.Endwert_Enum     => 43
                                                                                 ),
            
                                                                               SystemDatentypen.Manuky_Enum =>
                                                                                 (
                                                                                  SystemDatentypen.Anfangswert_Enum => 19,
                                                                                  SystemDatentypen.Endwert_Enum     => 43
                                                                                 ),
            
                                                                               SystemDatentypen.Suroka_Enum =>
                                                                                 (
                                                                                  SystemDatentypen.Anfangswert_Enum => 19,
                                                                                  SystemDatentypen.Endwert_Enum     => 43
                                                                                 ),
            
                                                                               SystemDatentypen.Pryolon_Enum =>
                                                                                 (
                                                                                  SystemDatentypen.Anfangswert_Enum => 19,
                                                                                  SystemDatentypen.Endwert_Enum     => 43
                                                                                 ),
            
                                                                               SystemDatentypen.Talbidahr_Enum =>
                                                                                 (
                                                                                  SystemDatentypen.Anfangswert_Enum => 19,
                                                                                  SystemDatentypen.Endwert_Enum     => 43
                                                                                 ),
            
                                                                               SystemDatentypen.Moru_Phisihl_Enum =>
                                                                                 (
                                                                                  SystemDatentypen.Anfangswert_Enum => 19,
                                                                                  SystemDatentypen.Endwert_Enum     => 43
                                                                                 ),
            
                                                                               SystemDatentypen.Larinos_Lotaris_Enum =>
                                                                                 (
                                                                                  SystemDatentypen.Anfangswert_Enum => 19,
                                                                                  SystemDatentypen.Endwert_Enum     => 43
                                                                                 ),
            
                                                                               SystemDatentypen.Carupex_Enum =>
                                                                                 (
                                                                                  SystemDatentypen.Anfangswert_Enum => 19,
                                                                                  SystemDatentypen.Endwert_Enum     => 43
                                                                                 ),
            
                                                                               SystemDatentypen.Alary_Enum =>
                                                                                 (
                                                                                  SystemDatentypen.Anfangswert_Enum => 19,
                                                                                  SystemDatentypen.Endwert_Enum     => 43
                                                                                 ),
            
                                                                               SystemDatentypen.Tesorahn_Enum =>
                                                                                 (
                                                                                  SystemDatentypen.Anfangswert_Enum => 19,
                                                                                  SystemDatentypen.Endwert_Enum     => 43
                                                                                 ),
            
                                                                               SystemDatentypen.Natries_Zermanis_Enum =>
                                                                                 (
                                                                                  SystemDatentypen.Anfangswert_Enum => 19,
                                                                                  SystemDatentypen.Endwert_Enum     => 43
                                                                                 ),
            
                                                                               SystemDatentypen.Tridatus_Enum =>
                                                                                 (
                                                                                  SystemDatentypen.Anfangswert_Enum => 19,
                                                                                  SystemDatentypen.Endwert_Enum     => 43
                                                                                 ),
            
                                                                               SystemDatentypen.Senelari_Enum =>
                                                                                 (
                                                                                  SystemDatentypen.Anfangswert_Enum => 19,
                                                                                  SystemDatentypen.Endwert_Enum     => 43
                                                                                 ),
            
                                                                               SystemDatentypen.Aspari_2_Enum =>
                                                                                 (
                                                                                  SystemDatentypen.Anfangswert_Enum => 19,
                                                                                  SystemDatentypen.Endwert_Enum     => 43
                                                                                 ),
            
                                                                               SystemDatentypen.Ekropa_Enum =>
                                                                                 (
                                                                                  SystemDatentypen.Anfangswert_Enum => 19,
                                                                                  SystemDatentypen.Endwert_Enum     => 43
                                                                                 )
                                                                              );

   procedure StadtUmgebungsbereichFestlegen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemDatentypen.Leer_Spieler_Enum);
   
private
   
   Umgebung : KartenDatentypen.UmgebungsbereichDrei;
   
   procedure StadtUmgebungErmitteln
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);

end StadtUmgebungsbereichFestlegen;
