pragma SPARK_Mode (On);

with KIRecords, GlobaleRecords, GlobaleDatentypen, GlobaleVariablen, KIDatentypen;
use GlobaleDatentypen, GlobaleRecords, KIDatentypen;

with Karten;

package KIPruefungen is

   procedure ZielBerechnenGefahr
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2);
   
   
   
   function StadtUmgebungPrüfen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2),
         Post =>
           (StadtUmgebungPrüfen'Result.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
            and
              StadtUmgebungPrüfen'Result.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   function EinheitenAbstandBerechnen
     (EinheitEinsRasseNummerExtern, EinheitZweiRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
     with
       Pre =>
         (EinheitEinsRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            EinheitZweiRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitEinsRasseNummerExtern.Rasse) = 2
          and
            GlobaleVariablen.RassenImSpiel (EinheitZweiRasseNummerExtern.Rasse) = 2);

   function NähesteEigeneStadtSuchen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      RichtungExtern : in KIDatentypen.Richtung_Enum)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2);

   function NähesteEigeneEinheitSuchen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      RichtungExtern : in KIDatentypen.Richtung_Enum)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2);
   
   function UmgebungStadtBauenPrüfen     
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      MindestBewertungFeldExtern : in GlobaleDatentypen.GesamtproduktionStadt)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2),
         Post =>
           (UmgebungStadtBauenPrüfen'Result.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
            and
              UmgebungStadtBauenPrüfen'Result.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);           
   
private
   
   FeldGutUndFrei : Boolean;

   Richtung : Natural;

   AbstandKleiner : GlobaleDatentypen.KartenfeldPositiv;
   YAchseKoordinatePrüfen : GlobaleDatentypen.KartenfeldPositiv;
   XAchseKoordinatePrüfen : GlobaleDatentypen.KartenfeldPositiv;
   YAchseKoordinatenSchonGeprüft : GlobaleDatentypen.KartenfeldPositiv;
   XAchseKoordinatenSchonGeprüft : GlobaleDatentypen.KartenfeldPositiv;
   
   VerbesserungAnlegen : GlobaleRecords.AchsenKartenfeldPositivRecord;
   
   EinheitAufFeld : GlobaleRecords.RassePlatznummerRecord;
   
   KartenWertEins : GlobaleRecords.AchsenKartenfeldPositivRecord;
   KartenWertZwei : GlobaleRecords.AchsenKartenfeldPositivRecord;

   -- 1 = Norden (-), 2 = Westen (-), 3 = Süden (+), 4 = Osten (+)
   type RichtungenFeindeArray is array (1 .. 4) of Natural;
   RichtungenFeinde : RichtungenFeindeArray;

   KartenfeldAbstand : GlobaleDatentypen.Kartenfeld;

   type KandidatenArray is array (1 .. 3) of GlobaleRecords.AchsenKartenfeldPositivRecord;
   Kandidaten : KandidatenArray;

   procedure StadtImNorden
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      StadtNummerExtern : in GlobaleDatentypen.MaximaleStädte)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2);
   
   procedure StadtImSüden
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      StadtNummerExtern : in GlobaleDatentypen.MaximaleStädte)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2);
   
   procedure StadtImWesten
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      StadtNummerExtern : in GlobaleDatentypen.MaximaleStädte)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2);
   
   procedure StadtImOsten
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      StadtNummerExtern : in GlobaleDatentypen.MaximaleStädte)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2);
   
   
   
   function KartenfeldUmgebungPrüfen     
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      MindestBewertungFeldExtern : in GlobaleDatentypen.GesamtproduktionStadt)
      return Boolean
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2);
   
   function StadtUmgebungUnverbessert
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      EinheitNummerExtern : in GlobaleDatentypen.MaximaleEinheiten)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = 2
          and
            StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'Range (2));
   
   function UmgebungWirdBereitsVerbessert
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen)
      return Boolean
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
end KIPruefungen;
