pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen, GlobaleRecords;

with Karten;

package BewegungEinheiten is

   procedure BewegungEinheitenRichtung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch);
   
private
   
   FeldPassierbar : Boolean;
   BewegungDurchführen : Boolean;
   Gewonnen : Boolean;
   AufgabeDurchführen : Boolean;
   NullWert : Boolean;
   
   Befehl : GlobaleDatentypen.Tastenbelegung_Enum;
   
   EinheitAufFeld : GlobaleRecords.RassePlatznummerRecord;
   StadtAufFeld : GlobaleRecords.RassePlatznummerRecord;
   
   Änderung : GlobaleRecords.AchsenKartenfeldRecord;
   KeineÄnderung : constant GlobaleRecords.AchsenKartenfeldRecord := (0, 0, 0);

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;
   
   type Bewegung_Noch_Möglich_Enum is (Zurück, Bewegbar);
   AktuellerStatus : Bewegung_Noch_Möglich_Enum;
     
   procedure EigeneEinheitAufFeld
     (BewegendeEinheitExtern, FeldBelegendeEinheitExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   
   
   function BewegungPrüfen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Bewegung_Noch_Möglich_Enum
     with
       Pre =>
         (NeuePositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            NeuePositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   function NochBewegungspunkte
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Bewegung_Noch_Möglich_Enum;
   
   function FremderAufFeld
     (EinheitRasseNummerExtern, FremdeEinheitExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean;
   
   function FremdeStadtAufFeld
     (EinheitRasseNummerExtern, FremdeStadtExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean;

end BewegungEinheiten;
