private with GanzzahltestsHTSEB;

with SpeziesDatentypen;
with KartenDatentypen;
with EinheitenRecords;
with KartenRecords;
with EinheitenKonstanten;

private with AufgabenDatentypen;
private with KartenverbesserungDatentypen;
private with ProduktionDatentypen;
private with KartenbasisgrundDatentypen;

with LeseWeltkarteneinstellungen;
with LeseGrenzen;
with LeseSpeziesbelegung;

package WaldErmittelnLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;

   function WaldErmitteln
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

private
   use type KartenbasisgrundDatentypen.Basisgrund_Enum;

   VorarbeitNötig : Boolean;

   VorhandeneVerbesserung : KartenverbesserungDatentypen.Verbesserung_Enum;

   WelcheArbeit : AufgabenDatentypen.Einheiten_Aufgaben_Enum;

   Arbeitszeit : ProduktionDatentypen.ArbeitszeitBasis;

   Arbeitswerte : EinheitenRecords.ArbeitVorleistungRecord;

   Gesamtgrund : KartenRecords.KartengrundRecord;

   function OberflächeLand
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      GrundExtern : in KartenRecords.KartengrundRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return EinheitenRecords.ArbeitVorleistungRecord
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 (GrundExtern.Basisgrund in KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum'Range
                  or
                    GrundExtern.Basisgrund = KartenbasisgrundDatentypen.Eis_Enum)
              );

   function UnterflächeWasser
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      GrundExtern : in KartenRecords.KartengrundRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return EinheitenRecords.ArbeitVorleistungRecord
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 GrundExtern.Basisgrund in KartenbasisgrundDatentypen.Basisgrund_Unterfläche_Wasser_Enum'Range
              );

   function ArbeitszeitPrüfen is new GanzzahltestsHTSEB.StrichrechnungPositive (GanzeZahl => ProduktionDatentypen.ArbeitszeitBasis);

end WaldErmittelnLogik;
