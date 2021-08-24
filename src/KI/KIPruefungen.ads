pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen, GlobaleRecords;

with Karten;

package KIPruefungen is
   
   function StadtUmgebungPrüfen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI),
         Post =>
           (StadtUmgebungPrüfen'Result.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
            and
              StadtUmgebungPrüfen'Result.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   function UmgebungStadtBauenPrüfen     
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      MindestBewertungFeldExtern : in GlobaleDatentypen.GesamtproduktionStadt)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI),
         Post =>
           (UmgebungStadtBauenPrüfen'Result.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
            and
              UmgebungStadtBauenPrüfen'Result.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);           
   
private
   
   FeldGutUndFrei : Boolean;
   
   VerbesserungAnlegbar : Boolean;

   AbstandKleiner : GlobaleDatentypen.KartenfeldPositiv;
   YAchseKoordinatePrüfen : GlobaleDatentypen.KartenfeldPositiv;
   XAchseKoordinatePrüfen : GlobaleDatentypen.KartenfeldPositiv;
   YAchseKoordinatenSchonGeprüft : GlobaleDatentypen.KartenfeldPositivMitNullwert;
   XAchseKoordinatenSchonGeprüft : GlobaleDatentypen.KartenfeldPositivMitNullwert;
   
   VerbesserungAnlegen : GlobaleRecords.AchsenKartenfeldPositivRecord;
   
   EinheitAufFeld : GlobaleRecords.RassePlatznummerRecord;
   
   StadtVerbesserungUmgebungKoordinaten : GlobaleRecords.AchsenKartenfeldPositivRecord;
   StadtBauenUmgebungKoordinaten : GlobaleRecords.AchsenKartenfeldPositivRecord;
   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;
   
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
            EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI);
   
   function StadtUmgebungUnverbessert
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      EinheitNummerExtern : in GlobaleDatentypen.MaximaleEinheiten)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI
          and
            StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze);
   
   function VerbesserungDortAnlegen
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI);
   
end KIPruefungen;
