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
   type BewegungsbereichArray is array (KartenDatentypen.EbeneVorhanden'Range, KartenDatentypen.KartenfeldPositiv'Range, KartenDatentypen.KartenfeldPositiv'Range) of Boolean;
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
   use type KartenDatentypen.Kartenfeld;

   ZusätzlicheBewegungspunkte : Positive;
   ZwischenrechnungBewegungspunkte : Positive;

   VorhandeneBewegungspunkte : Natural;

   Stadt : StadtRecords.SpeziesStadtnummerRecord;

   Einheit : EinheitenRecords.SpeziesEinheitnummerRecord;

   AktuelleKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   Kartenwert : KartenRecords.AchsenKartenfeldNaturalRecord;

   procedure BewegungsbereichErmitteln
     (BewegungsfeldExtern : in KartenRecords.AchsenKartenfeldRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      NotwendigeBewegungspunkteExtern : in Natural;
      VorhandeneBewegungspunkteExtern : in Positive)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );



   function FeldPrüfen
     (NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
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
                 NeueKoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 NeueKoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

end EinheitenbewegungsbereichLogik;
