pragma SPARK_Mode (On);

with GlobaleDatentypen, EinheitStadtRecords, GlobaleVariablen, KartenRecords;
use GlobaleDatentypen, KartenRecords;

with Karten;

package BewegungEinheiten is

   procedure BewegungEinheitenRichtung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
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
   
   EinheitAufFeld : EinheitStadtRecords.RassePlatznummerRecord;
   StadtAufFeld : EinheitStadtRecords.RassePlatznummerRecord;
   
   Änderung : KartenRecords.AchsenKartenfeldRecord;
   KeineÄnderung : constant KartenRecords.AchsenKartenfeldRecord := (0, 0, 0);

   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   type Bewegung_Noch_Möglich_Enum is (Zurück, Bewegbar);
   AktuellerStatus : Bewegung_Noch_Möglich_Enum;
     
   procedure EigeneEinheitAufFeld
     (BewegendeEinheitExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      FeldBelegendeEinheitExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   
   
   function BewegungPrüfen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      NeuePositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Bewegung_Noch_Möglich_Enum
     with
       Pre =>
         (NeuePositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            NeuePositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   function NochBewegungspunkte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Bewegung_Noch_Möglich_Enum;
   
   function FremderAufFeld
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      FremdeEinheitExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean;
   
   function FremdeStadtAufFeld
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      FremdeStadtExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean;

end BewegungEinheiten;
