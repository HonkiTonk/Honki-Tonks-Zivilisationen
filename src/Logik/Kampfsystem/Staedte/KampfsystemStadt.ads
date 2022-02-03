pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;
with EinheitStadtDatentypen;
with SystemKonstanten;

package KampfsystemStadt is

   function KampfsystemStadt
     (AngreifendeEinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      VerteidigendeStadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (AngreifendeEinheitRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante
          and
            GlobaleVariablen.RassenImSpiel (VerteidigendeStadtRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante
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
   
   type Kampf_Unterschiede_Enum is (Gleich, Stärker, Extrem_Stärker, Schwächer, Extrem_Schwächer);

   WelcherFall : Kampf_Unterschiede_Enum;

   type SchadenAngerichtetArray is array (Kampf_Unterschiede_Enum'Range, EinheitStadtDatentypen.ProduktionFeld (1) .. 3) of Float;
   SchadenAngerichtet : constant SchadenAngerichtetArray := (
                                                             Gleich           =>
                                                               (1 => 0.40,
                                                                2 => 0.75,
                                                                3 => 0.90),
                                                             Stärker          =>
                                                               (1 => 0.30,
                                                                2 => 0.65,
                                                                3 => 0.80),
                                                             Extrem_Stärker   =>
                                                               (1 => 0.20,
                                                                2 => 0.50,
                                                                3 => 0.70),
                                                             Schwächer        =>
                                                               (1 => 0.55,
                                                                2 => 0.85,
                                                                3 => 0.95),
                                                             Extrem_Schwächer =>
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
