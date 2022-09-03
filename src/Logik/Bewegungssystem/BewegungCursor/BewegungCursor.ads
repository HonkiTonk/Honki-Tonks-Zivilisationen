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
     (RichtungExtern : in TastenbelegungDatentypen.Tastenbelegung_Bewegung_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
   procedure ZoomanpassungCursor
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );
     
   procedure GeheZu;

private
   
   AktuelleSichtweite : KartenDatentypen.KartenfeldPositiv;

   KoordinatenPunkt : SystemRecords.ZahlenEingabeRecord;

   NeueKoordinate : KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   Änderung : KartenDatentypen.Ebene;
   
   type RichtungArray is array (TastenbelegungDatentypen.Tastenbelegung_Bewegung_Enum'Range) of KartenDatentypen.Ebene;
   Richtung : constant RichtungArray := (
                                         TastenbelegungDatentypen.Ebene_Hoch_Enum   => 1,
                                         TastenbelegungDatentypen.Ebene_Runter_Enum => -1,
                                         others                                     => (-3)
                                        );
   
end BewegungCursor;
