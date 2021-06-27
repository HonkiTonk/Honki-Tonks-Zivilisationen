pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;
use GlobaleDatentypen;

with KIDatentypen;

with Karten;

package LesenGlobaleVariablen is

   -- Einheitenwerte lesen
   function EinheitenID
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.EinheitenID
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0);

   function EinheitenPosition
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0),
         Post =>
           (EinheitenPosition'Result.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
            and
              EinheitenPosition'Result.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   function EinheitenLebenspunkte
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0);

   function EinheitenBewegungspunkte
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Float
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0);

   function EinheitenErfahrungspunkte
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0);

   function EinheitenRang
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0);

   function EinheitenBeschäftigung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.Befehle_Enum
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0);

   function EinheitenBeschäftigungNachfolger
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.Befehle_Enum
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0);

   function EinheitenBeschäftigungszeit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0);

   function EinheitenBeschäftigungszeitNachfolger
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0);

   function EinheitenKIZielKoordinaten
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0),
         Post =>
           (EinheitenKIZielKoordinaten'Result.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
            and
              EinheitenKIZielKoordinaten'Result.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   function EinheitenKIBeschäftigt
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return KIDatentypen.Einheit_Aufgabe_Enum
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0);

   function EinheitenKIBewegungPlan
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      ArrayPositionExtern : in Positive)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0),
         Post =>
           (EinheitenKIBewegungPlan'Result.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
            and
              EinheitenKIBewegungPlan'Result.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   function EinheitenTransportiert
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      ArrayPositionExtern : in Positive)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0);

   function EinheitenWirdTransportiert
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0);
   -- Einheitenwerte lesen



   -- Stadtwerte lesen
   function StadtID
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.StadtID
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);

   function StadtPosition
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0),
         Post =>
           (StadtPosition'Result.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
            and
              StadtPosition'Result.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   function StadtAmWasser
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);

   function StadtEinwohnerArbeiter
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      ArrayPositionExtern : in Positive)
      return GlobaleDatentypen.WerteNahrungMaterialGeldWissenVerteidigungAngriff
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);

   function StadtNahrungsmittel
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);

   function StadtNahrungsproduktion
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);

   function StadtRessourcen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.KostenLager
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);

   function StadtProduktionrate
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);

   function StadtGeldgewinnung
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);

   function StadtForschungsrate
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);

   function StadtBauprojekt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);

   function StadtBauzeit
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.KostenLager
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);

   function StadtKorruption
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);

   function StadtGebäudeVorhanden
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      ArrayPositionExtern : in GlobaleDatentypen.GebäudeID)
      return Boolean
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);

   function StadtName
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Unbounded_Wide_Wide_String
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);

   function StadtUmgebungBewirtschaftung
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      YPositionExtern, XPositionExtern : in GlobaleDatentypen.LoopRangeMinusDreiZuDrei)
      return Boolean
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);

   function StadtUmgebungGröße
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.LoopRangeMinusDreiZuDrei
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);

   function StadtMeldungen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      ArrayPositionExtern : in Positive)
      return GlobaleDatentypen.StadtMeldung
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);

   function StadtKIAktuelleBeschäftigung
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return KIDatentypen.Stadt_Aufgabe_Enum
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.StadtGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);
   -- Stadtwerte lesen



   -- Cursorwerte lesen
   function CursorGrafik
     (RasseExtern : in GlobaleDatentypen.Rassen)
      return Wide_Wide_Character
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);

   function CursorPosition
     (RasseExtern : in GlobaleDatentypen.Rassen)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0),
         Post =>
           (CursorPosition'Result.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
            and
              CursorPosition'Result.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   function CursorPositionAlt
     (RasseExtern : in GlobaleDatentypen.Rassen)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0),
         Post =>
           (CursorPositionAlt'Result.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
            and
              CursorPositionAlt'Result.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   function CursorPositionStadt
     (RasseExtern : in GlobaleDatentypen.Rassen)
      return GlobaleRecords.AchsenStadtfeldRecord
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);
   -- Cursorwerte lesen



   -- Wichtiges lesen
   function WichtigesGeldmenge
     (RasseExtern : in GlobaleDatentypen.Rassen)
      return Integer
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);

   function WichtigesGeldgewinnRunde
     (RasseExtern : in GlobaleDatentypen.Rassen)
      return GlobaleDatentypen.KostenLager
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);

   function WichtigesGesamteForschungsrate
     (RasseExtern : in GlobaleDatentypen.Rassen)
      return GlobaleDatentypen.KostenLager
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);

   function WichtigesForschungsmenge
     (RasseExtern : in GlobaleDatentypen.Rassen)
      return GlobaleDatentypen.KostenLager
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);

   function WichtigesVerbleibendeForschungszeit
     (RasseExtern : in GlobaleDatentypen.Rassen)
      return GlobaleDatentypen.KostenLager
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);

   function WichtigesForschungsprojekt
     (RasseExtern : in GlobaleDatentypen.Rassen)
      return GlobaleDatentypen.ForschungIDMitNullWert
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);

   function WichtigesErforscht
     (RasseExtern : in GlobaleDatentypen.Rassen;
      ArrayPositionExtern : in ForschungID)
      return Boolean
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);
   -- Wichtiges lesen



   -- Diplomatie lesen
   function Diplomatie
     (RasseEinsExtern, RasseZweiExtern : in GlobaleDatentypen.Rassen)
      return GlobaleDatentypen.StatusUntereinander
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseEinsExtern) > 0
          and
            GlobaleVariablen.RassenImSpiel (RasseZweiExtern) > 0);
   -- Diplomatie lesen

end LesenGlobaleVariablen;
