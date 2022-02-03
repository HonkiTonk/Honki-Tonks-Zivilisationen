pragma SPARK_Mode (On);

with KartenRecords; use KartenRecords;
with SystemDatentypen; use SystemDatentypen;
with KartenDatentypen; use KartenDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;
with SystemKonstanten;

package BewegungEinheitenKonsole is

   procedure BewegungEinheitenRichtung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SystemKonstanten.SpielerMenschKonstante);
   
private
   
   AufgabeDurchführen : Boolean;
   NullWert : Boolean;
   BewegungNochMöglich : Boolean;
   
   Befehl : SystemDatentypen.Tastenbelegung_Enum;
      
   Änderung : KartenRecords.AchsenKartenfeldRecord;
   KeineÄnderung : constant KartenRecords.AchsenKartenfeldRecord := (0, 0, 0);

   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   type RichtungArray is array (SystemDatentypen.Tastenbelegung_Bewegung_Enum'Range) of KartenRecords.AchsenKartenfeldRecord;
   Richtung : constant RichtungArray := (
                                         SystemKonstanten.ObenKonstante        => (0, -1, 0),
                                         SystemKonstanten.LinksKonstante       => (0, 0, -1),
                                         SystemKonstanten.UntenKonstante       => (0, 1, 0),
                                         SystemKonstanten.RechtsKonstante      => (0, 0, 1),
                                         SystemKonstanten.LinksObenKonstante   => (0, -1, -1),
                                         SystemKonstanten.RechtsObenKonstante  => (0, -1, 1),
                                         SystemKonstanten.LinksUntenKonstante  => (0, 1, -1),
                                         SystemKonstanten.RechtsUntenKonstante => (0, 1, 1),
                                         SystemKonstanten.EbeneHochKonstante   => (1, 0, 0),
                                         SystemKonstanten.EbeneRunterKonstante => (-1, 0, 0)
                                        );

end BewegungEinheitenKonsole;
