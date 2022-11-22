with RassenDatentypen;
with EinheitenRecords;
with SpielVariablen;

private with KartenRecords;
private with AufgabenDatentypen;
private with KartenverbesserungDatentypen;
private with BefehleDatentypen;

with LeseGrenzen;
with LeseRassenbelegung;

package KIEinheitUmsetzenVerbesserungenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   function WelcheVerbesserungAnlegen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );
   
private
   
   WelcheVerbesserung : AufgabenDatentypen.Einheiten_Aufgabe_Vorhanden_Enum;
   
   VorhandeneVerbesserung : KartenverbesserungDatentypen.Karten_Verbesserung_Enum;
   
   Befehl : BefehleDatentypen.Einheitenbelegung_Enum;
   
   EinheitKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;

end KIEinheitUmsetzenVerbesserungenLogik;
