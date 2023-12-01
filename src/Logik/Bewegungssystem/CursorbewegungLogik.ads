with SpeziesDatentypen;
with TastenbelegungDatentypen;

private with SystemRecords;
private with KartenRecords;
private with KartenRecordKonstanten;

with LeseSpeziesbelegung;

package CursorbewegungLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure CursorbewegungBerechnen
     (RichtungExtern : in TastenbelegungDatentypen.Tastenbelegung_Bewegung_Erweitert_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
     
   procedure GeheZu;

private
   
   KoordinatenPunkt : SystemRecords.ZahlenEingabeRecord;

   NeueKoordinate : KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   BasisKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   type RichtungArray is array (TastenbelegungDatentypen.Tastenbelegung_Bewegung_Erweitert_Enum'Range) of KartenRecords.AchsenKartenfeldRecord;
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
   
end CursorbewegungLogik;
