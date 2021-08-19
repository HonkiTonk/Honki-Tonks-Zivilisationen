pragma SPARK_Mode (On);

package body SchreibeStadtGebaut is

   procedure ID
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      IDExtern : in GlobaleDatentypen.Karten_Verbesserung_Stadt_ID_Enum)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).ID := IDExtern;
      
   end ID;
   
   
   
   procedure Position
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position := PositionExtern;
      
   end Position;
   
   
   
   procedure EinwohnerArbeiter
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      EinwohnerArbeiterExtern : in Boolean;
      ÄnderungExtern : in GlobaleDatentypen.ProduktionFeld)
   is begin
      
      case
        EinwohnerArbeiterExtern
      is
         when True =>
            if
              GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) + ÄnderungExtern > GlobaleDatentypen.ProduktionFeld'Last
            then
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) := GlobaleDatentypen.ProduktionFeld'Last;
               
            elsif
              GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) + ÄnderungExtern < 0
            then
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) := 0;
            
            else
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1)
                 := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) + ÄnderungExtern;
            end if;
            
         when False =>
            if
              GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (2) + ÄnderungExtern > GlobaleDatentypen.ProduktionFeld'Last
            then
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (2) := GlobaleDatentypen.ProduktionFeld'Last;
               
            elsif
              GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (2) + ÄnderungExtern < 0
            then
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (2) := 0;
            
            else
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (2)
                 := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (2) + ÄnderungExtern;
            end if;
      end case;
      
   end EinwohnerArbeiter;
   
      
      
   procedure Nahrungsmittel
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NahrungsmittelExtern : in GlobaleDatentypen.GesamtproduktionStadt)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel := NahrungsmittelExtern;
      
   end Nahrungsmittel;
   
   
   
   procedure Nahrungsproduktion
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NahrungsproduktionExtern : in GlobaleDatentypen.GesamtproduktionStadt)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsproduktion := NahrungsproduktionExtern;
      
   end Nahrungsproduktion;
   
   
   
   procedure Ressourcen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      RessourcenExtern : in GlobaleDatentypen.KostenLager)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Ressourcen := RessourcenExtern;
      
   end Ressourcen;
   
   
   
   procedure Produktionrate
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      ProduktionrateExtern : in GlobaleDatentypen.GesamtproduktionStadt)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate := ProduktionrateExtern;
      
   end Produktionrate;
   
   
   
   procedure Geldgewinnung
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      GeldgewinnungExtern : in GlobaleDatentypen.GesamtproduktionStadt)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Geldgewinnung := GeldgewinnungExtern;
      
   end Geldgewinnung;
   
   
   
   procedure PermanenteKostenPosten
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      WelcherPostenExtern : in GlobaleDatentypen.Permanente_Kosten_Verwendet_Enum;
      KostenExtern : in GlobaleDatentypen.GesamtePermanenteKosten)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).PermanenteKostenPosten (WelcherPostenExtern) := KostenExtern;
      
   end PermanenteKostenPosten;
   
   
      
   procedure Forschungsrate
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      ForschungsrateExtern : in GlobaleDatentypen.GesamtproduktionStadt)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Forschungsrate := ForschungsrateExtern;
      
   end Forschungsrate;
   
   
   
   procedure Bauprojekt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BauprojektExtern : in Natural)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt := BauprojektExtern;
      
   end Bauprojekt;
   
   
   
   procedure Bauzeit
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BauzeitExtern : in GlobaleDatentypen.KostenLager)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauzeit := BauzeitExtern;
      
   end Bauzeit;
   
   
   
   procedure Korruption
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      KorruptionExtern : in GlobaleDatentypen.GesamtproduktionStadt)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Korruption := KorruptionExtern;
      
   end Korruption;
   
   
   
   procedure GebäudeVorhanden
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      WelchesGebäudeExtern : in GlobaleDatentypen.GebäudeID;
      HinzufügenEntfernenExtern : in Boolean)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).GebäudeVorhanden (WelchesGebäudeExtern) := HinzufügenEntfernenExtern;
      
   end GebäudeVorhanden;
   
   
   
   procedure Name
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NameExtern : in Unbounded_Wide_Wide_String)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Name := NameExtern;
      
   end Name;
   
   
   
   procedure UmgebungBewirtschaftung
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      YPosition, XPosition : in GlobaleDatentypen.LoopRangeMinusDreiZuDrei;
      BelegenEntfernenExtern : in Boolean)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungBewirtschaftung (YPosition, XPosition) := BelegenEntfernenExtern;
      
   end UmgebungBewirtschaftung;
   
   
   
   procedure UmgebungGröße
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      UmgebungGrößeExtern : in GlobaleDatentypen.LoopRangeMinusDreiZuDrei)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße := UmgebungGrößeExtern;
      
   end UmgebungGröße;
      
   
      
   procedure Meldungen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      WelcheMeldungExtern : in GlobaleDatentypen.Stadt_Meldung_Art_Enum;
      MeldungExtern : in GlobaleDatentypen.Stadt_Meldung_Enum)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Meldungen (WelcheMeldungExtern) := MeldungExtern;
      
   end Meldungen;
   
      
      
   procedure KIBeschäftigung
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BeschäftigungExtern : in KIDatentypen.Stadt_Aufgabe_Enum)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).KIBeschäftigung := BeschäftigungExtern;
      
   end KIBeschäftigung;

end SchreibeStadtGebaut;
