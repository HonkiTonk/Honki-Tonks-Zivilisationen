pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen;

package Kampfsystem is

   function KampfsystemNahkampf
     (AngreiferRasseNummerExtern, VerteidigerRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
     with
       Pre =>
         (AngreiferRasseNummerExtern.Rasse /= VerteidigerRasseNummerExtern.Rasse
          and
            GlobaleVariablen.RassenImSpiel (AngreiferRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer
          and
            GlobaleVariablen.RassenImSpiel (VerteidigerRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer
          and
            VerteidigerRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2)
          and
            AngreiferRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2));

private

   StadtVorhanden : GlobaleDatentypen.MaximaleStädteMitNullWert;

   VerteidigungBonusDurchStadt : Float;
   VerteidigerBonus : constant Float := 1.25;
   AngreiferStärkeAngriff : Float;
   AngreiferStärkeVerteidigung : Float;
   VerteidigerStärkeAngriff : Float;
   VerteidigerStärkeVerteidigung : Float;
   Kampfglück : Float;

   procedure KampfBerechnung
     (VerteidigerRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      AngreiferStärkeAngriffExtern, VerteidigerStärkeVerteidigungExtern : in Float)
     with
       Pre =>
         (VerteidigerRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2)
          and
            GlobaleVariablen.RassenImSpiel (VerteidigerRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);

   function Kampf
     (VerteidigerRasseNummerExtern, AngreiferRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      VerteidigerBonusExtern : in Float)
      return Boolean
     with
       Pre =>
         (AngreiferRasseNummerExtern.Rasse /= VerteidigerRasseNummerExtern.Rasse
          and
            GlobaleVariablen.RassenImSpiel (AngreiferRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer
          and
            GlobaleVariablen.RassenImSpiel (VerteidigerRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer
          and
            VerteidigerRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2)
          and
            AngreiferRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2));

end Kampfsystem;
