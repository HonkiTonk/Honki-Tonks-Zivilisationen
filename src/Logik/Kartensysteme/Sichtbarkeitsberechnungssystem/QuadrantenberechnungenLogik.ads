with SpeziesDatentypen;
with KartenKonstanten;
with KartenRecords;
with KartenDatentypen;

with LeseWeltkarteneinstellungen;
with LeseSpeziesbelegung;

package QuadrantenberechnungenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure QuadrantenDurchlaufen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      SichtweiteExtern : in KartenDatentypen.SenkrechteSichtweite;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
private
   
   KartenQuadrantWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   procedure QuadrantEins
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      SichtweiteRichtungExtern : in KartenRecords.SichtweiteNaturalRecord;
      SichtweiteExtern : in KartenDatentypen.SenkrechteSichtweite;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   procedure QuadrantZwei
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      SichtweiteRichtungExtern : in KartenRecords.SichtweiteNaturalRecord;
      SichtweiteExtern : in KartenDatentypen.SenkrechteSichtweite;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   procedure QuadrantDrei
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      SichtweiteRichtungExtern : in KartenRecords.SichtweiteNaturalRecord;
      SichtweiteExtern : in KartenDatentypen.SenkrechteSichtweite;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   procedure QuadrantVier
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      SichtweiteRichtungExtern : in KartenRecords.SichtweiteNaturalRecord;
      SichtweiteExtern : in KartenDatentypen.SenkrechteSichtweite;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end QuadrantenberechnungenLogik;
