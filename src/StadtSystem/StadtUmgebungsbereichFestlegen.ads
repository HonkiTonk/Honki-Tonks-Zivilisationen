pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package StadtUmgebungsbereichFestlegen is
   
   type TechnologieUmgebungsgrößeArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range, GlobaleDatentypen.Anfang_Ende_Enum'Range) of GlobaleDatentypen.ForschungIDMitNullWert;
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

   procedure Rassenaufteilung
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebaut'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);
   
private
   
   procedure StadtUmgebungMenschen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure StadtUmgebungKasrodiah
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure StadtUmgebungLasupin
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure StadtUmgebungLamustra
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure StadtUmgebungManuky
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure StadtUmgebungSuroka
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure StadtUmgebungPryolon
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure StadtUmgebungTalbidahr
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure StadtUmgebungMoruPhisihl
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure StadtUmgebungLarinosLotaris
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure StadtUmgebungCarupex
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure StadtUmgebungAlary
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure StadtUmgebungTesorahn
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
     
   procedure StadtUmgebungNatriesZermanis
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure StadtUmgebungTridatus
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure StadtUmgebungSenelari
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure StadtUmgebungAspari2
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure StadtUmgebungEkropa
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);

end StadtUmgebungsbereichFestlegen;
