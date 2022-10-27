pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with EinheitenRecords;
with SpielVariablen;
with KartenDatentypen;
with KartenRecords;
with Weltkarte;

private with EinheitenDatentypen;


package SichtbereicheErmittelnLogik is

   function SichtweiteErmitteln
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KartenDatentypen.Sichtweite
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function SichtbarkeitBlockadeTesten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      YÄnderungExtern : in KartenDatentypen.UmgebungsbereichZwei;
      XÄnderungExtern : in KartenDatentypen.UmgebungsbereichZwei;
      SichtweiteExtern : in KartenDatentypen.UmgebungsbereichDrei)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse in Weltkarte.KarteArray'First (2) .. Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse in Weltkarte.KarteArray'First (3) .. Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );

private
   
   EinheitID : EinheitenDatentypen.EinheitenIDMitNullWert;
   
   Gesamtgrund : KartenRecords.KartengrundRecord;
   
   KoordinatenEinheit : KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenBlockadeWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
end SichtbereicheErmittelnLogik;
