pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleVariablen, GlobaleDatentypen;
use GlobaleDatentypen;

package KINahkampfBodenAufgabeErmitteln is

   procedure NahkampfBodenAufgabeErmitteln
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2);

private

   GewählteAufgabe : Natural;


   EinheitNummer : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
   EinheitID : GlobaleDatentypen.EinheitenID;

   type WichtigkeitArray is array (0 .. 9) of Natural;
   Wichtigkeit : WichtigkeitArray;

   function StadtBewachen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2);

   function EinheitAuflösen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2);

   function Fliehen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2);

   function SichHeilen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2);

   function SichBefestigen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2);

   function SichVerbessern
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2);

   function NichtsTun
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2);

   function StadtUmgebungZerstören
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2);

   function Angreifen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2);

   function Erkunden
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2);

end KINahkampfBodenAufgabeErmitteln;
