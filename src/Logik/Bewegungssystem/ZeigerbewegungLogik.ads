private with SystemRecordsHTSEB;

with SpeziesDatentypen;
with TastenbelegungDatentypen;

private with KartenRecords;
private with KartenRecordKonstanten;

with LeseSpeziesbelegung;

package ZeigerbewegungLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure ZeigerbewegungBerechnen
     (RichtungExtern : in TastenbelegungDatentypen.Tastenbelegung_Bewegung_Erweitert_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
     
   procedure GeheZu;

private
   
   KoordinatenPunkt : SystemRecordsHTSEB.ZahlenEingabeRecord;

   NeueKoordinate : KartenRecords.KartenfeldNaturalRecord;
   KartenWert : KartenRecords.KartenfeldNaturalRecord;
   BasisKoordinaten : KartenRecords.KartenfeldNaturalRecord;
   
   type RichtungArray is array (TastenbelegungDatentypen.Tastenbelegung_Bewegung_Erweitert_Enum'Range) of KartenRecords.KartenfeldRecord;
   Richtung : constant RichtungArray := (
                                         TastenbelegungDatentypen.Auswählen_Enum    => KartenRecordKonstanten.LeerKoordinatenänderung,
                                         
                                         TastenbelegungDatentypen.Oben_Enum         => KartenRecordKonstanten.Nordbewegung,
                                         TastenbelegungDatentypen.Links_Enum        => KartenRecordKonstanten.Westbewegung,
                                         TastenbelegungDatentypen.Unten_Enum        => KartenRecordKonstanten.Südbewegung,
                                         TastenbelegungDatentypen.Rechts_Enum       => KartenRecordKonstanten.OstBewegung,
                                         TastenbelegungDatentypen.Links_Oben_Enum   => KartenRecordKonstanten.Nordwestbewegung,
                                         TastenbelegungDatentypen.Rechts_Oben_Enum  => KartenRecordKonstanten.Nordostbewegung,
                                         TastenbelegungDatentypen.Links_Unten_Enum  => KartenRecordKonstanten.Südwestbewegung,
                                         TastenbelegungDatentypen.Rechts_Unten_Enum => KartenRecordKonstanten.Südostbewegung,
                                         
                                         TastenbelegungDatentypen.Ebene_Hoch_Enum   => KartenRecordKonstanten.EbeneHoch,
                                         TastenbelegungDatentypen.Ebene_Runter_Enum => KartenRecordKonstanten.EbeneRunter
                                        );
   
end ZeigerbewegungLogik;
