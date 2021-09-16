pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen;

package KampfwerteEinheitErmitteln is

   function AktuelleVerteidigungEinheit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      AngreiferExtern : in Boolean)
      return GlobaleDatentypen.GesamtproduktionStadt
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer
          and
            EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze);
   
   function AktuellerAngriffEinheit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      AngreiferExtern : in Boolean)
      return GlobaleDatentypen.GesamtproduktionStadt
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer
          and
            EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze);
   
private
   
   VerschanzungBonus : constant Float := 1.25;
   StadtBonus : constant Float := 1.25;
   -- Drin lassen? Anders gestalten?
   AngriffBonus : constant Float := 1.25;
   
   VerteidigungWert : GlobaleDatentypen.GesamtproduktionStadt;
   AngriffWert : GlobaleDatentypen.GesamtproduktionStadt;
   Bonus : GlobaleDatentypen.GesamtproduktionStadt;
   
   VerteidigungWertFloat : Float;
   AngriffWertFloat : Float;
   
   function VerteidigungsbonusVerteidiger
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt;
   
   function VerteidigungsbonusAngreifer
     return GlobaleDatentypen.GesamtproduktionStadt;
   
   function AngriffsbonusAngreifer
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt;
   
   function AngriffsbonusVerteidiger
     return GlobaleDatentypen.GesamtproduktionStadt;

end KampfwerteEinheitErmitteln;
