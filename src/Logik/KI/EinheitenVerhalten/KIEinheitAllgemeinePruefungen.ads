pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with KartenRecords;
with EinheitenRecords;

private with KartengrundDatentypen;

with Karten;

package KIEinheitAllgemeinePruefungen is
   
   function KartenfeldPrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
               and
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );
   
   function AktuellUnpassierbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
               and
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.KI_Spieler_Enum
              );
   
private
   
   UmgebungPrüfen : KartenDatentypen.UmgebungsbereichDrei;
   BereitsGeprüft : KartenDatentypen.UmgebungsbereichDrei;
   
   BlockierteFelder : KartenDatentypen.KartenfeldNatural;
   
   WelcherGrund : KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
   
   EinheitAufFeld : EinheitenRecords.RasseEinheitnummerRecord;
   
   Wasserumgebung : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   
   
   function FeldUnpassierbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.SichtweiteNatural
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
               and
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.KI_Spieler_Enum
              ),
         
       Post => (
                  FeldUnpassierbar'Result <= 1
               );

end KIEinheitAllgemeinePruefungen;
