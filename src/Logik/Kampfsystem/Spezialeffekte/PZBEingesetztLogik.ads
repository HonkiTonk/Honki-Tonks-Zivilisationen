-- private with GrenztestsystemHTB2;

with SpeziesDatentypen;
with EinheitenRecords;
with EinheitenKonstanten;

private with KartenRecords;
private with StadtRecords;
private with KartenDatentypen;
private with ZahlenDatentypen;

with LeseGrenzen;
with LeseSpeziesbelegung;

private with LeseWeltkarteneinstellungen;

package PZBEingesetztLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure PZBEingesetzt
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
              );

private
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;

   Verbleibendezeit : ZahlenDatentypen.EigenesNatural;
   EingesetztePZB : ZahlenDatentypen.EigenesNatural;

   Zusammenbruchszeit : ZahlenDatentypen.EigenerInteger;

   Einheit : EinheitenRecords.SpeziesEinheitnummerRecord;

   Stadt : StadtRecords.SpeziesStadtnummerRecord;

   Kartenwert : KartenRecords.KartenfeldNaturalRecord;

   Vernichtungsbereich : KartenRecords.EffektbereichRecord;

   procedure PlanetenVernichten
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      VernichtungsbereichExtern : in KartenRecords.EffektbereichRecord)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   procedure FeldVernichten
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );



   -- function GanzeZahlPrüfen is new GrenztestsystemHTB2.Strichrechnung (GanzeZahl => ZahlenDatentypen.EigenesNatural);

end PZBEingesetztLogik;
