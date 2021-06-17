pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;
use GlobaleDatentypen;

with Karten;

package StadtInformationen is

   procedure StadtArtBesitzer
     (RasseExtern : in GlobaleDatentypen.Rassen;
      StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) > 0
          and
            StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2));

   procedure StadtName
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            StadtRasseNummerExtern.Platznummer > 0);

   procedure Einwohner
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            StadtRasseNummerExtern.Platznummer > 0);

   procedure AktuelleNahrungsmittel
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            StadtRasseNummerExtern.Platznummer > 0);

   procedure AktuelleNahrungsproduktion
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            StadtRasseNummerExtern.Platznummer > 0);

   procedure AktuelleProduktionrate
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            StadtRasseNummerExtern.Platznummer > 0);

   procedure AktuelleGeldgewinnung
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            StadtRasseNummerExtern.Platznummer > 0);

   procedure AktuelleForschungsrate
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            StadtRasseNummerExtern.Platznummer > 0);

   procedure Korruption
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            StadtRasseNummerExtern.Platznummer > 0);

   procedure EinwohnerOhneArbeit
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            StadtRasseNummerExtern.Platznummer > 0);

   procedure AktuellesBauprojekt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            StadtRasseNummerExtern.Platznummer > 0);

   procedure EinzelnesFeldNahrungsgewinnung
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (KoordinatenExtern.YAchse in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   procedure EinzelnesFeldRessourcengewinnung
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (KoordinatenExtern.YAchse in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   procedure EinzelnesFeldGeldgewinnung
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (KoordinatenExtern.YAchse in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   procedure EinzelnesFeldWissensgewinnung
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (KoordinatenExtern.YAchse in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   procedure StadtfeldBewirtschaftet
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      CursorYAchseabstraktionExtern, CursorXAchseabstraktionExtern : in GlobaleDatentypen.Kartenfeld)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            StadtRasseNummerExtern.Platznummer > 0);

private

   Nahrungsgewinnung : GlobaleDatentypen.WerteNahrungMaterialGeldWissenVerteidigungAngriff;
   Ressourcengewinnung : GlobaleDatentypen.WerteNahrungMaterialGeldWissenVerteidigungAngriff;
   Geldgewinnung : GlobaleDatentypen.WerteNahrungMaterialGeldWissenVerteidigungAngriff;
   Wissensgewinnung : GlobaleDatentypen.WerteNahrungMaterialGeldWissenVerteidigungAngriff;

end StadtInformationen;
