pragma SPARK_Mode (On);

with Ada.Numerics.Float_Random;
use Ada.Numerics.Float_Random;

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen;

package Kampfsystem is

   function KampfsystemNahkampf (RasseAngriff, RasseVerteidigung : in GlobaleDatentypen.Rassen; GegnerStadtNummer : in GlobaleDatentypen.MaximaleStädteMitNullWert;
                                 EinheitenNummerAngriff, EinheitenNummerVerteidigung : in GlobaleDatentypen.MaximaleEinheiten) return Boolean with
     Pre => (RasseAngriff /= RasseVerteidigung and GlobaleVariablen.RassenImSpiel (RasseAngriff) /= 0 and GlobaleVariablen.RassenImSpiel (RasseVerteidigung) /= 0);

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

   procedure KampfBerechnung (VerteidigerRasseEinheitNummer : in GlobaleRecords.RassePlatznummerRecord; AngriffWert, VerteidigungWert : in Float) with
     Pre => (VerteidigerRasseEinheitNummer.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2) and VerteidigerRasseEinheitNummer.Rasse in GlobaleDatentypen.Rassen
             and (if VerteidigerRasseEinheitNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (VerteidigerRasseEinheitNummer.Rasse) /= 0));

   function Kampf (VerteidigerRasseEinheitNummer, AngreiferRasseEinheitNummer : in GlobaleRecords.RassePlatznummerRecord; VerteidigungBonus : in Float) return Boolean with
     Pre => (VerteidigerRasseEinheitNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'First (2) and VerteidigerRasseEinheitNummer.Rasse in GlobaleDatentypen.Rassen
             and AngreiferRasseEinheitNummer.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2) and AngreiferRasseEinheitNummer.Rasse in GlobaleDatentypen.Rassen
             and AngreiferRasseEinheitNummer.Rasse /= VerteidigerRasseEinheitNummer.Rasse and (if VerteidigerRasseEinheitNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (VerteidigerRasseEinheitNummer.Rasse) /= 0)
             and (if AngreiferRasseEinheitNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (AngreiferRasseEinheitNummer.Rasse) /= 0));

   function Prüfen return Boolean;

end Kampfsystem;
