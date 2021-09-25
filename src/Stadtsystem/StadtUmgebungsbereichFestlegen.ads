pragma SPARK_Mode (On);

with EinheitStadtRecords, GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package StadtUmgebungsbereichFestlegen is
   
   type TechnologieUmgebungsgrößeArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range, GlobaleDatentypen.Anfang_Ende_Enum'Range) of GlobaleDatentypen.ForschungID;
   TechnologieUmgebungsgröße : constant TechnologieUmgebungsgrößeArray := (
                                                                               GlobaleDatentypen.Menschen =>
                                                                                 (GlobaleDatentypen.Anfangswert => 19,
                                                                                  GlobaleDatentypen.Endwert     => 43),
                                                                                             
                                                                               GlobaleDatentypen.Kasrodiah =>
                                                                                 (GlobaleDatentypen.Anfangswert => 19,
                                                                                  GlobaleDatentypen.Endwert     => 43),
            
                                                                               GlobaleDatentypen.Lasupin =>
                                                                                 (GlobaleDatentypen.Anfangswert => 19,
                                                                                  GlobaleDatentypen.Endwert     => 43),
            
                                                                               GlobaleDatentypen.Lamustra =>
                                                                                 (GlobaleDatentypen.Anfangswert => 19,
                                                                                  GlobaleDatentypen.Endwert     => 43),
            
                                                                               GlobaleDatentypen.Manuky =>
                                                                                 (GlobaleDatentypen.Anfangswert => 19,
                                                                                  GlobaleDatentypen.Endwert     => 43),
            
                                                                               GlobaleDatentypen.Suroka =>
                                                                                 (GlobaleDatentypen.Anfangswert => 19,
                                                                                  GlobaleDatentypen.Endwert     => 43),
            
                                                                               GlobaleDatentypen.Pryolon =>
                                                                                 (GlobaleDatentypen.Anfangswert => 19,
                                                                                  GlobaleDatentypen.Endwert     => 43),
            
                                                                               GlobaleDatentypen.Talbidahr =>
                                                                                 (GlobaleDatentypen.Anfangswert => 19,
                                                                                  GlobaleDatentypen.Endwert     => 43),
            
                                                                               GlobaleDatentypen.Moru_Phisihl =>
                                                                                 (GlobaleDatentypen.Anfangswert => 19,
                                                                                  GlobaleDatentypen.Endwert     => 43),
            
                                                                               GlobaleDatentypen.Larinos_Lotaris =>
                                                                                 (GlobaleDatentypen.Anfangswert => 19,
                                                                                  GlobaleDatentypen.Endwert     => 43),
            
                                                                               GlobaleDatentypen.Carupex =>
                                                                                 (GlobaleDatentypen.Anfangswert => 19,
                                                                                  GlobaleDatentypen.Endwert     => 43),
            
                                                                               GlobaleDatentypen.Alary =>
                                                                                 (GlobaleDatentypen.Anfangswert => 19,
                                                                                  GlobaleDatentypen.Endwert     => 43),
            
                                                                               GlobaleDatentypen.Tesorahn =>
                                                                                 (GlobaleDatentypen.Anfangswert => 19,
                                                                                  GlobaleDatentypen.Endwert     => 43),
            
                                                                               GlobaleDatentypen.Natries_Zermanis =>
                                                                                 (GlobaleDatentypen.Anfangswert => 19,
                                                                                  GlobaleDatentypen.Endwert     => 43),
            
                                                                               GlobaleDatentypen.Tridatus =>
                                                                                 (GlobaleDatentypen.Anfangswert => 19,
                                                                                  GlobaleDatentypen.Endwert     => 43),
            
                                                                               GlobaleDatentypen.Senelari =>
                                                                                 (GlobaleDatentypen.Anfangswert => 19,
                                                                                  GlobaleDatentypen.Endwert     => 43),
            
                                                                               GlobaleDatentypen.Aspari_2 =>
                                                                                 (GlobaleDatentypen.Anfangswert => 19,
                                                                                  GlobaleDatentypen.Endwert     => 43),
            
                                                                               GlobaleDatentypen.Ekropa =>
                                                                                 (GlobaleDatentypen.Anfangswert => 19,
                                                                                  GlobaleDatentypen.Endwert     => 43)
                                                                              );

   procedure StadtUmgebungsbereichFestlegen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);
   
private
   
   Umgebung : GlobaleDatentypen.LoopRangeMinusDreiZuDrei;
   
   procedure StadtUmgebungErmitteln
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);

end StadtUmgebungsbereichFestlegen;
