with RassenDatentypen; use RassenDatentypen;
with EinheitenRecords;
with SpielVariablen;

private with KartenRecords;
private with AufgabenDatentypen;
private with KartenverbesserungDatentypen;
private with BefehleDatentypen;

package KIEinheitUmsetzenVerbesserungenLogik is
   pragma Elaborate_Body;

   function WelcheVerbesserungAnlegen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );
   
private
   
   WelcheVerbesserung : AufgabenDatentypen.Einheiten_Aufgabe_Vorhanden_Enum;
   
   VorhandeneVerbesserung : KartenverbesserungDatentypen.Karten_Verbesserung_Enum;
   
   Befehl : BefehleDatentypen.Einheitenbelegung_Enum;
   
   EinheitKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;

end KIEinheitUmsetzenVerbesserungenLogik;
