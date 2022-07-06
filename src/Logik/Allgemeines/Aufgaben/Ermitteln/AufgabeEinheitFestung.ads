pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with EinheitenRecords;
with KartengrundDatentypen;
with SpielVariablen;
with KartenRecords;

private with AufgabenDatentypen;
private with KartenVerbesserungDatentypen;
private with ProduktionDatentypen;

with Karten;

package AufgabeEinheitFestung is

   function FestungErmitteln
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
               and
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );

private

   WelcheArbeit : AufgabenDatentypen.Einheiten_Aufgaben_Enum;

   VorhandeneVerbesserung : KartenVerbesserungDatentypen.Karten_Verbesserung_Enum;

   Arbeitszeit : ProduktionDatentypen.ArbeitszeitVorhanden;
   Grundzeit : ProduktionDatentypen.ArbeitszeitVorhanden := 1;

   Arbeitswerte : EinheitenRecords.ArbeitRecord;

   VorhandenerGrund : KartenRecords.KartengrundRecord;

   function OberflächeLand
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Enum)
      return EinheitenRecords.ArbeitRecord;

   function UnterflächeLand
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Enum)
      return EinheitenRecords.ArbeitRecord;

   function UnterflächeWasser
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Enum)
      return EinheitenRecords.ArbeitRecord;

   ----------------------- Später Festungen für den Kern einbauen.

end AufgabeEinheitFestung;
