with SpeziesDatentypen;

private with KartenRecords;
private with KartenDatentypen;

with LeseSpeziesbelegung;

private with LeseWeltkarteneinstellungen;

package GeheZuGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure GeheZuFestlegung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
private
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;
   
   AktuelleSichtweite : KartenRecords.YXAchsenKartenfeldPositivRecord;
   
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
