pragma SPARK_Mode (On);

with Ada.Numerics.Float_Random;
use Ada.Numerics.Float_Random;

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen;

package Kampfsystem is

   function KampfsystemNahkampf
     (RasseAngriffExtern, RasseVerteidigungExtern : in GlobaleDatentypen.Rassen;
      GegnerStadtNummerExtern : in GlobaleDatentypen.MaximaleStädteMitNullWert;
      EinheitenNummerAngriffExtern, EinheitenNummerVerteidigungExtern : in GlobaleDatentypen.MaximaleEinheiten)
      return Boolean
     with
       Pre => (RasseAngriffExtern /= RasseVerteidigungExtern and GlobaleVariablen.RassenImSpiel (RasseAngriffExtern) /= 0 and GlobaleVariablen.RassenImSpiel (RasseVerteidigungExtern) /= 0);

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

   procedure KampfBerechnung
     (VerteidigerRasseEinheitNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      AngriffWertExtern, VerteidigungWertExtern : in Float)
     with
       Pre => (VerteidigerRasseEinheitNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2) and VerteidigerRasseEinheitNummerExtern.Rasse in GlobaleDatentypen.Rassen
               and (if VerteidigerRasseEinheitNummerExtern.Rasse > 0 then GlobaleVariablen.RassenImSpiel (VerteidigerRasseEinheitNummerExtern.Rasse) /= 0));

   function Kampf
     (VerteidigerRasseEinheitNummerExtern, AngreiferRasseEinheitNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      VerteidigungBonusExtern : in Float)
      return Boolean
     with
       Pre => (VerteidigerRasseEinheitNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebaut'First (2) and VerteidigerRasseEinheitNummerExtern.Rasse in GlobaleDatentypen.Rassen
               and AngreiferRasseEinheitNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2) and AngreiferRasseEinheitNummerExtern.Rasse in GlobaleDatentypen.Rassen
               and AngreiferRasseEinheitNummerExtern.Rasse /= VerteidigerRasseEinheitNummerExtern.Rasse
               and (if VerteidigerRasseEinheitNummerExtern.Rasse > 0 then GlobaleVariablen.RassenImSpiel (VerteidigerRasseEinheitNummerExtern.Rasse) /= 0)
               and (if AngreiferRasseEinheitNummerExtern.Rasse > 0 then GlobaleVariablen.RassenImSpiel (AngreiferRasseEinheitNummerExtern.Rasse) /= 0));

   function Prüfen
     return Boolean;

end Kampfsystem;
