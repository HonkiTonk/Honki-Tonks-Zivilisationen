pragma SPARK_Mode (On);

with EinheitStadtRecords, SonstigeDatentypen, GlobaleVariablen, EinheitStadtDatentypen, SystemDatentypen, KartenDatentypen;
use SonstigeDatentypen;

package StadtUmgebungsbereichFestlegen is
   
   type TechnologieUmgebungsgrößeArray is array (SonstigeDatentypen.Rassen_Verwendet_Enum'Range, SystemDatentypen.Anfang_Ende_Enum'Range) of EinheitStadtDatentypen.ForschungID;
   TechnologieUmgebungsgröße : constant TechnologieUmgebungsgrößeArray := (
                                                                               SonstigeDatentypen.Menschen =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
                                                                                             
                                                                               SonstigeDatentypen.Kasrodiah =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SonstigeDatentypen.Lasupin =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SonstigeDatentypen.Lamustra =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SonstigeDatentypen.Manuky =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SonstigeDatentypen.Suroka =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SonstigeDatentypen.Pryolon =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SonstigeDatentypen.Talbidahr =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SonstigeDatentypen.Moru_Phisihl =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SonstigeDatentypen.Larinos_Lotaris =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SonstigeDatentypen.Carupex =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SonstigeDatentypen.Alary =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SonstigeDatentypen.Tesorahn =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SonstigeDatentypen.Natries_Zermanis =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SonstigeDatentypen.Tridatus =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SonstigeDatentypen.Senelari =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SonstigeDatentypen.Aspari_2 =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SonstigeDatentypen.Ekropa =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43)
                                                                              );

   procedure StadtUmgebungsbereichFestlegen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);
   
private
   
   Umgebung : KartenDatentypen.LoopRangeMinusDreiZuDrei;
   
   procedure StadtUmgebungErmitteln
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);

end StadtUmgebungsbereichFestlegen;
