with RassenDatentypen;
with EinheitenRecords;
with EinheitenKonstanten;

private with EinheitenDatentypen;
private with KartenRecords;
private with StadtRecords;
private with KartenDatentypen;
private with ZahlenDatentypen;

with LeseGrenzen;
with LeseRassenbelegung;

private with LeseWeltkarteneinstellungen;

private with Grenzpruefungen;

package PZBEingesetztLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Rassen_Enum;
   use type RassenDatentypen.Spieler_Enum;

   function PZBEingesetzt
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
              );

private
   use type KartenDatentypen.Kartenfeld;

   Einheitenart : EinheitenDatentypen.Einheitart_Enum;

   EinheitenID : EinheitenDatentypen.EinheitenIDMitNullWert;

   Verbleibendezeit : ZahlenDatentypen.EigenesNatural;
   EingesetztePZB : ZahlenDatentypen.EigenesNatural;

   Zusammenbruchszeit : ZahlenDatentypen.EigenerInteger;

   Einheit : EinheitenRecords.RasseEinheitnummerRecord;

   Stadt : StadtRecords.RasseStadtnummerRecord;

   Kartenwert : KartenRecords.AchsenKartenfeldNaturalRecord;
   Vernichtungsbereich : KartenRecords.AchsenKartenfeldNaturalRecord;

   procedure PlanetenVernichten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      VernichtungsbereichExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

   procedure FeldVernichten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );



   function GanzeZahlPrüfen is new Grenzpruefungen.Standardprüfung (GanzeZahl => ZahlenDatentypen.EigenesNatural);

end PZBEingesetztLogik;
