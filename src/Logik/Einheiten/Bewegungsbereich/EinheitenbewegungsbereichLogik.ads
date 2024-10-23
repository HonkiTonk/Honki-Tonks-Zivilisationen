with EinheitenRecords;
with SpeziesDatentypen;
with EinheitenKonstanten;
with KartenDatentypen;

private with KartenRecords;
private with SystemDatentypen;
private with StadtRecords;

with LeseGrenzen;
with LeseSpeziesbelegung;

private with LeseWeltkarteneinstellungen;

package EinheitenbewegungsbereichLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   -- Das hier mal woanders hinschieben. Karte oder Einheit? äöü
   type BewegungsbereichArray is array (KartenDatentypen.EbeneVorhanden'Range, KartenDatentypen.SenkrechtePositiv'Range, KartenDatentypen.WaagerechtePositiv'Range) of Boolean;
   Bewegungsbereich : BewegungsbereichArray := (others => (others => (others => False)));

   procedure BewegungsbereichBerechnen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

private
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;

   ZusätzlicheBewegungspunkte : Positive;
   ZwischenrechnungBewegungspunkte : Positive;

   VorhandeneBewegungspunkte : Natural;

   Stadt : StadtRecords.SpeziesStadtnummerRecord;

   Einheit : EinheitenRecords.SpeziesEinheitnummerRecord;

   AktuelleKoordinaten : KartenRecords.KartenfeldNaturalRecord;
   Kartenwert : KartenRecords.KartenfeldNaturalRecord;

   procedure BewegungsbereichErmitteln
     (BewegungsfeldExtern : in KartenRecords.KartenfeldRecord;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      NotwendigeBewegungspunkteExtern : in Natural;
      VorhandeneBewegungspunkteExtern : in Positive)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );



   function FeldPrüfen
     (NeueKoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      NotwendigeBewegungspunkteExtern : in Natural;
      VorhandeneBewegungspunkteExtern : in Positive)
      return SystemDatentypen.Erweiterter_Boolean_Enum
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 NeueKoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 NeueKoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

end EinheitenbewegungsbereichLogik;
