pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen;

package DatenbankVereinfachung is

   function EinheitenIDVereinfachung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.EinheitenID
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0);
   
   function EinheitenListeGrafikVereinfachung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Wide_Wide_Character
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0);
   
private
   
   EinheitID : GlobaleDatentypen.EinheitenID;

end DatenbankVereinfachung;
