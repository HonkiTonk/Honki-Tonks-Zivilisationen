with KartenDatentypen;
with RassenDatentypen;
with KartenRecords;
with EinheitenDatentypen;
with SpielVariablen;
with Weltkarte;

package StadtumgebungErreichbarLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;
   
   function UmgebungErreichbar
     (AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      NotwendigeFelderExtern : in Positive)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 AktuelleKoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 AktuelleKoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               and
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              ),
           
       Post => (
                  UmgebungErreichbar'Result.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
                and
                  UmgebungErreichbar'Result.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               );
   
private
   
   BereitsGetestet : KartenDatentypen.UmgebungsbereichZwei;
   Umgebung : KartenDatentypen.UmgebungsbereichDrei;
   
   GefundeneFelder : Positive;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenWertZwei : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   function NochErreichbar
     (AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return Boolean
     with
       Pre => (
                 AktuelleKoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 AktuelleKoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               and
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

end StadtumgebungErreichbarLogik;
