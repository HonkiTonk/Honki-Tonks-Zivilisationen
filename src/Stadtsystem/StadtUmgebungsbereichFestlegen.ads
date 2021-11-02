pragma SPARK_Mode (On);

with SonstigeDatentypen; use SonstigeDatentypen;
with SystemDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;
with EinheitStadtDatentypen;
with KartenDatentypen;

package StadtUmgebungsbereichFestlegen is
   
   type TechnologieUmgebungsgrößeArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range, SystemDatentypen.Anfang_Ende_Enum'Range) of EinheitStadtDatentypen.ForschungID;
   TechnologieUmgebungsgröße : constant TechnologieUmgebungsgrößeArray := (
                                                                               SystemDatentypen.Menschen =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
                                                                                             
                                                                               SystemDatentypen.Kasrodiah =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SystemDatentypen.Lasupin =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SystemDatentypen.Lamustra =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SystemDatentypen.Manuky =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SystemDatentypen.Suroka =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SystemDatentypen.Pryolon =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SystemDatentypen.Talbidahr =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SystemDatentypen.Moru_Phisihl =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SystemDatentypen.Larinos_Lotaris =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SystemDatentypen.Carupex =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SystemDatentypen.Alary =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SystemDatentypen.Tesorahn =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SystemDatentypen.Natries_Zermanis =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SystemDatentypen.Tridatus =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SystemDatentypen.Senelari =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SystemDatentypen.Aspari_2 =>
                                                                                 (SystemDatentypen.Anfangswert => 19,
                                                                                  SystemDatentypen.Endwert     => 43),
            
                                                                               SystemDatentypen.Ekropa =>
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
