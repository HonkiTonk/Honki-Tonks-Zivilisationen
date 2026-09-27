with SpeziesDatentypen;
with KartenKonstanten;
with KartenRecords;

with LeseWeltkarteneinstellungen;
with LeseSpeziesbelegung;

package QuadrantenberechnungenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure QuadrantenDurchlaufen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      SichtweiteExtern : in KartenRecords.SichtweitePositiveRecord;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte in KartenKonstanten.AnfangSenkrechte .. LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
private
   
   KartenQuadrantenwert : KartenRecords.KartenfeldNaturalRecord;
   
   procedure QuadrantEins
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      SichtweiteRichtungExtern : in KartenRecords.SichtweiteNaturalRecord;
      SichtweiteExtern : in KartenRecords.SichtweitePositiveRecord;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte in KartenKonstanten.AnfangSenkrechte .. LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   procedure QuadrantZwei
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      SichtweiteRichtungExtern : in KartenRecords.SichtweiteNaturalRecord;
      SichtweiteExtern : in KartenRecords.SichtweitePositiveRecord;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte in KartenKonstanten.AnfangSenkrechte .. LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   procedure QuadrantDrei
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      SichtweiteRichtungExtern : in KartenRecords.SichtweiteNaturalRecord;
      SichtweiteExtern : in KartenRecords.SichtweitePositiveRecord;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte in KartenKonstanten.AnfangSenkrechte .. LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   procedure QuadrantVier
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      SichtweiteRichtungExtern : in KartenRecords.SichtweiteNaturalRecord;
      SichtweiteExtern : in KartenRecords.SichtweitePositiveRecord;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte in KartenKonstanten.AnfangSenkrechte .. LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end QuadrantenberechnungenLogik;
