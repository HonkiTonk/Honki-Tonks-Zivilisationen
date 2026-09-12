private with GanzzahltestsHTSEB;

with SpeziesDatentypen;
with KartenDatentypen;
with EinheitenRecords;
with KartenRecords;
with EinheitenKonstanten;

private with AufgabenDatentypen;
private with ProduktionDatentypen;
private with KartenbasisgrundDatentypen;
private with KartenwegeDatentypen;

with LeseWeltkarteneinstellungen;
with LeseGrenzen;
with LeseSpeziesbelegung;

package WegErmittelnLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;

   function WegErmitteln
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

   WegVorhanden : KartenwegeDatentypen.Weg_Enum;

   WelcherWeg : AufgabenDatentypen.Einheiten_Aufgaben_Enum;
   WelcheArbeit : AufgabenDatentypen.Einheiten_Aufgaben_Enum;

   Arbeitszeit : ProduktionDatentypen.ArbeitszeitBasis;

   Arbeitswerte : EinheitenRecords.ArbeitRecord;

   Gesamtgrund : KartenRecords.KartengrundRecord;

   -- Benutze ich das mehrmals und wenn ja, kann ich es zusammenführen? äöü
   -- Bräuchte ich hier aber in verschiedenen Ausführungen. Vermutlich sinnvoll die alle anzulegen aber wahrscheinlich nicht sie auszulagern. äöü
   -- Benutze aber eine kleine Version davon im Wegeplatzierungssystem, eventuell ist da eine Zusammenführung sinnvoll? äöü
   type WelcheWegartArray is array (KartenwegeDatentypen.Weg_Enum'Range) of AufgabenDatentypen.Einheitenbefehle_Wege_Enum;
   WelcheWegart : constant WelcheWegartArray := (
                                                 KartenwegeDatentypen.Leer_Weg_Enum      => AufgabenDatentypen.Straße_Bauen_Enum,
                                                 KartenwegeDatentypen.Straße_Enum'Range  => AufgabenDatentypen.Schiene_Bauen_Enum,
                                                 KartenwegeDatentypen.Schiene_Enum'Range => AufgabenDatentypen.Schiene_Bauen_Enum,
                                                 KartenwegeDatentypen.Tunnel_Enum'Range  => AufgabenDatentypen.Tunnel_Bauen_Enum
                                                );



   function OberflächeLand
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      WegExtern : in KartenwegeDatentypen.Weg_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 (GrundExtern.Basisgrund in KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum'Range
                  or
                    GrundExtern.Basisgrund = KartenbasisgrundDatentypen.Eis_Enum)
              );

   function OberflächeWasser
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      WegExtern : in KartenwegeDatentypen.Weg_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 GrundExtern.Basisgrund in KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Wasser_Enum'Range
              );

   function UnterflächeLand
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      WegExtern : in KartenwegeDatentypen.Weg_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 (GrundExtern.Basisgrund in KartenbasisgrundDatentypen.Basisgrund_Unterfläche_Land_Enum'Range
                  or
                    GrundExtern.Basisgrund = KartenbasisgrundDatentypen.Untereis_Enum)
              );

   function UnterflächeWasser
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      WegExtern : in KartenwegeDatentypen.Weg_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 GrundExtern.Basisgrund in KartenbasisgrundDatentypen.Basisgrund_Unterfläche_Wasser_Enum'Range
              );

   function ArbeitszeitPrüfen is new GanzzahltestsHTSEB.StrichrechnungPositive (GanzeZahl => ProduktionDatentypen.ArbeitszeitBasis);

   -- Später Wege für den Kern einbauen? äöü

end WegErmittelnLogik;
