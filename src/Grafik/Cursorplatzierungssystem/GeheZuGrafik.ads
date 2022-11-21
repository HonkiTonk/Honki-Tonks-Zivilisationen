with RassenDatentypen;
with SpielVariablen;

private with KartenRecords;
private with KartenDatentypen;

private with LeseWeltkarteneinstellungen;

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
   
   YAchseÜbergänge : KartenRecords.KartenformYAchseRecord;
   XAchseÜbergänge : KartenRecords.KartenformXAchseRecord;
   
   Kartenwert : KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenwertKoordinatenberechnung : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   
   
   function Koordinatenberechnung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              ),
         
       Post => (
                  Koordinatenberechnung'Result.YAchse <= LeseWeltkarteneinstellungen.YAchse
                and
                  Koordinatenberechnung'Result.XAchse <= LeseWeltkarteneinstellungen.XAchse
               );

end GeheZuGrafik;
