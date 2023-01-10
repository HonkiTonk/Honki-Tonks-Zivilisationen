with SpeziesDatentypen;
with EinheitenRecords;
with EinheitenKonstanten;

private with EinheitenDatentypen;
private with KartenRecords;
private with StadtRecords;
private with KartenDatentypen;
private with ZahlenDatentypen;

with LeseGrenzen;
with LeseSpeziesbelegung;

private with LeseWeltkarteneinstellungen;

private with Grenzpruefungen;

package PZBEingesetztLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spezies_Enum;
   use type SpeziesDatentypen.Spieler_Enum;

   function PZBEingesetzt
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
              );

private
   use type KartenDatentypen.Kartenfeld;

   Einheitenart : EinheitenDatentypen.Einheitart_Enum;

   EinheitenID : EinheitenDatentypen.EinheitenIDMitNullWert;

   Verbleibendezeit : ZahlenDatentypen.EigenesNatural;
   EingesetztePZB : ZahlenDatentypen.EigenesNatural;

   Zusammenbruchszeit : ZahlenDatentypen.EigenerInteger;

   Einheit : EinheitenRecords.SpeziesEinheitnummerRecord;

   Stadt : StadtRecords.SpeziesStadtnummerRecord;

   Kartenwert : KartenRecords.AchsenKartenfeldNaturalRecord;

   Vernichtungsbereich : KartenRecords.EffektbereichRecord;

   procedure PlanetenVernichten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      VernichtungsbereichExtern : in KartenRecords.EffektbereichRecord)
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
