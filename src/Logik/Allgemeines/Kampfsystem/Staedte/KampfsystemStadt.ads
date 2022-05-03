pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with EinheitStadtRecords;
with SonstigeVariablen;
with EinheitStadtDatentypen;
with SpielVariablen;

package KampfsystemStadt is

   function KampfsystemStadt
     (AngreifendeEinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      VerteidigendeStadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (AngreifendeEinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
          and
            SonstigeVariablen.RassenImSpiel (VerteidigendeStadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
          and
            AngreifendeEinheitRasseNummerExtern.Rasse /= VerteidigendeStadtRasseNummerExtern.Rasse
          and
            AngreifendeEinheitRasseNummerExtern.Platznummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (AngreifendeEinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            VerteidigendeStadtRasseNummerExtern.Platznummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (VerteidigendeStadtRasseNummerExtern.Rasse).Städtegrenze);
   
private
   
   GesundheitStadt : EinheitStadtDatentypen.ProduktionFeld;
   AngerichteterSchaden : EinheitStadtDatentypen.ProduktionFeld;
   
   Kampfglück : Float;
   
   KampfwerteVerteidiger : EinheitStadtRecords.KampfwerteRecord;
   KampfwerteAngreifer : EinheitStadtRecords.KampfwerteRecord;
   
   -- Die Werte gelten immer aus Sicht des Angreifers
   ----------------------- Mal auslagern und mit KampfsystemEinheiten zusammenführen.
   type Kampf_Unterschiede_Enum is (
                                    Gleich_Enum, Stärker_Enum, Extrem_Stärker_Enum, Schwächer_Enum, Extrem_Schwächer_Enum
                                   );

   WelcherFall : Kampf_Unterschiede_Enum;

   type SchadenAngerichtetArray is array (Kampf_Unterschiede_Enum'Range, EinheitStadtDatentypen.ProduktionFeld (1) .. 3) of Float;
   SchadenAngerichtet : constant SchadenAngerichtetArray := (
                                                             Gleich_Enum =>
                                                               (
                                                                1 => 0.40,
                                                                2 => 0.75,
                                                                3 => 0.90
                                                               ),
                                                             
                                                             Stärker_Enum =>
                                                               (
                                                                1 => 0.30,
                                                                2 => 0.65,
                                                                3 => 0.80
                                                               ),
                                                             
                                                             Extrem_Stärker_Enum =>
                                                               (
                                                                1 => 0.20,
                                                                2 => 0.50,
                                                                3 => 0.70
                                                               ),
                                                             
                                                             Schwächer_Enum =>
                                                               (
                                                                1 => 0.55,
                                                                2 => 0.85,
                                                                3 => 0.95
                                                               ),
                                                             
                                                             Extrem_Schwächer_Enum =>
                                                               (
                                                                1 => 0.70,
                                                                2 => 0.90,
                                                                3 => 0.98
                                                               )
                                                            );
   
   procedure SchadenStadtBerechnen
     (AngriffExtern : in EinheitStadtDatentypen.Kampfwerte;
      VerteidigungExtern : in EinheitStadtDatentypen.Kampfwerte);
   
   
   
   function Kampfverlauf
     (AngreifendeEinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean;
   
   function Kampf
     (AngreifendeEinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      VerteidigendeStadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean;

end KampfsystemStadt;