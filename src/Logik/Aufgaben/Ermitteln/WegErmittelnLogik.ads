with SpeziesDatentypen;
with KartenDatentypen;
with EinheitenRecords;
with KartenRecords;
with EinheitenKonstanten;

private with AufgabenDatentypen;
private with KartenverbesserungDatentypen;
private with ProduktionDatentypen;
private with KartengrundDatentypen;

with LeseWeltkarteneinstellungen;
with LeseGrenzen;
with LeseSpeziesbelegung;

package WegErmittelnLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;

   function WegErmitteln
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

   WegVorhanden : KartenverbesserungDatentypen.Weg_Enum;

   WelcherWeg : AufgabenDatentypen.Einheiten_Aufgaben_Enum;
   WelcheArbeit : AufgabenDatentypen.Einheiten_Aufgaben_Enum;

   Arbeitszeit : ProduktionDatentypen.Arbeitszeit;

   Arbeitswerte : EinheitenRecords.ArbeitRecord;

   Gesamtgrund : KartenRecords.KartengrundRecord;

   -- Benutze ich das mehrmals und wenn ja, kann ich es zusammenführen? äöü
   -- Bräuchte ich hier aber in verschiedenen Ausführungen. Vermutlich sinnvoll die alle anzulegen aber wahrscheinlich nicht sie auszulagern. äöü
   -- Benutze aber eine kleine Version davon im Wegeplatzierungssystem, eventuell ist da eine Zusammenführung sinnvoll? äöü
   type WelcheWegartArray is array (KartenverbesserungDatentypen.Weg_Enum'Range) of AufgabenDatentypen.Einheitenbefehle_Wege_Enum;
   WelcheWegart : constant WelcheWegartArray := (
                                                 KartenverbesserungDatentypen.Leer_Weg_Enum             => AufgabenDatentypen.Straße_Bauen_Enum,
                                                 KartenverbesserungDatentypen.Straße_Enum'Range  => AufgabenDatentypen.Schiene_Bauen_Enum,
                                                 KartenverbesserungDatentypen.Schiene_Enum'Range => AufgabenDatentypen.Schiene_Bauen_Enum,
                                                 KartenverbesserungDatentypen.Tunnel_Enum'Range  => AufgabenDatentypen.Tunnel_Bauen_Enum
                                                );



   function OberflächeLand
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      WegExtern : in KartenverbesserungDatentypen.Weg_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 (GrundExtern.Basisgrund in KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum'Range
                  or
                    GrundExtern.Basisgrund = KartengrundDatentypen.Eis_Enum)
              );

   function OberflächeWasser
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      WegExtern : in KartenverbesserungDatentypen.Weg_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 GrundExtern.Basisgrund in KartengrundDatentypen.Basisgrund_Oberfläche_Wasser_Enum'Range
              );

   function UnterflächeLand
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      WegExtern : in KartenverbesserungDatentypen.Weg_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 (GrundExtern.Basisgrund in KartengrundDatentypen.Basisgrund_Unterfläche_Land_Enum'Range
                  or
                    GrundExtern.Basisgrund = KartengrundDatentypen.Untereis_Enum)
              );

   function UnterflächeWasser
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      WegExtern : in KartenverbesserungDatentypen.Weg_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 GrundExtern.Basisgrund in KartengrundDatentypen.Basisgrund_Unterfläche_Wasser_Enum'Range
              );

   -- Später Wege für den Kern einbauen? äöü

end WegErmittelnLogik;
