pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with KartengrundDatentypen; use KartengrundDatentypen;
with EinheitenRecords;
with SpielVariablen;
with KartenRecords;

private with AufgabenDatentypen;
private with ProduktionDatentypen;

with Karten;

package AufgabeEinheitMine is

   function MineErmitteln
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

   VorarbeitNötig : Boolean;

   WelcheArbeit : AufgabenDatentypen.Einheiten_Aufgaben_Enum;

   Arbeitszeit : ProduktionDatentypen.ArbeitszeitVorhanden;

   Arbeitswerte : EinheitenRecords.ArbeitVorleistungRecord;

   VorhandenerGrund : KartenRecords.KartengrundRecord;

   function OberflächeLand
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      GrundExtern : in KartenRecords.KartengrundRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return EinheitenRecords.ArbeitVorleistungRecord
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
               and
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 (GrundExtern.BasisGrund in KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum'Range
                  or
                    GrundExtern.BasisGrund = KartengrundDatentypen.Eis_Enum)
               and
                 (GrundExtern.AktuellerGrund in Kartengrund_Oberfläche_Land_Enum'Range
                  or
                    GrundExtern.AktuellerGrund = KartengrundDatentypen.Eis_Enum)
              );

   function UnterflächeLand
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitVorleistungRecord
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 (GrundExtern.BasisGrund in KartengrundDatentypen.Kartengrund_Unterfläche_Landbasis_Enum'Range
                  or
                    GrundExtern.BasisGrund = KartengrundDatentypen.Untereis_Enum)
               and
                 (GrundExtern.AktuellerGrund in Kartengrund_Unterfläche_Land_Enum'Range
                  or
                    GrundExtern.AktuellerGrund = KartengrundDatentypen.Untereis_Enum)
              );

   function UnterflächeWasser
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      GrundExtern : in KartenRecords.KartengrundRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return EinheitenRecords.ArbeitVorleistungRecord
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
               and
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 GrundExtern.BasisGrund in KartengrundDatentypen.Kartengrund_Unterfläche_Wasserbasis_Enum'Range
               and
                 GrundExtern.AktuellerGrund in Kartengrund_Unterfläche_Wasser_Enum'Range
              );

   ----------------------- Später Minen für den Kern einbauen?

end AufgabeEinheitMine;
