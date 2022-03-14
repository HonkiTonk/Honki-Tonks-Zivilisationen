pragma SPARK_Mode (On);

with Sf.System.Vector2;

with KartenRecords; use KartenRecords;
with SystemDatentypen; use SystemDatentypen;
with KartenDatentypen; use KartenDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;
with SystemKonstanten;
with TastenbelegungDatentypen;
with TastenbelegungKonstanten;

package BewegungEinheitenSFML is

   procedure BewegungEinheitenRichtung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SystemKonstanten.SpielerMenschKonstante);
   
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
                                         TastenbelegungKonstanten.ObenKonstante        => (0, -1, 0),
                                         TastenbelegungKonstanten.LinksKonstante       => (0, 0, -1),
                                         TastenbelegungKonstanten.UntenKonstante       => (0, 1, 0),
                                         TastenbelegungKonstanten.RechtsKonstante      => (0, 0, 1),
                                         TastenbelegungKonstanten.LinksObenKonstante   => (0, -1, -1),
                                         TastenbelegungKonstanten.RechtsObenKonstante  => (0, -1, 1),
                                         TastenbelegungKonstanten.LinksUntenKonstante  => (0, 1, -1),
                                         TastenbelegungKonstanten.RechtsUntenKonstante => (0, 1, 1),
                                         TastenbelegungKonstanten.EbeneHochKonstante   => (1, 0, 0),
                                         TastenbelegungKonstanten.EbeneRunterKonstante => (-1, 0, 0)
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
