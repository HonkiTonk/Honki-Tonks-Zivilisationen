pragma SPARK_Mode (On);

with EinheitStadtRecords; use EinheitStadtRecords;
with SonstigeDatentypen; use SonstigeDatentypen;
with KartenDatentypen; use KartenDatentypen;
with GlobaleVariablen;
with KartenRecords;
with EinheitStadtDatentypen;

with Karten;

package KIPruefungen is
   
   function StadtUmgebungPrüfen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return KartenRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_KI),
         Post =>
           (StadtUmgebungPrüfen'Result.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
            and
              StadtUmgebungPrüfen'Result.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   function UmgebungStadtBauenPrüfen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      MindestBewertungFeldExtern : in EinheitStadtDatentypen.GesamtproduktionStadt)
      return KartenRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_KI),
         Post =>
           (UmgebungStadtBauenPrüfen'Result.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
            and
              UmgebungStadtBauenPrüfen'Result.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
private
   
   FeldGutUndFrei : Boolean;
   VerbesserungTesten : Boolean;

   AbstandKleiner : KartenDatentypen.KartenfeldPositiv;
   YAchseKoordinatePrüfen : KartenDatentypen.KartenfeldPositiv;
   XAchseKoordinatePrüfen : KartenDatentypen.KartenfeldPositiv;
   YAchseKoordinatenSchonGeprüft : KartenDatentypen.KartenfeldPositivMitNullwert;
   XAchseKoordinatenSchonGeprüft : KartenDatentypen.KartenfeldPositivMitNullwert;
   
   VerbesserungAnlegen : KartenRecords.AchsenKartenfeldPositivRecord;
   
   EinheitAufFeld : EinheitStadtRecords.RassePlatznummerRecord;
   
   StadtVerbesserungUmgebungKoordinaten : KartenRecords.AchsenKartenfeldPositivRecord;
   StadtBauenUmgebungKoordinaten : KartenRecords.AchsenKartenfeldPositivRecord;
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   KartenWertZwei : KartenRecords.AchsenKartenfeldPositivRecord;
   
   function KartenfeldUmgebungPrüfen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      MindestBewertungFeldExtern : in EinheitStadtDatentypen.GesamtproduktionStadt)
      return Boolean
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_KI);
   
   function StadtUmgebungUnverbessert
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EinheitNummerExtern : in EinheitStadtDatentypen.MaximaleEinheiten)
      return KartenRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_KI
          and
            StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze);
   
   function VerbesserungDortAnlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_KI);
   
   function VerbesserungAnlegbar
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean;
   
   function FeldBelegt
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean;
   
   function NeuesStadtFeldSuchen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      MindestBewertungFeldExtern : in EinheitStadtDatentypen.GesamtproduktionStadt;
      YUmgebungExtern : in KartenDatentypen.KartenfeldPositiv;
      XUmgebungExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenRecords.AchsenKartenfeldPositivRecord;
   
   function FelderDurchgehen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      MindestBewertungFeldExtern : in EinheitStadtDatentypen.GesamtproduktionStadt)
      return KartenRecords.AchsenKartenfeldPositivRecord;
   
end KIPruefungen;
