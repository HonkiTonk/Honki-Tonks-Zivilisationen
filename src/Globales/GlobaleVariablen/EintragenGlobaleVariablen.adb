pragma SPARK_Mode (On);

package body EintragenGlobaleVariablen is

   -- Einheitenwerte eintragen
   procedure EinheitenID
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      IDExtern : in GlobaleDatentypen.EinheitenID)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID := IDExtern;
      
   end EinheitenID;
   
   
   
   procedure EinheitenPosition
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position := PositionExtern;
      
   end EinheitenPosition;
   
   
   
   procedure EinheitenLebenspunkte
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      LebenspunkteExtern : in Natural)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte := LebenspunkteExtern;
      
   end EinheitenLebenspunkte;
   
   
   
   procedure EinheitenBewegungspunkte
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BewegungspunkteExtern : in Float)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte := BewegungspunkteExtern;
      
   end EinheitenBewegungspunkte;
   
   
   
   procedure EinheitenErfahrungspunkte
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      ErfahrungspunkteExtern : in Natural)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Erfahrungspunkte := ErfahrungspunkteExtern;
      
   end EinheitenErfahrungspunkte;
   
   
   
   procedure EinheitenRang
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      RangExtern : in Natural)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Rang := RangExtern;
      
   end EinheitenRang;
   
   
   
   procedure EinheitenBeschäftigung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BeschäftigungExtern : in GlobaleDatentypen.Befehle_Enum)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung := BeschäftigungExtern;
      
   end EinheitenBeschäftigung;
   
   
   
   procedure EinheitenBeschäftigungNachfolger
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BeschäftigungNachfolgerExtern : in GlobaleDatentypen.Befehle_Enum)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungNachfolger := BeschäftigungNachfolgerExtern;
      
   end EinheitenBeschäftigungNachfolger;
   
   
   
   procedure EinheitenBeschäftigungszeit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BeschäftigungszeitExtern : in Natural)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit := BeschäftigungszeitExtern;
      
   end EinheitenBeschäftigungszeit;
   
   
   
   procedure EinheitenBeschäftigungszeitNachfolger
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BeschäftigungszeitNachfolgerExtern : in Natural)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungszeitNachfolger := BeschäftigungszeitNachfolgerExtern;
      
   end EinheitenBeschäftigungszeitNachfolger;
   
   
   
   procedure EinheitenKIZielKoordinaten
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      KIZielKoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten := KIZielKoordinatenExtern;
      
   end EinheitenKIZielKoordinaten;
   
   
   
   procedure EinheitenKIBeschäftigt
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      KIBeschäftigtExtern : in KIDatentypen.Einheit_Aufgabe_Enum)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIBeschäftigtExtern;
      
   end EinheitenKIBeschäftigt;
   
   
   
   procedure EinheitenKIBewegungPlan
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      KIBewegungPlanExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ArrayPositionExtern : in Positive)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (ArrayPositionExtern) := KIBewegungPlanExtern;
      
   end EinheitenKIBewegungPlan;
   
   
   
   procedure EinheitenTransportiert
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      TransportiertExtern : in GlobaleDatentypen.MaximaleEinheitenMitNullWert;
      ArrayPositionExtern : in Positive)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Transportiert (ArrayPositionExtern) := TransportiertExtern;
      
   end EinheitenTransportiert;
   
   
   
   procedure EinheitenWirdTransportiert
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      WirdTransportiertExtern : in GlobaleDatentypen.MaximaleEinheitenMitNullWert)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).WirdTransportiert := WirdTransportiertExtern;
      
   end EinheitenWirdTransportiert;
   -- Einheitenwerte eintragen
   
   
   
   -- Stadtwerte eintragen
   procedure StadtID
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      IDExtern : in GlobaleDatentypen.StadtID)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).ID := IDExtern;
      
   end StadtID;
   
   
   
   procedure StadtPosition
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position := PositionExtern;
      
   end StadtPosition;
   
   
   
   procedure StadtAmWasser
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      AmWasserExtern : in Boolean)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AmWasser := AmWasserExtern;
      
   end StadtAmWasser;
   
   
   
   procedure StadtEinwohnerArbeiter
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      EinwohnerArbeiterExtern : in GlobaleDatentypen.WerteNahrungMaterialGeldWissenVerteidigungAngriff;
      ArrayPositionExtern : in Positive)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (ArrayPositionExtern) := EinwohnerArbeiterExtern;
      
   end StadtEinwohnerArbeiter;
   
   
   
   procedure StadtNahrungsmittel
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NahrungsmittelExtern : in GlobaleDatentypen.GesamtproduktionStadt)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel := NahrungsmittelExtern;
      
   end StadtNahrungsmittel;
   
   
   
   procedure StadtNahrungsproduktion
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NahrungsproduktionExtern : in GlobaleDatentypen.GesamtproduktionStadt)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsproduktion := NahrungsproduktionExtern;
      
   end StadtNahrungsproduktion;
   
   
   
   procedure StadtRessourcen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      RessourcenExtern : in GlobaleDatentypen.KostenLager)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Ressourcen := RessourcenExtern;
      
   end StadtRessourcen;
   
   
   
   procedure StadtProduktionrate
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      ProduktionrateExtern : in GlobaleDatentypen.GesamtproduktionStadt)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate := ProduktionrateExtern;
      
   end StadtProduktionrate;
   
   
   
   procedure StadtGeldgewinnung
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      GeldgewinnungExtern : in GlobaleDatentypen.GesamtproduktionStadt)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Geldgewinnung := GeldgewinnungExtern;
      
   end StadtGeldgewinnung;
   
   
   
   procedure StadtForschungsrate
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      ForschungsrateExtern : in GlobaleDatentypen.GesamtproduktionStadt)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Forschungsrate := ForschungsrateExtern;
      
   end StadtForschungsrate;
   
   
   
   procedure StadtBauprojekt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BauprojektExtern : in Natural)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt := BauprojektExtern;
      
   end StadtBauprojekt;
   
   
   
   procedure StadtBauzeit
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BauzeitExtern : in GlobaleDatentypen.KostenLager)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauzeit := BauzeitExtern;
      
   end StadtBauzeit;
   
   
   
   procedure StadtKorruption
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      KorruptionExtern : in GlobaleDatentypen.GesamtproduktionStadt)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Korruption := KorruptionExtern;
      
   end StadtKorruption;
   
   
   
   procedure StadtGebäudeVorhanden
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      GebäudeVorhandenExtern : in Boolean;
      ArrayPositionExtern : in GlobaleDatentypen.GebäudeID)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).GebäudeVorhanden (ArrayPositionExtern) := GebäudeVorhandenExtern;
      
   end StadtGebäudeVorhanden;
   
   
   
   procedure StadtName
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NameExtern : in Unbounded_Wide_Wide_String)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Name := NameExtern;
      
   end StadtName;
   
   
   
   procedure StadtUmgebungBewirtschaftung
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      UmgebungBewirtschaftungExtern : in Boolean;
      YPositionExtern, XPositionExtern : in GlobaleDatentypen.LoopRangeMinusDreiZuDrei)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungBewirtschaftung (YPositionExtern, XPositionExtern) := UmgebungBewirtschaftungExtern;
      
   end StadtUmgebungBewirtschaftung;
   
   
   
   procedure StadtUmgebungGröße
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      UmgebungGrößeExtern : in GlobaleDatentypen.LoopRangeMinusDreiZuDrei)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße := UmgebungGrößeExtern;
      
   end StadtUmgebungGröße;
   
   
   
   procedure StadtMeldungen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      MeldungenExtern : in GlobaleDatentypen.StadtMeldung;
      ArrayPositionExtern : in Positive)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Meldungen (ArrayPositionExtern) := MeldungenExtern;
      
   end StadtMeldungen;
   
   
   
   procedure StadtKIBeschäftigung
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      KIBeschäftigungExtern : in KIDatentypen.Stadt_Aufgabe_Enum)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).KIBeschäftigung := KIBeschäftigungExtern;
      
   end StadtKIBeschäftigung;
   -- Stadtwerte eintragen
   
   
   
   -- Cursorwerte eintragen
   procedure CursorGrafik
     (RasseExtern : in GlobaleDatentypen.Rassen;
      GrafikExtern : in Wide_Wide_Character)
   is begin
      
      GlobaleVariablen.CursorImSpiel (RasseExtern).CursorGrafik := GrafikExtern;
      
   end CursorGrafik;
   
   
   
   procedure CursorPosition
     (RasseExtern : in GlobaleDatentypen.Rassen;
      PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      GlobaleVariablen.CursorImSpiel (RasseExtern).Position := PositionExtern;
      
   end CursorPosition;
   
   
   
   procedure CursorPositionAlt
     (RasseExtern : in GlobaleDatentypen.Rassen;
      PositionAltExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt := PositionAltExtern;
      
   end CursorPositionAlt;
   
   
   
   procedure CursorPositionStadt
     (RasseExtern : in GlobaleDatentypen.Rassen;
      PositionStadtExtern : in GlobaleRecords.AchsenStadtfeldRecord)
   is begin
      
      GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt := PositionStadtExtern;
      
   end CursorPositionStadt;
   -- Cursorwerte eintragen
   
   
   
   -- Wichtiges eintragen
   procedure WichtigesGeldmenge
     (RasseExtern : in GlobaleDatentypen.Rassen;
      GeldmengeExtern : in Integer)
   is begin
      
      GlobaleVariablen.Wichtiges (RasseExtern).Geldmenge := GeldmengeExtern;
      
   end WichtigesGeldmenge;
   
   
   
   procedure WichtigesGeldgewinnRunde
     (RasseExtern : in GlobaleDatentypen.Rassen;
      GeldgewinnRundeExtern : in GlobaleDatentypen.KostenLager)
   is begin
      
      GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde := GeldgewinnRundeExtern;
      
   end WichtigesGeldgewinnRunde;
   
   
   
   procedure WichtigesGesamteForschungsrate
     (RasseExtern : in GlobaleDatentypen.Rassen;
      GesamteForschungsrateExtern : in GlobaleDatentypen.KostenLager)
   is begin
      
      GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate := GesamteForschungsrateExtern;
      
   end WichtigesGesamteForschungsrate;
   
   
   
   procedure WichtigesForschungsmenge
     (RasseExtern : in GlobaleDatentypen.Rassen;
      ForschungsmengeExtern : in GlobaleDatentypen.KostenLager)
   is begin
      
      GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge := ForschungsmengeExtern;
      
   end WichtigesForschungsmenge;
   
   
   
   procedure WichtigesVerbleibendeForschungszeit
     (RasseExtern : in GlobaleDatentypen.Rassen;
      VerbleibendeForschungszeitExtern : in GlobaleDatentypen.KostenLager)
   is begin
      
      GlobaleVariablen.Wichtiges (RasseExtern).VerbleibendeForschungszeit := VerbleibendeForschungszeitExtern;
      
   end WichtigesVerbleibendeForschungszeit;
   
   
   
   procedure WichtigesForschungsprojekt
     (RasseExtern : in GlobaleDatentypen.Rassen;
      ForschungsprojektExtern : in GlobaleDatentypen.ForschungIDMitNullWert)
   is begin
      
      GlobaleVariablen.Wichtiges (RasseExtern).Forschungsprojekt := ForschungsprojektExtern;
      
   end WichtigesForschungsprojekt;
   
   
   
   procedure WichtigesErforscht
     (RasseExtern : in GlobaleDatentypen.Rassen;
      ErforschtExtern : in Boolean;
      ArrayPositionExtern : in ForschungID)
   is begin
      
      GlobaleVariablen.Wichtiges (RasseExtern).Erforscht (ArrayPositionExtern) := ErforschtExtern;
      
   end WichtigesErforscht;
   -- Wichtiges eintragen
   
   
   
   -- Diplomatie eintragen
   procedure Diplomatie
     (RasseEinsExtern, RasseZweiExtern : in GlobaleDatentypen.Rassen;
      DiplomatischerStatusExtern : in GlobaleDatentypen.StatusUntereinander)
   is begin
      
      GlobaleVariablen.Diplomatie (RasseEinsExtern, RasseZweiExtern) := DiplomatischerStatusExtern;
      
   end Diplomatie;
   -- Diplomatie eintragen

end EintragenGlobaleVariablen;
