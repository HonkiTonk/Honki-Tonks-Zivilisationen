pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with EinheitenRecords;
with SonstigeVariablen;
with EinheitenDatentypen;
with SpielVariablen;
with ForschungenDatentypen;
with StadtDatentypen;

with KIDatentypen;

package KIVorhandeneAufgaben is

   function SichHeilen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeit
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum);
   
   function SichVerbessern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeit
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum);
   
   function EinheitAuflösen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeit
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum);
   
   function Fliehen
     return KIDatentypen.AufgabenWichtigkeit;

   function NeueStadtBauenGehen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeit
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum);

   function StadtUmgebungVerbessern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeit
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum);

   function StadtBewachen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeit
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum);

   function StadtUmgebungZerstören
     return KIDatentypen.AufgabenWichtigkeit;

   function Angreifen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeit
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum);

   function Erkunden
     return KIDatentypen.AufgabenWichtigkeit;
   
   function SichBefestigen
     return KIDatentypen.AufgabenWichtigkeit;
   
   function NichtsTun
     return KIDatentypen.AufgabenWichtigkeit;
   
private
   
   NotwendigeTechnologie : ForschungenDatentypen.ForschungIDMitNullWert;
   
   EinheitID : EinheitenDatentypen.EinheitenID;
   
   VorhandeneStädte : StadtDatentypen.MaximaleStädteMitNullWert;
   
   EinheitNummer : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   
   GewählteAufgabe : KIDatentypen.AufgabenWichtigkeit;

end KIVorhandeneAufgaben;
