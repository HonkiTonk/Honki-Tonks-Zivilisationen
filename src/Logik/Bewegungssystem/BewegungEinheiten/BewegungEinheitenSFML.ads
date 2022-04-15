pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;

with KartenRecords; use KartenRecords;
with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;
with TastenbelegungDatentypen;

package BewegungEinheitenSFML is

   procedure BewegungEinheitenRichtung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_Mensch_Enum);
   
private
   
   NullWert : Boolean;
   BewegungNochMöglich : Boolean;
   
   BefehlMaus : TastenbelegungDatentypen.Tastenbelegung_Enum;
   
   MausPosition : Sf.System.Vector2.sfVector2i;
      
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
   
   function EinheitBefehle
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      BefehlExtern : in TastenbelegungDatentypen.Tastenbelegung_Enum)
      return Boolean;
   
   function PositionÄndern
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return Boolean;
   
   function BefehleMaus
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean;
   
   function MausInKarte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean;
   
   function EinheitBewegenMaus
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean;
   
   function MausInAnzeige
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean;

end BewegungEinheitenSFML;
