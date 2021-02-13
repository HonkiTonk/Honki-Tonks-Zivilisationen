pragma SPARK_Mode (On);

with Ada.Numerics.Float_Random;
use Ada.Numerics.Float_Random;

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen;

package Kampfsystem is

   function KampfsystemNahkampf (RasseAngriff, RasseVerteidigung : in GlobaleDatentypen.Rassen; GegnerStadtNummer, EinheitenNummerAngriff, EinheitenNummerVerteidigung : in Integer) return Boolean with
     Pre => RasseAngriff /= RasseVerteidigung;

private

   Ergebnis : Boolean;

   Gewählt : Generator;

   VerteidigungBonusDurchStadt : Float;
   VerteidigerBonus : constant Float := 1.25;
   VerteidigungVerteidigungWert : Float;
   VerteidigungAngriffWert : Float;
   AngriffAngriffWert : Float;
   AngriffVerteidigungWert : Float;
   Wert : Float;

   procedure KampfBerechnung (VerteidigerRasseUndEinheitNummer : in GlobaleRecords.RassePlatznummerRecord; AngriffWert, VerteidigungWert : in Float) with
     Pre => VerteidigerRasseUndEinheitNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and VerteidigerRasseUndEinheitNummer.Rasse in GlobaleDatentypen.Rassen;

   function Kampf (VerteidigerRasseUndEinheitNummer, AngreiferRasseUndEinheitNummer : in GlobaleRecords.RassePlatznummerRecord; VerteidigungBonus : in Float) return Boolean with
     Pre => VerteidigerRasseUndEinheitNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and VerteidigerRasseUndEinheitNummer.Rasse in GlobaleDatentypen.Rassen
     and AngreiferRasseUndEinheitNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and AngreiferRasseUndEinheitNummer.Rasse in GlobaleDatentypen.Rassen
     and AngreiferRasseUndEinheitNummer.Rasse /= VerteidigerRasseUndEinheitNummer.Rasse;

   function Prüfen return Boolean;

end Kampfsystem;
