pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Calendar;

private with Sf.System.Vector2;

with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with EinheitenDatentypen; use EinheitenDatentypen;
with SpielVariablen;
with EinheitenRecords;

private with KartenRecords;
private with Weltkarte;

package CursorplatzierungAltGrafik is

   procedure CursorplatzierungAlt
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer <= SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   EinheitFolgen : Boolean;
   
   AktuelleSichtweite : KartenDatentypen.KartenfeldPositiv;
   
   XAchsenbereich : Float;
         
   Scrollzeit : Ada.Calendar.Time := Ada.Calendar.Clock;
   
   Mausposition : Sf.System.Vector2.sfVector2f;
   Viewfläche : Sf.System.Vector2.sfVector2f;
   Viewzentrum : Sf.System.Vector2.sfVector2f;
   Achsenviewfläche : Sf.System.Vector2.sfVector2f;
   
   Kartenwert : KartenRecords.AchsenKartenfeldNaturalRecord;
   Einheitenkoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   Koordinatenänderung : KartenRecords.AchsenKartenfeldRecord;
   
   procedure Platzierung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer <= SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );
   
   
   
   function BefehlsknöpfePrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer <= SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );
   
   function Einheitenbereich
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer <= SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );
         
   function AlteYAchseFestlegen
     (MauspositionExtern : in Sf.System.Vector2.sfVector2f;
      YAchseAltExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.UmgebungsbereichEins
     with
       Pre => (
                 YAchseAltExtern <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
              );
   
   function AlteXAchseFestlegen
     (MausachseExtern : in Float;
      XAchseAltExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.UmgebungsbereichEins
     with
       Pre => (
                 XAchseAltExtern <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );

end CursorplatzierungAltGrafik;
