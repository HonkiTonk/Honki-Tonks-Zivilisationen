pragma SPARK_Mode (On);

with EinheitStadtRecords, GlobaleVariablen, SonstigeDatentypen, KartenDatentypen, SystemDatentypen;
use SonstigeDatentypen;

package KIAufgabeUmsetzen is

   function WelcheVerbesserungAnlegen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_KI);

   function EinheitVerbessern
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_KI);

private

   AufgabeDurchführen : Boolean;
   NullWert : Boolean;

   Grund : KartenDatentypen.Karten_Grund_Enum;

   Befehl : SystemDatentypen.Tastenbelegung_Enum;

   function VerbesserungGebiet
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean;

end KIAufgabeUmsetzen;
