pragma SPARK_Mode (On);

with EinheitStadtRecords, GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package StadtUmgebungsbereichFestlegen is
   
   type TechnologieUmgebungsgrößeArray is array (SonstigeDatentypen.Rassen_Verwendet_Enum'Range, GlobaleDatentypen.Anfang_Ende_Enum'Range) of EinheitStadtDatentypen.ForschungID;
   TechnologieUmgebungsgröße : constant TechnologieUmgebungsgrößeArray := (
                                                                               SonstigeDatentypen.Menschen =>
                                                                                 (GlobaleDatentypen.Anfangswert => 19,
                                                                                  GlobaleDatentypen.Endwert     => 43),
                                                                                             
                                                                               SonstigeDatentypen.Kasrodiah =>
                                                                                 (GlobaleDatentypen.Anfangswert => 19,
                                                                                  GlobaleDatentypen.Endwert     => 43),
            
                                                                               SonstigeDatentypen.Lasupin =>
                                                                                 (GlobaleDatentypen.Anfangswert => 19,
                                                                                  GlobaleDatentypen.Endwert     => 43),
            
                                                                               SonstigeDatentypen.Lamustra =>
                                                                                 (GlobaleDatentypen.Anfangswert => 19,
                                                                                  GlobaleDatentypen.Endwert     => 43),
            
                                                                               SonstigeDatentypen.Manuky =>
                                                                                 (GlobaleDatentypen.Anfangswert => 19,
                                                                                  GlobaleDatentypen.Endwert     => 43),
            
                                                                               SonstigeDatentypen.Suroka =>
                                                                                 (GlobaleDatentypen.Anfangswert => 19,
                                                                                  GlobaleDatentypen.Endwert     => 43),
            
                                                                               SonstigeDatentypen.Pryolon =>
                                                                                 (GlobaleDatentypen.Anfangswert => 19,
                                                                                  GlobaleDatentypen.Endwert     => 43),
            
                                                                               SonstigeDatentypen.Talbidahr =>
                                                                                 (GlobaleDatentypen.Anfangswert => 19,
                                                                                  GlobaleDatentypen.Endwert     => 43),
            
                                                                               SonstigeDatentypen.Moru_Phisihl =>
                                                                                 (GlobaleDatentypen.Anfangswert => 19,
                                                                                  GlobaleDatentypen.Endwert     => 43),
            
                                                                               SonstigeDatentypen.Larinos_Lotaris =>
                                                                                 (GlobaleDatentypen.Anfangswert => 19,
                                                                                  GlobaleDatentypen.Endwert     => 43),
            
                                                                               SonstigeDatentypen.Carupex =>
                                                                                 (GlobaleDatentypen.Anfangswert => 19,
                                                                                  GlobaleDatentypen.Endwert     => 43),
            
                                                                               SonstigeDatentypen.Alary =>
                                                                                 (GlobaleDatentypen.Anfangswert => 19,
                                                                                  GlobaleDatentypen.Endwert     => 43),
            
                                                                               SonstigeDatentypen.Tesorahn =>
                                                                                 (GlobaleDatentypen.Anfangswert => 19,
                                                                                  GlobaleDatentypen.Endwert     => 43),
            
                                                                               SonstigeDatentypen.Natries_Zermanis =>
                                                                                 (GlobaleDatentypen.Anfangswert => 19,
                                                                                  GlobaleDatentypen.Endwert     => 43),
            
                                                                               SonstigeDatentypen.Tridatus =>
                                                                                 (GlobaleDatentypen.Anfangswert => 19,
                                                                                  GlobaleDatentypen.Endwert     => 43),
            
                                                                               SonstigeDatentypen.Senelari =>
                                                                                 (GlobaleDatentypen.Anfangswert => 19,
                                                                                  GlobaleDatentypen.Endwert     => 43),
            
                                                                               SonstigeDatentypen.Aspari_2 =>
                                                                                 (GlobaleDatentypen.Anfangswert => 19,
                                                                                  GlobaleDatentypen.Endwert     => 43),
            
                                                                               SonstigeDatentypen.Ekropa =>
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
   
   Umgebung : KartenDatentypen.LoopRangeMinusDreiZuDrei;
   
   procedure StadtUmgebungErmitteln
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);

end StadtUmgebungsbereichFestlegen;
