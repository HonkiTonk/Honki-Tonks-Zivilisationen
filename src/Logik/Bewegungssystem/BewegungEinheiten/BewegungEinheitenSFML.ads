pragma SPARK_Mode (On);

with Sf.System.Vector2;

with KartenRecords; use KartenRecords;
with SystemDatentypen; use SystemDatentypen;
with KartenDatentypen; use KartenDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;

package BewegungEinheitenSFML is

   procedure BewegungEinheitenRichtung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SystemDatentypen.Spieler_Mensch);
   
private
   
   NullWert : Boolean;
   BewegungNochMöglich : Boolean;
   
   BefehlMaus : SystemDatentypen.Tastenbelegung_Enum;
   
   MausPosition : Sf.System.Vector2.sfVector2i;
      
   Änderung : KartenRecords.AchsenKartenfeldRecord;
   KeineÄnderung : constant KartenRecords.AchsenKartenfeldRecord := (0, 0, 0);

   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   type RichtungArray is array (SystemDatentypen.Tastenbelegung_Bewegung_Enum'Range) of KartenRecords.AchsenKartenfeldRecord;
   Richtung : constant RichtungArray := (
                                         SystemDatentypen.Oben         => (0, -1, 0),
                                         SystemDatentypen.Links        => (0, 0, -1),
                                         SystemDatentypen.Unten        => (0, 1, 0),
                                         SystemDatentypen.Rechts       => (0, 0, 1),
                                         SystemDatentypen.Links_Oben   => (0, -1, -1),
                                         SystemDatentypen.Rechts_Oben  => (0, -1, 1),
                                         SystemDatentypen.Links_Unten  => (0, 1, -1),
                                         SystemDatentypen.Rechts_Unten => (0, 1, 1),
                                         SystemDatentypen.Ebene_Hoch   => (1, 0, 0),
                                         SystemDatentypen.Ebene_Runter => (-1, 0, 0)
                                        );
   
   function EinheitBefehle
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      BefehlExtern : in SystemDatentypen.Tastenbelegung_Enum)
      return Boolean;
   
   function BefehleMaus
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean;
   
   function MausInKarte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean;
   
   function MausInAnzeige
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean;

end BewegungEinheitenSFML;
