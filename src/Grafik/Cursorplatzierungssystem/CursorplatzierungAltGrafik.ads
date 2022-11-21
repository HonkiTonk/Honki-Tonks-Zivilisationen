private with Ada.Calendar;

private with Sf.System.Vector2;

with RassenDatentypen;
with SpielVariablen;
with EinheitenRecords;
with EinheitenDatentypen;

private with KartenRecords;
private with KartenDatentypen;

with LeseGrenzen;

private with LeseWeltkarteneinstellungen;

package CursorplatzierungAltGrafik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;

   procedure CursorplatzierungAlt
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer <= LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private
   use type KartenDatentypen.Kartenfeld;
   
   EinheitFolgen : Boolean;
   
   AktuelleSichtweite : KartenDatentypen.KartenfeldPositiv;
   
   XAchsenbereich : Float;
         
   Scrollzeit : Ada.Calendar.Time := Ada.Calendar.Clock;
   
   XAchseÜbergänge : KartenRecords.KartenformXAchseRecord;
   
   Mausposition : Sf.System.Vector2.sfVector2f;
   Viewfläche : Sf.System.Vector2.sfVector2f;
   Viewzentrum : Sf.System.Vector2.sfVector2f;
   Achsenviewfläche : Sf.System.Vector2.sfVector2f;
   
   Kartenwert : KartenRecords.AchsenKartenfeldNaturalRecord;
   Einheitenkoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   AlteCursorkoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   Koordinatenänderung : KartenRecords.AchsenKartenfeldRecord;
   
   procedure Platzierung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer <= LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );
   
   
   
   function BefehlsknöpfePrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer <= LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );
   
   function Einheitenbereich
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer <= LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );
         
   function AlteYAchseFestlegen
     (MauspositionExtern : in Sf.System.Vector2.sfVector2f;
      YAchseAltExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.UmgebungsbereichEins
     with
       Pre => (
                 YAchseAltExtern <= LeseWeltkarteneinstellungen.YAchse
              );
   
   function AlteXAchseFestlegen
     (MausachseExtern : in Float;
      XAchseAltExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.UmgebungsbereichEins
     with
       Pre => (
                 XAchseAltExtern <= LeseWeltkarteneinstellungen.XAchse
              );

end CursorplatzierungAltGrafik;
