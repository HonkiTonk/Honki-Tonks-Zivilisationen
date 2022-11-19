with RassenDatentypen;
with SpielVariablen;
with EinheitenRecords;

private with EinheitenDatentypen;
private with KartenRecords;
private with StadtRecords;
private with KartenDatentypen;

private with LeseWeltkarteneinstellungen;

package PZBEingesetztLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Rassen_Enum;
   use type RassenDatentypen.Spieler_Enum;

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
   use type KartenDatentypen.Kartenfeld;

   Einheitenart : EinheitenDatentypen.Einheitart_Enum;

   PZBGezündet : Natural := 0;
   Verbleibendezeit : Natural;

   Einheit : EinheitenRecords.RasseEinheitnummerRecord;

   Stadt : StadtRecords.RasseStadtnummerRecord;

   Kartenwert : KartenRecords.AchsenKartenfeldNaturalRecord;

   type KartengrößenArray is array (EinheitenDatentypen.PZB_Enum'Range) of KartenDatentypen.KartenfeldPositiv;
   Kartengrößen : constant KartengrößenArray := (
                                                     EinheitenDatentypen.PZB_Klein_Enum  => KartenDatentypen.KartenfeldPositiv'Last / 5,
                                                     EinheitenDatentypen.PZB_Mittel_Enum => 400,
                                                     EinheitenDatentypen.PZB_Groß_Enum   => KartenDatentypen.KartenfeldPositiv'Last
                                                    );

   procedure PlanetenVernichten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
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

end PZBEingesetztLogik;
