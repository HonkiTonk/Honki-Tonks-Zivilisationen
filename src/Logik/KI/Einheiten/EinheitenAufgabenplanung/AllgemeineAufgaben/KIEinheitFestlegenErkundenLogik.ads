with SpeziesDatentypen;
with EinheitenRecords;
with EinheitenKonstanten;

private with KartenRecords;
private with KartenDatentypen;

with LeseGrenzen;
with LeseSpeziesbelegung;

private with LeseWeltkarteneinstellungen;

package KIEinheitFestlegenErkundenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   function Erkunden
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
private
   use type KartenDatentypen.Kartenfeld;
   
   WelcherQuadrant : KartenDatentypen.StandardQuadranten;
   
   YQuadrantenbereich : KartenRecords.AchseAnfangEndeRecord;
   XQuadrantenbereich : KartenRecords.AchseAnfangEndeRecord;
   
   EinheitKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;

   Multiplikator : KartenRecords.YXAchsenKartenfeldRecord;
   
   type QuadrantenDurchgegangenArray is array (KartenDatentypen.StandardQuadranten'Range) of Boolean;
   QuadrantenDurchgegangen : QuadrantenDurchgegangenArray;
   
   
   
   function ZielSuchen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

end KIEinheitFestlegenErkundenLogik;
