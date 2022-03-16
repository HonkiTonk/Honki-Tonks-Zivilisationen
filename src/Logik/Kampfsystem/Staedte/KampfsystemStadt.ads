pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;
with EinheitStadtDatentypen;

package KampfsystemStadt is

   function KampfsystemStadt
     (AngreifendeEinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      VerteidigendeStadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (AngreifendeEinheitRasseNummerExtern.Rasse) /= SystemDatentypen.Leer_Spieler_Enum
          and
            GlobaleVariablen.RassenImSpiel (VerteidigendeStadtRasseNummerExtern.Rasse) /= SystemDatentypen.Leer_Spieler_Enum
          and
            AngreifendeEinheitRasseNummerExtern.Rasse /= VerteidigendeStadtRasseNummerExtern.Rasse
          and
            AngreifendeEinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (AngreifendeEinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            VerteidigendeStadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (VerteidigendeStadtRasseNummerExtern.Rasse).Städtegrenze);
   
private
   
   GesundheitStadt : EinheitStadtDatentypen.ProduktionFeld;
   AngerichteterSchaden : EinheitStadtDatentypen.ProduktionFeld;
   
   Kampfglück : Float;
   
   KampfwerteVerteidiger : EinheitStadtRecords.KampfwerteRecord;
   KampfwerteAngreifer : EinheitStadtRecords.KampfwerteRecord;
   
   type Kampf_Unterschiede_Enum is (Gleich_Enum, Stärker_Enum, Extrem_Stärker_Enum, Schwächer_Enum, Extrem_Schwächer_Enum);

   WelcherFall : Kampf_Unterschiede_Enum;

   type SchadenAngerichtetArray is array (Kampf_Unterschiede_Enum'Range, EinheitStadtDatentypen.ProduktionFeld (1) .. 3) of Float;
   SchadenAngerichtet : constant SchadenAngerichtetArray := (
                                                             Gleich_Enum           =>
                                                               (1 => 0.40,
                                                                2 => 0.75,
                                                                3 => 0.90),
                                                             Stärker_Enum          =>
                                                               (1 => 0.30,
                                                                2 => 0.65,
                                                                3 => 0.80),
                                                             Extrem_Stärker_Enum   =>
                                                               (1 => 0.20,
                                                                2 => 0.50,
                                                                3 => 0.70),
                                                             Schwächer_Enum        =>
                                                               (1 => 0.55,
                                                                2 => 0.85,
                                                                3 => 0.95),
                                                             Extrem_Schwächer_Enum =>
                                                               (1 => 0.70,
                                                                2 => 0.90,
                                                                3 => 0.98)
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
