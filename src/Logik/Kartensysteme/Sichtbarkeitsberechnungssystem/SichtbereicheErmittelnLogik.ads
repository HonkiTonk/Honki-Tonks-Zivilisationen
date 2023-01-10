with SpeziesDatentypen;
with EinheitenRecords;
with KartenDatentypen;
with KartenRecords;
with KartenKonstanten;
with EinheitenKonstanten;

private with EinheitenDatentypen;

with LeseWeltkarteneinstellungen;
with LeseGrenzen;
with LeseSpeziesbelegung;

package SichtbereicheErmittelnLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   function SichtweiteErmitteln
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KartenDatentypen.Sichtweite
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function SichtbarkeitBlockadeTesten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      YÄnderungExtern : in KartenDatentypen.UmgebungsbereichZwei;
      XÄnderungExtern : in KartenDatentypen.UmgebungsbereichZwei;
      SichtweiteExtern : in KartenDatentypen.UmgebungsbereichDrei)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse
              );

private
   
   EinheitID : EinheitenDatentypen.EinheitenIDMitNullWert;
   
   Gesamtgrund : KartenRecords.KartengrundRecord;
   
   KoordinatenEinheit : KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenBlockadeWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
end SichtbereicheErmittelnLogik;
