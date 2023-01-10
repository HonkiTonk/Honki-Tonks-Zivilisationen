with KartenDatentypen;
with SpeziesDatentypen;
with KartenRecords;
with EinheitenDatentypen;

with LeseWeltkarteneinstellungen;
with LeseSpeziesbelegung;

package StadtumgebungErreichbarLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;
   
   function UmgebungErreichbar
     (AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      NotwendigeFelderExtern : in Positive)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 AktuelleKoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 AktuelleKoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
           
       Post => (
                  UmgebungErreichbar'Result.YAchse <= LeseWeltkarteneinstellungen.YAchse
                and
                  UmgebungErreichbar'Result.XAchse <= LeseWeltkarteneinstellungen.XAchse
               );
   
private
   
   BereitsGetestet : KartenDatentypen.UmgebungsbereichZwei;
   Umgebung : KartenDatentypen.UmgebungsbereichDrei;
   
   GefundeneFelder : Positive;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenWertZwei : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   function NochErreichbar
     (AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return Boolean
     with
       Pre => (
                 AktuelleKoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 AktuelleKoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end StadtumgebungErreichbarLogik;
