pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with TastenbelegungDatentypen;

private with SystemRecords;
private with KartenRecords;

package BewegungCursor is

   procedure CursorbewegungBerechnen
     (RichtungExtern : in TastenbelegungDatentypen.Tastenbelegung_Bewegung_Ebene_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );
   
   procedure ZoomanpassungCursor
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );
     
   procedure GeheZu;

private
   
   AktuelleSichtweite : KartenDatentypen.KartenfeldPositiv;

   KoordinatenPunkt : SystemRecords.ZahlenEingabeRecord;

   NeueKoordinate : KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   Änderung : KartenDatentypen.Ebene;
   
   type RichtungArray is array (TastenbelegungDatentypen.Tastenbelegung_Bewegung_Ebene_Enum'Range) of KartenDatentypen.Ebene;
   Richtung : constant RichtungArray := (
                                         TastenbelegungDatentypen.Ebene_Hoch_Enum   => 1,
                                         TastenbelegungDatentypen.Ebene_Runter_Enum => -1
                                        );
   
end BewegungCursor;
