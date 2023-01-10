with SpeziesDatentypen;
with TastenbelegungDatentypen;

private with SystemRecords;
private with KartenRecords;
private with KartenDatentypen;

with LeseSpeziesbelegung;

package CursorbewegungLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure CursorbewegungBerechnen
     (RichtungExtern : in TastenbelegungDatentypen.Tastenbelegung_Bewegung_Erweitert_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
     
   procedure GeheZu;

private
   use type KartenDatentypen.Kartenfeld;
   use type KartenDatentypen.Ebene;
   
   KoordinatenPunkt : SystemRecords.ZahlenEingabeRecord;

   NeueKoordinate : KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   BasisKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   type RichtungArray is array (TastenbelegungDatentypen.Tastenbelegung_Bewegung_Erweitert_Enum'Range) of KartenRecords.AchsenKartenfeldRecord;
   Richtung : constant RichtungArray := (
                                         TastenbelegungDatentypen.Auswählen_Enum    => (0, 0, 0),
                                         
                                         TastenbelegungDatentypen.Oben_Enum         => (0, -1, 0),
                                         TastenbelegungDatentypen.Links_Enum        => (0, 0, -1),
                                         TastenbelegungDatentypen.Unten_Enum        => (0, 1, 0),
                                         TastenbelegungDatentypen.Rechts_Enum       => (0, 0, 1),
                                         TastenbelegungDatentypen.Links_Oben_Enum   => (0, -1, -1),
                                         TastenbelegungDatentypen.Rechts_Oben_Enum  => (0, -1, 1),
                                         TastenbelegungDatentypen.Links_Unten_Enum  => (0, 1, -1),
                                         TastenbelegungDatentypen.Rechts_Unten_Enum => (0, 1, 1),
                                         
                                         TastenbelegungDatentypen.Ebene_Hoch_Enum   => (1, 0, 0),
                                         TastenbelegungDatentypen.Ebene_Runter_Enum => (-1, 0, 0)
                                        );
   
end CursorbewegungLogik;
