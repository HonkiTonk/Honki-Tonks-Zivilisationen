pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with SpielVariablen;
with EinheitenRecords;

private with EinheitenDatentypen;
private with KartenRecords;
private with Weltkarte;
private with StadtRecords;

package PZBEingesetztLogik is

   function PZBEingesetzt
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
              );

private

   Einheitenart : EinheitenDatentypen.Einheitart_Enum;

   PZBGezündet : Natural := 0;
   Verbleibendezeit : Natural;

   Einheit : EinheitenRecords.RasseEinheitnummerRecord;

   Stadt : StadtRecords.RasseStadtnummerRecord;

   Kartenwert : KartenRecords.AchsenKartenfeldNaturalRecord;

   type KartengrößenArray is array (EinheitenDatentypen.PZB_Enum'Range) of KartenDatentypen.KartenfeldPositiv;
   Kartengrößen : constant KartengrößenArray := (
                                                     EinheitenDatentypen.PZB_Klein_Enum  => 200,
                                                     EinheitenDatentypen.PZB_Mittel_Enum => 400,
                                                     EinheitenDatentypen.PZB_Groß_Enum   => KartenDatentypen.KartenfeldPositiv'Last
                                                    );

   procedure PlanetenVernichten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );

   procedure FeldVernichten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );

end PZBEingesetztLogik;
