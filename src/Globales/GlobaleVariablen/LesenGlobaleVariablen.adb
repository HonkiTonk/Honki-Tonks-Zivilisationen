pragma SPARK_Mode (On);

package body LesenGlobaleVariablen is

   -- Einheitenwerte lesen
   function EinheitenID
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.EinheitenID
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID;
      
   end EinheitenID;
   
   
   
   function EinheitenPosition
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position;
      
   end EinheitenPosition;
   
   
   
   function EinheitenLebenspunkte
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte;
      
   end EinheitenLebenspunkte;
   
   
   
   function EinheitenBewegungspunkte
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Float
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte;
      
   end EinheitenBewegungspunkte;
   
   
   
   function EinheitenErfahrungspunkte
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Erfahrungspunkte;
      
   end EinheitenErfahrungspunkte;
   
   
   
   function EinheitenRang
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Rang;
      
   end EinheitenRang;
   
   
   
   function EinheitenBeschäftigung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.Befehle_Enum
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung;
      
   end EinheitenBeschäftigung;
   
   
   
   function EinheitenBeschäftigungNachfolger
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.Befehle_Enum
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungNachfolger;
      
   end EinheitenBeschäftigungNachfolger;
   
   
   
   function EinheitenBeschäftigungszeit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit;
      
   end EinheitenBeschäftigungszeit;
   
   
   
   function EinheitenBeschäftigungszeitNachfolger
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungszeitNachfolger;
      
   end EinheitenBeschäftigungszeitNachfolger;
   
   
   
   function EinheitenKIZielKoordinaten
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten;
      
   end EinheitenKIZielKoordinaten;
   
   
   
   function EinheitenKIBeschäftigt
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return KIDatentypen.Einheit_Aufgabe_Enum
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt;
      
   end EinheitenKIBeschäftigt;
   
   
   
   function EinheitenWirdTransportiert
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).WirdTransportiert;
      
   end EinheitenWirdTransportiert;
   -- Einheitenwerte lesen
   
   
   
   -- Stadtwerte lesen
   function StadtID
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.StadtID
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).ID;
      
   end StadtID;
   
   
   
   function StadtPosition
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position;
      
   end StadtPosition;
   
   
   
   function StadtAmWasser
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AmWasser;
      
   end StadtAmWasser;
   
   
   
   function StadtNahrungsmittel
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel;
      
   end StadtNahrungsmittel;
   
   
   
   function StadtNahrungsproduktion
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsproduktion;
      
   end StadtNahrungsproduktion;
   
   
   
   function StadtRessourcen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.KostenLager
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Ressourcen;
      
   end StadtRessourcen;
   
   
   
   function StadtProduktionrate
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate;
      
   end StadtProduktionrate;
   
   
   
   function StadtGeldgewinnung
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Geldgewinnung;
      
   end StadtGeldgewinnung;
   
   
   
   function StadtForschungsrate
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Forschungsrate;
      
   end StadtForschungsrate;
   
   
   
   function StadtBauprojekt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt;
      
   end StadtBauprojekt;
   
   
   
   function StadtBauzeit
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.KostenLager
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauzeit;
      
   end StadtBauzeit;
   
   
   
   function StadtKorruption
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Korruption;
      
   end StadtKorruption;
   
   
   
   function StadtName
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Unbounded_Wide_Wide_String
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Name;
      
   end StadtName;
   
   
   
   function StadtUmgebungGröße
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.LoopRangeMinusDreiZuDrei
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße;
      
   end StadtUmgebungGröße;
   
   
   
   function StadtKIAktuelleBeschäftigung
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return KIDatentypen.Stadt_Aufgabe_Enum
   is begin
      
      return GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).KIBeschäftigung;
      
   end StadtKIAktuelleBeschäftigung;
   -- Stadtwerte lesen
   
   
   
   -- Cursorwerte lesen
   function CursorGrafik
     (RasseExtern : in GlobaleDatentypen.Rassen)
      return Wide_Wide_Character
   is begin
      
      return GlobaleVariablen.CursorImSpiel (RasseExtern).CursorGrafik;
        
   end CursorGrafik;
   
   
   
   function CursorPosition
     (RasseExtern : in GlobaleDatentypen.Rassen)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      return GlobaleVariablen.CursorImSpiel (RasseExtern).Position;
        
   end CursorPosition;
   
   
   
   function CursorPositionAlt
     (RasseExtern : in GlobaleDatentypen.Rassen)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      return GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt;
        
   end CursorPositionAlt;
   
   
   
   function CursorPositionStadt
     (RasseExtern : in GlobaleDatentypen.Rassen)
      return GlobaleRecords.AchsenStadtfeldRecord
   is begin
      
      return GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt;
        
   end CursorPositionStadt;
   -- Cursorwerte lesen
   
   
   
   -- Wichtiges lesen
   function WichtigesGeldmenge
     (RasseExtern : in GlobaleDatentypen.Rassen)
      return Integer
   is begin
      
      return GlobaleVariablen.Wichtiges (RasseExtern).Geldmenge;
      
   end WichtigesGeldmenge;
   
   
   
   function WichtigesGeldgewinnRunde
     (RasseExtern : in GlobaleDatentypen.Rassen)
      return GlobaleDatentypen.KostenLager
   is begin
      
      return GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde;
      
   end WichtigesGeldgewinnRunde;
   
   
   
   function WichtigesGesamteForschungsrate
     (RasseExtern : in GlobaleDatentypen.Rassen)
      return GlobaleDatentypen.KostenLager
   is begin
      
      return GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate;
      
   end WichtigesGesamteForschungsrate;
   
   
   
   function WichtigesForschungsmenge
     (RasseExtern : in GlobaleDatentypen.Rassen)
      return GlobaleDatentypen.KostenLager
   is begin
      
      return GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge;
      
   end WichtigesForschungsmenge;
   
   
   
   function WichtigesVerbleibendeForschungszeit
     (RasseExtern : in GlobaleDatentypen.Rassen)
      return GlobaleDatentypen.KostenLager
   is begin
      
      return GlobaleVariablen.Wichtiges (RasseExtern).VerbleibendeForschungszeit;
      
   end WichtigesVerbleibendeForschungszeit;
   
   
   
   function WichtigesForschungsprojekt
     (RasseExtern : in GlobaleDatentypen.Rassen)
      return GlobaleDatentypen.ForschungIDMitNullWert
   is begin
      
      return GlobaleVariablen.Wichtiges (RasseExtern).Forschungsprojekt;
      
   end WichtigesForschungsprojekt;
   -- Wichtiges lesen
   
   
   
   -- Diplomatie lesen
   function Diplomatie
     (RasseEinsExtern, RasseZweiExtern : in GlobaleDatentypen.Rassen)
      return GlobaleDatentypen.StatusUntereinander
   is begin
      
      return GlobaleVariablen.Diplomatie (RasseEinsExtern, RasseZweiExtern);
      
   end Diplomatie;
   -- Diplomatie lesen

end LesenGlobaleVariablen;
