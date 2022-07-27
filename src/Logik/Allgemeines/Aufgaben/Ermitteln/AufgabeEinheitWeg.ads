pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with KartengrundDatentypen; use KartengrundDatentypen;
with EinheitenRecords;
with SpielVariablen;
with KartenRecords;

private with AufgabenDatentypen;
private with KartenVerbesserungDatentypen;
private with ProduktionDatentypen;

with Karten;

package AufgabeEinheitWeg is

   function WegErmitteln
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

   WegVorhanden : KartenVerbesserungDatentypen.Karten_Weg_Enum;

   WelcherWeg : AufgabenDatentypen.Einheiten_Aufgaben_Enum;
   WelcheArbeit : AufgabenDatentypen.Einheiten_Aufgaben_Enum;

   Arbeitszeit : ProduktionDatentypen.ArbeitszeitVorhanden;

   Arbeitswerte : EinheitenRecords.ArbeitRecord;

   VorhandenerGrund : KartenRecords.KartengrundRecord;

   -- Benutze ich das mehrmals und wenn ja, kann ich es zusammenführen? äöü
   -- Bräuchte ich hier aber in verschiedenen Ausführungen. Vermutlich sinnvoll die alle anzulegen aber wahrscheinlich nicht sie auszulagern. äöü
   type WelcheWegartArray is array (KartenVerbesserungDatentypen.Karten_Weg_Enum'Range) of AufgabenDatentypen.Einheitenbefehle_Wege_Enum;
   WelcheWegart : constant WelcheWegartArray := (
                                                 KartenVerbesserungDatentypen.Leer_Weg_Enum             => AufgabenDatentypen.Straße_Bauen_Enum,
                                                 KartenVerbesserungDatentypen.Karten_Straße_Enum'Range  => AufgabenDatentypen.Schiene_Bauen_Enum,
                                                 KartenVerbesserungDatentypen.Karten_Schiene_Enum'Range => AufgabenDatentypen.Schiene_Bauen_Enum,
                                                 KartenVerbesserungDatentypen.Karten_Tunnel_Enum'Range  => AufgabenDatentypen.Tunnel_Bauen_Enum
                                                );



   function OberflächeLand
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WegExtern : in KartenVerbesserungDatentypen.Karten_Weg_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 (GrundExtern.BasisGrund in KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum'Range
                  or
                    GrundExtern.BasisGrund = KartengrundDatentypen.Eis_Enum)
               and
                 (GrundExtern.AktuellerGrund in KartengrundDatentypen.Kartengrund_Oberfläche_Land_Enum'Range
                  or
                    GrundExtern.BasisGrund = KartengrundDatentypen.Eis_Enum)
              );

   function OberflächeWasser
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WegExtern : in KartenVerbesserungDatentypen.Karten_Weg_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 GrundExtern.BasisGrund in KartengrundDatentypen.Kartengrund_Oberfläche_Wasser_Enum'Range
               and
                 GrundExtern.AktuellerGrund in KartengrundDatentypen.Kartengrund_Oberfläche_Wasser_Enum'Range
              );

   function UnterflächeLand
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WegExtern : in KartenVerbesserungDatentypen.Karten_Weg_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 (GrundExtern.BasisGrund in KartengrundDatentypen.Kartengrund_Unterfläche_Landbasis_Enum'Range
                  or
                    GrundExtern.BasisGrund = KartengrundDatentypen.Untereis_Enum)
               and
                 (GrundExtern.AktuellerGrund in KartengrundDatentypen.Kartengrund_Unterfläche_Landbasis_Enum'Range
                  or
                    GrundExtern.BasisGrund = KartengrundDatentypen.Untereis_Enum)
              );

   function UnterflächeWasser
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WegExtern : in KartenVerbesserungDatentypen.Karten_Weg_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 (GrundExtern.BasisGrund = KartengrundDatentypen.Küstengrund_Enum
                  or
                    GrundExtern.BasisGrund = KartengrundDatentypen.Meeresgrund_Enum)
               and
                 (GrundExtern.AktuellerGrund in KartengrundDatentypen.Kartengrund_Unterfläche_Wasserzusatz_Enum'Range
                  or
                    GrundExtern.BasisGrund = KartengrundDatentypen.Küstengrund_Enum
                  or
                    GrundExtern.BasisGrund = KartengrundDatentypen.Meeresgrund_Enum)
              );

   -- Später Wege für den Kern einbauen? äöü

end AufgabeEinheitWeg;
