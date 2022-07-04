pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with EinheitenRecords;
with SpielVariablen;

private with KartenRecords;
private with TastenbelegungDatentypen;
private with AufgabenDatentypen;
private with KartenVerbesserungDatentypen;

package KIEinheitUmsetzenVerbesserungen is

   function WelcheVerbesserungAnlegen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );
   
private
   
   WelcheVerbesserung : AufgabenDatentypen.Einheiten_Aufgabe_Vorhanden_Enum;
   
   VorhandeneVerbesserung : KartenVerbesserungDatentypen.Karten_Verbesserung_Enum;
   
   Befehl : TastenbelegungDatentypen.Tastenbelegung_Enum;
   
   EinheitKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;

end KIEinheitUmsetzenVerbesserungen;
