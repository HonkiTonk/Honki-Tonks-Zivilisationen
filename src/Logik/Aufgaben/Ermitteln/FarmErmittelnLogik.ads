with SpeziesDatentypen;
with KartenDatentypen;
with EinheitenRecords;
with KartenRecords;
with EinheitenKonstanten;

private with AufgabenDatentypen;
private with ProduktionDatentypen;
private with KartengrundDatentypen;

with LeseWeltkarteneinstellungen;
with LeseGrenzen;
with LeseSpeziesbelegung;

package FarmErmittelnLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;
   
   function FarmErmitteln
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
private
   use type KartengrundDatentypen.Basisgrund_Enum;
   
   VorarbeitNötig : Boolean;
   
   WelcheArbeit : AufgabenDatentypen.Einheiten_Aufgaben_Enum;

   Arbeitszeit : ProduktionDatentypen.Arbeitszeit;

   Arbeitswerte : EinheitenRecords.ArbeitVorleistungRecord;
   
   Gesamtgrund : KartenRecords.KartengrundRecord;
   
   function OberflächeLand
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      GrundExtern : in KartenRecords.KartengrundRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return EinheitenRecords.ArbeitVorleistungRecord
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 (GrundExtern.Basisgrund in KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum'Range
                  or
                    GrundExtern.Basisgrund = KartengrundDatentypen.Eis_Enum)
              );

   function UnterflächeLand
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitVorleistungRecord
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 (GrundExtern.Basisgrund in KartengrundDatentypen.Basisgrund_Unterfläche_Land_Enum'Range
                  or
                    GrundExtern.Basisgrund = KartengrundDatentypen.Untereis_Enum)
              );

   function UnterflächeWasser
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      GrundExtern : in KartenRecords.KartengrundRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return EinheitenRecords.ArbeitVorleistungRecord
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 GrundExtern.Basisgrund in KartengrundDatentypen.Basisgrund_Unterfläche_Wasser_Enum'Range
              );

   -- Später Farmen für den Kern einbauen? äöü
   
end FarmErmittelnLogik;
