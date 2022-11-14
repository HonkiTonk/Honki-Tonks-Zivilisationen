with RassenDatentypen;
with SpielVariablen;

private with KartenRecords;
private with Weltkarte;
private with KartenDatentypen;

package GeheZuGrafik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   procedure GeheZuFestlegung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private
   use type KartenDatentypen.Kartenfeld;
   
   AktuelleSichtweite : KartenDatentypen.KartenfeldPositiv;
   
   Kartenwert : KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenwertKoordinatenberechnung : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   
   
   function Koordinatenberechnung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              ),
         
       Post => (
                  Koordinatenberechnung'Result.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
                and
                  Koordinatenberechnung'Result.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               );

end GeheZuGrafik;
