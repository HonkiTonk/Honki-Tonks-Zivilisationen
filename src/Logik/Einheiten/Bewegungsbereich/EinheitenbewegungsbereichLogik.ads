with EinheitenRecords;
with RassenDatentypen;
with EinheitenKonstanten;
with KartenDatentypen;

private with KartenRecords;
private with SystemDatentypen;
private with StadtRecords;

with LeseGrenzen;
with LeseRassenbelegung;

private with LeseWeltkarteneinstellungen;

package EinheitenbewegungsbereichLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   -- Das hier mal woanders hinschieben. Karte oder Einheit? äöü
   type BewegungsbereichArray is array (KartenDatentypen.EbeneVorhanden'Range, KartenDatentypen.KartenfeldPositiv'Range, KartenDatentypen.KartenfeldPositiv'Range) of Boolean;
   Bewegungsbereich : BewegungsbereichArray := (others => (others => (others => False)));

   procedure BewegungsbereichBerechnen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
              );

private
   use type KartenDatentypen.Kartenfeld;

   ZusätzlicheBewegungspunkte : Positive;
   ZwischenrechnungBewegungspunkte : Positive;

   VorhandeneBewegungspunkte : Natural;

   Stadt : StadtRecords.RasseStadtnummerRecord;

   Einheit : EinheitenRecords.RasseEinheitnummerRecord;

   AktuelleKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   Kartenwert : KartenRecords.AchsenKartenfeldNaturalRecord;

   procedure BewegungsbereichErmitteln
     (BewegungsfeldExtern : in KartenRecords.AchsenKartenfeldRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NotwendigeBewegungspunkteExtern : in Natural;
      VorhandeneBewegungspunkteExtern : in Positive)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );



   function FeldPrüfen
     (NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NotwendigeBewegungspunkteExtern : in Natural;
      VorhandeneBewegungspunkteExtern : in Positive)
      return SystemDatentypen.Erweiterter_Boolean_Enum
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
               and
                 NeueKoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 NeueKoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

end EinheitenbewegungsbereichLogik;
