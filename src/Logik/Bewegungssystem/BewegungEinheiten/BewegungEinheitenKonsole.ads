pragma SPARK_Mode (On);

with KartenRecords; use KartenRecords;
with SystemDatentypen; use SystemDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;

package BewegungEinheitenKonsole is

   procedure BewegungEinheitenRichtung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SystemDatentypen.Spieler_Mensch);
   
private
   
   AufgabeDurchführen : Boolean;
   NullWert : Boolean;
   BewegungNochMöglich : Boolean;
   
   Befehl : SystemDatentypen.Tastenbelegung_Enum;
      
   Änderung : KartenRecords.AchsenKartenfeldRecord;
   KeineÄnderung : constant KartenRecords.AchsenKartenfeldRecord := (0, 0, 0);

   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;

end BewegungEinheitenKonsole;
