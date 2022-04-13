pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenRecords; use KartenRecords;
with SystemDatentypen; use SystemDatentypen;
with KartenDatentypen; use KartenDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;
with TastenbelegungDatentypen;

package BewegungEinheitenKonsole is

   procedure BewegungEinheitenRichtung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SystemDatentypen.Spieler_Mensch_Enum);
   
private
   
   AufgabeDurchführen : Boolean;
   NullWert : Boolean;
   BewegungNochMöglich : Boolean;
   
   Befehl : TastenbelegungDatentypen.Tastenbelegung_Enum;
      
   Änderung : KartenRecords.AchsenKartenfeldRecord;
   KeineÄnderung : constant KartenRecords.AchsenKartenfeldRecord := (0, 0, 0);

   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   type RichtungArray is array (TastenbelegungDatentypen.Tastenbelegung_Bewegung_Enum'Range) of KartenRecords.AchsenKartenfeldRecord;
   Richtung : constant RichtungArray := (
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

end BewegungEinheitenKonsole;
