pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;
use GlobaleDatentypen;

package ZugriffEinheitenDatenbank is
   
   function GrafikOhneID
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Wide_Wide_Character
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0
          and
            EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2));
   
   function TypOhneID
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.EinheitenTyp
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0
          and
            EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2));
   
   function GrafikMitID
     (RasseExtern : GlobaleDatentypen.Rassen;
      IDExtern : GlobaleDatentypen.EinheitenID)
      return Wide_Wide_Character
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);
   
   function TypMitID
     (RasseExtern : GlobaleDatentypen.Rassen;
      IDExtern : GlobaleDatentypen.EinheitenID)
      return GlobaleDatentypen.EinheitenTyp
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);

end ZugriffEinheitenDatenbank;
