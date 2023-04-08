with KartenRecords;
with EinheitenRecords;
with EinheitenKonstanten;
with SpeziesDatentypen;
with KartenDatentypen;

private with StadtRecords;
private with StadtDatentypen;
private with StadtKonstanten;

with LeseGrenzen;
with LeseSpeziesbelegung;
with LeseWeltkarteneinstellungen;

package KIEinheitFestlegenWegeLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Kartenfeld;
   use type SpeziesDatentypen.Spieler_Enum;

   function WegAnlegbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
   function StädteVerbinden
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
private
   
   WegGefunden : Boolean;
   
   Stadtgrenze : StadtDatentypen.MaximaleStädteMitNullWert;
   
   KoordinatenAnfangsstadt : KartenRecords.AchsenKartenfeldNaturalRecord;
   KoordinatenEndstadt : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   
   
   function VerbindungMöglich
     (AnfangsstadtExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EndstadtExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 AnfangsstadtExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => AnfangsstadtExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => AnfangsstadtExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
               and
                 EndstadtExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => EndstadtExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EndstadtExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
               and
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );

end KIEinheitFestlegenWegeLogik;
