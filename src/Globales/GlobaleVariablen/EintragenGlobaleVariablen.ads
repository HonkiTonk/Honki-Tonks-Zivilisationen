pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleRecords, GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

with KIDatentypen;

with Karten;

package EintragenGlobaleVariablen is

   -- Einheitenwerte eintragen
   procedure EinheitenID
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      IDExtern : in GlobaleDatentypen.EinheitenID)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0);
   
   procedure EinheitenPosition
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0
          and
            PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
     
   procedure EinheitenLebenspunkte
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      LebenspunkteExtern : in Natural)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0);
     
   procedure EinheitenBewegungspunkte
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BewegungspunkteExtern : in Float)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0);
     
   procedure EinheitenErfahrungspunkte
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      ErfahrungspunkteExtern : in Natural)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0);
     
   procedure EinheitenRang
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      RangExtern : in Natural)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0);
     
   procedure EinheitenBeschäftigung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BeschäftigungExtern : in GlobaleDatentypen.Befehle_Enum)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0);
     
   procedure EinheitenBeschäftigungNachfolger
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BeschäftigungNachfolgerExtern : in GlobaleDatentypen.Befehle_Enum)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0);
     
   procedure EinheitenBeschäftigungszeit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BeschäftigungszeitExtern : in Natural)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0);
     
   procedure EinheitenBeschäftigungszeitNachfolger
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BeschäftigungszeitNachfolgerExtern : in Natural)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0);
     
   procedure EinheitenKIZielKoordinaten
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      KIZielKoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0
          and
            KIZielKoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KIZielKoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
     
   procedure EinheitenKIBeschäftigt
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      KIBeschäftigtExtern : in KIDatentypen.Einheit_Aufgabe_Enum)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0);
   
   procedure EinheitenKIBewegungPlan
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      KIBewegungPlanExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ArrayPositionExtern : in Positive)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0
          and
            KIBewegungPlanExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KIBewegungPlanExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   procedure EinheitenTransportiert
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      TransportiertExtern : in GlobaleDatentypen.MaximaleEinheitenMitNullWert;
      ArrayPositionExtern : in Positive)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0);
     
   procedure EinheitenWirdTransportiert
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      WirdTransportiertExtern : in GlobaleDatentypen.MaximaleEinheitenMitNullWert)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0);
   -- Einheitenwerte eintragen
   
   
   
   -- Stadtwerte eintragen
   procedure StadtID
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      IDExtern : in GlobaleDatentypen.StadtID)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);
   
   procedure StadtPosition
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0
          and
            PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
     
   procedure StadtAmWasser
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      AmWasserExtern : in Boolean)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);
   
   procedure StadtEinwohnerArbeiter
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      EinwohnerArbeiterExtern : in GlobaleDatentypen.WerteNahrungMaterialGeldWissenVerteidigungAngriff;
      ArrayPositionExtern : in Positive)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);
     
   procedure StadtNahrungsmittel
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NahrungsmittelExtern : in GlobaleDatentypen.GesamtproduktionStadt)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);
     
   procedure StadtNahrungsproduktion
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NahrungsproduktionExtern : in GlobaleDatentypen.GesamtproduktionStadt)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);
     
   procedure StadtRessourcen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      RessourcenExtern : in GlobaleDatentypen.KostenLager)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);
     
   procedure StadtProduktionrate
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      ProduktionrateExtern : in GlobaleDatentypen.GesamtproduktionStadt)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);
     
   procedure StadtGeldgewinnung
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      GeldgewinnungExtern : in GlobaleDatentypen.GesamtproduktionStadt)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);
     
   procedure StadtForschungsrate
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      ForschungsrateExtern : in GlobaleDatentypen.GesamtproduktionStadt)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);
     
   procedure StadtBauprojekt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BauprojektExtern : in Natural)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);
     
   procedure StadtBauzeit
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BauzeitExtern : in GlobaleDatentypen.KostenLager)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);
     
   procedure StadtKorruption
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      KorruptionExtern : in GlobaleDatentypen.GesamtproduktionStadt)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);
   
   procedure StadtGebäudeVorhanden
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      GebäudeVorhandenExtern : in Boolean;
      ArrayPositionExtern : in GlobaleDatentypen.GebäudeID)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);
     
   procedure StadtName
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NameExtern : in Unbounded_Wide_Wide_String)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);
   
   procedure StadtUmgebungBewirtschaftung
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      UmgebungBewirtschaftungExtern : in Boolean;
      YPositionExtern, XPositionExtern : in GlobaleDatentypen.LoopRangeMinusDreiZuDrei)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);
     
   procedure StadtUmgebungGröße
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      UmgebungGrößeExtern : in GlobaleDatentypen.LoopRangeMinusDreiZuDrei)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);
   
   procedure StadtMeldungen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      MeldungenExtern : in GlobaleDatentypen.StadtMeldung;
      ArrayPositionExtern : in Positive)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);
     
   procedure StadtKIBeschäftigung
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      KIBeschäftigungExtern : in KIDatentypen.Stadt_Aufgabe_Enum)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);
   -- Stadtwerte eintragen
   
   
   
   -- Cursorwerte eintragen
   procedure CursorGrafik
     (RasseExtern : in GlobaleDatentypen.Rassen;
      GrafikExtern : in Wide_Wide_Character)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);
   
   procedure CursorPosition
     (RasseExtern : in GlobaleDatentypen.Rassen;
      PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0
          and
            PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
     
   procedure CursorPositionAlt
     (RasseExtern : in GlobaleDatentypen.Rassen;
      PositionAltExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0
          and
            PositionAltExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionAltExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
     
   procedure CursorPositionStadt
     (RasseExtern : in GlobaleDatentypen.Rassen;
      PositionStadtExtern : in GlobaleRecords.AchsenStadtfeldRecord)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);
   -- Cursorwerte eintragen
   
   
   
   -- Wichtiges eintragen
   procedure WichtigesGeldmenge
     (RasseExtern : in GlobaleDatentypen.Rassen;
      GeldmengeExtern : in Integer)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);
   
   procedure WichtigesGeldgewinnRunde
     (RasseExtern : in GlobaleDatentypen.Rassen;
      GeldgewinnRundeExtern : in GlobaleDatentypen.KostenLager)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);
     
   procedure WichtigesGesamteForschungsrate
     (RasseExtern : in GlobaleDatentypen.Rassen;
      GesamteForschungsrateExtern : in GlobaleDatentypen.KostenLager)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);
     
   procedure WichtigesForschungsmenge
     (RasseExtern : in GlobaleDatentypen.Rassen;
      ForschungsmengeExtern : in GlobaleDatentypen.KostenLager)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);
     
   procedure WichtigesVerbleibendeForschungszeit
     (RasseExtern : in GlobaleDatentypen.Rassen;
      VerbleibendeForschungszeitExtern : in GlobaleDatentypen.KostenLager)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);
     
   procedure WichtigesForschungsprojekt
     (RasseExtern : in GlobaleDatentypen.Rassen;
      ForschungsprojektExtern : in GlobaleDatentypen.ForschungIDMitNullWert)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);
   
   procedure WichtigesErforscht
     (RasseExtern : in GlobaleDatentypen.Rassen;
      ErforschtExtern : in Boolean;
      ArrayPositionExtern : in ForschungID)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0);
   -- Wichtiges eintragen
   
   
   
   -- Diplomatie eintragen
   procedure Diplomatie
     (RasseEinsExtern, RasseZweiExtern : in GlobaleDatentypen.Rassen;
      DiplomatischerStatusExtern : in GlobaleDatentypen.StatusUntereinander)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseEinsExtern) > 0
          and
            GlobaleVariablen.RassenImSpiel (RasseZweiExtern) > 0);
   -- Diplomatie eintragen

end EintragenGlobaleVariablen;
