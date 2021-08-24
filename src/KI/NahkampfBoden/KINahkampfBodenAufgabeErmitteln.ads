pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleVariablen, GlobaleDatentypen;
use GlobaleDatentypen;

package KINahkampfBodenAufgabeErmitteln is

   procedure NahkampfBodenAufgabeErmitteln
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI);

private

   GewählteAufgabe : Natural;

   EinheitNummer : GlobaleDatentypen.MaximaleEinheitenMitNullWert;

   type WichtigkeitArray is array (0 .. 9) of GlobaleDatentypen.GesamtproduktionStadt;
   Wichtigkeit : WichtigkeitArray;

   function StadtBewachen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI);

   function EinheitAuflösen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI);

   function Fliehen
     return GlobaleDatentypen.GesamtproduktionStadt;

   function SichBefestigen
     return GlobaleDatentypen.GesamtproduktionStadt;

   function StadtUmgebungZerstören
     return GlobaleDatentypen.GesamtproduktionStadt;

   function Angreifen
     return GlobaleDatentypen.GesamtproduktionStadt;

   function Erkunden
     return GlobaleDatentypen.GesamtproduktionStadt;

end KINahkampfBodenAufgabeErmitteln;
