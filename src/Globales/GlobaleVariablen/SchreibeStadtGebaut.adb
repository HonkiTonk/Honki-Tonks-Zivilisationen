pragma SPARK_Mode (On);

with EinheitenKonstanten, StadtKonstanten;

with LeseGebaeudeDatenbank, LeseEinheitenDatenbank;

package body SchreibeStadtGebaut is

   procedure ID
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      IDExtern : in KartenDatentypen.Karten_Verbesserung_Stadt_ID_Enum)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).ID := IDExtern;
      
   end ID;
   
   
   
   procedure Position
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position := PositionExtern;
      
   end Position;
   
   
   
   procedure EinwohnerArbeiter
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EinwohnerArbeiterExtern : in Boolean;
      ÄnderungExtern : in EinheitStadtDatentypen.ProduktionFeld)
   is begin
      
      case
        EinwohnerArbeiterExtern
      is
         when True =>
            if
              GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) + ÄnderungExtern > EinheitStadtDatentypen.ProduktionFeld'Last
            then
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) := EinheitStadtDatentypen.ProduktionFeld'Last;
               
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
              GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (2) + ÄnderungExtern > EinheitStadtDatentypen.ProduktionFeld'Last
            then
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (2) := EinheitStadtDatentypen.ProduktionFeld'Last;
               
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
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      NahrungsmittelExtern : in EinheitStadtDatentypen.GesamtproduktionStadt;
      ÄndernSetzenExtern : in Boolean)
   is begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel + NahrungsmittelExtern > EinheitStadtDatentypen.GesamtproduktionStadt'Last
            then
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel := EinheitStadtDatentypen.GesamtproduktionStadt'Last;
               
            elsif
              GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel + NahrungsmittelExtern < EinheitStadtDatentypen.GesamtproduktionStadt'First
            then
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel := EinheitStadtDatentypen.GesamtproduktionStadt'First;
               
            else
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel
                 := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel + NahrungsmittelExtern;
            end if;
            
         when False =>
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsmittel := NahrungsmittelExtern;
      end case;
      
   end Nahrungsmittel;
   
   
   
   procedure Nahrungsproduktion
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      NahrungsproduktionExtern : in EinheitStadtDatentypen.GesamtproduktionStadt;
      ÄndernSetzenExtern : in Boolean)
   is begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsproduktion + NahrungsproduktionExtern > EinheitStadtDatentypen.GesamtproduktionStadt'Last
            then
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsproduktion := EinheitStadtDatentypen.GesamtproduktionStadt'Last;
               
            elsif
              GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsproduktion + NahrungsproduktionExtern < EinheitStadtDatentypen.GesamtproduktionStadt'First
            then
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsproduktion := EinheitStadtDatentypen.GesamtproduktionStadt'First;
               
            else
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsproduktion
                 := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsproduktion + NahrungsproduktionExtern;
            end if;
            
         when False =>
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsproduktion := NahrungsproduktionExtern;
      end case;
      
   end Nahrungsproduktion;
   
   
   
   procedure Ressourcen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      RessourcenExtern : in EinheitStadtDatentypen.KostenLager;
      ÄndernSetzenExtern : in Boolean)
   is begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Ressourcen + RessourcenExtern > EinheitStadtDatentypen.KostenLager'Last
            then
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Ressourcen := EinheitStadtDatentypen.KostenLager'Last;
               
            elsif
              GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Ressourcen + RessourcenExtern < EinheitStadtDatentypen.KostenLager'First
            then
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Ressourcen := EinheitStadtDatentypen.KostenLager'First;
               
            else
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Ressourcen
                 := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Ressourcen + RessourcenExtern;
            end if;
            
         when False =>
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Ressourcen := RessourcenExtern;
      end case;
      
      Bauzeit (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
   end Ressourcen;
   
   
   
   procedure Produktionrate
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      ProduktionrateExtern : in EinheitStadtDatentypen.GesamtproduktionStadt;
      ÄndernSetzenExtern : in Boolean)
   is begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate + ProduktionrateExtern > EinheitStadtDatentypen.GesamtproduktionStadt'Last
            then
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate := EinheitStadtDatentypen.GesamtproduktionStadt'Last;
               
            elsif
              GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate + ProduktionrateExtern < EinheitStadtDatentypen.GesamtproduktionStadt'First
            then
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate := EinheitStadtDatentypen.GesamtproduktionStadt'First;
               
            else
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate
                 := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate + ProduktionrateExtern;
            end if;
            
         when False =>
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate := ProduktionrateExtern;
      end case;
      
      Bauzeit (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
   end Produktionrate;
   
   
   
   procedure Geldgewinnung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      GeldgewinnungExtern : in EinheitStadtDatentypen.GesamtproduktionStadt;
      ÄndernSetzenExtern : in Boolean)
   is begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Geldgewinnung + GeldgewinnungExtern > EinheitStadtDatentypen.GesamtproduktionStadt'Last
            then
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Geldgewinnung := EinheitStadtDatentypen.GesamtproduktionStadt'Last;
               
            elsif
              GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Geldgewinnung + GeldgewinnungExtern < EinheitStadtDatentypen.GesamtproduktionStadt'First
            then
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Geldgewinnung := EinheitStadtDatentypen.GesamtproduktionStadt'First;
               
            else
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Geldgewinnung
                 := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Geldgewinnung + GeldgewinnungExtern;
            end if;
            
         when False =>
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Geldgewinnung := GeldgewinnungExtern;
      end case;
      
   end Geldgewinnung;
   
   
   
   procedure PermanenteKostenPosten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      WelcherPostenExtern : in EinheitStadtDatentypen.Permanente_Kosten_Verwendet_Enum;
      KostenExtern : in EinheitStadtDatentypen.GesamtePermanenteKosten;
      ÄndernSetzenExtern : in Boolean)
   is begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).PermanenteKostenPosten (WelcherPostenExtern) + KostenExtern > EinheitStadtDatentypen.GesamtproduktionStadt'Last
            then
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).PermanenteKostenPosten (WelcherPostenExtern) := EinheitStadtDatentypen.GesamtproduktionStadt'Last;
               
            elsif
              GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).PermanenteKostenPosten (WelcherPostenExtern) + KostenExtern < EinheitStadtDatentypen.GesamtproduktionStadt'First
            then
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).PermanenteKostenPosten (WelcherPostenExtern) := EinheitStadtDatentypen.GesamtproduktionStadt'First;
               
            else
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).PermanenteKostenPosten (WelcherPostenExtern)
                 := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).PermanenteKostenPosten (WelcherPostenExtern) + KostenExtern;
            end if;
            
         when False =>
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).PermanenteKostenPosten (WelcherPostenExtern) := KostenExtern;
      end case;
      
   end PermanenteKostenPosten;
   
   
      
   procedure Forschungsrate
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      ForschungsrateExtern : in EinheitStadtDatentypen.GesamtproduktionStadt;
      ÄndernSetzenExtern : in Boolean)
   is begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Forschungsrate + ForschungsrateExtern > EinheitStadtDatentypen.GesamtproduktionStadt'Last
            then
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Forschungsrate := EinheitStadtDatentypen.GesamtproduktionStadt'Last;
               
            elsif
              GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Forschungsrate + ForschungsrateExtern < StadtKonstanten.LeerStadt.Forschungsrate
            then
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Forschungsrate := StadtKonstanten.LeerStadt.Forschungsrate;
               
            else
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Forschungsrate
                 := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Forschungsrate + ForschungsrateExtern;
            end if;
            
         when False =>
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Forschungsrate := ForschungsrateExtern;
      end case;
      
   end Forschungsrate;
   
   
   
   procedure Bauprojekt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      BauprojektExtern : in Natural)
   is begin
      
      case
        BauprojektExtern
      is
         when StadtKonstanten.BauprojekteGebäudeAnfang .. StadtKonstanten.BauprojekteGebäudeEnde | StadtKonstanten.BauprojekteEinheitenAnfang .. StadtKonstanten.BauprojekteEinheitenEnde =>
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt := BauprojektExtern;
            
         when others =>
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt := StadtKonstanten.LeerStadt.Bauprojekt;
      end case;
      
      Bauzeit (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
   end Bauprojekt;
   
   
   
   procedure Bauzeit
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      if
        (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt not in StadtKonstanten.BauprojekteGebäudeAnfang .. StadtKonstanten.BauprojekteGebäudeEnde
         and
           GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt not in StadtKonstanten.BauprojekteEinheitenAnfang .. StadtKonstanten.BauprojekteEinheitenEnde)
        or
          GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate <= 0
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauzeit := EinheitStadtDatentypen.KostenLager'Last;
         
      elsif
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt in StadtKonstanten.BauprojekteGebäudeAnfang .. StadtKonstanten.BauprojekteGebäudeEnde
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauzeit
           := (LeseGebaeudeDatenbank.PreisRessourcen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                      IDExtern    =>
                                                        EinheitStadtDatentypen.GebäudeID (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt
                                                          - StadtKonstanten.GebäudeAufschlag))
               - GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Ressourcen)
             / GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate;
                  
      else
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauzeit
           := (LeseEinheitenDatenbank.PreisRessourcen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                       IDExtern    =>
                                                         EinheitStadtDatentypen.EinheitenID (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt
                                                           - EinheitenKonstanten.EinheitAufschlag))
               - GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Ressourcen)
             / GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate;
      end if;
      
   end Bauzeit;
      
   
   
   procedure Korruption
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      KorruptionExtern : in EinheitStadtDatentypen.GesamtproduktionStadt;
      ÄndernSetzenExtern : in Boolean)
   is begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Korruption + KorruptionExtern > EinheitStadtDatentypen.GesamtproduktionStadt'Last
            then
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Korruption := EinheitStadtDatentypen.GesamtproduktionStadt'Last;
               
            elsif
              GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Korruption + KorruptionExtern < EinheitStadtDatentypen.GesamtproduktionStadt'First
            then
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Korruption := EinheitStadtDatentypen.GesamtproduktionStadt'First;
               
            else
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Korruption
                 := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Korruption + KorruptionExtern;
            end if;
            
         when False =>
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Korruption := KorruptionExtern;
      end case;
      
   end Korruption;
   
   
   
   procedure GebäudeVorhanden
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      WelchesGebäudeExtern : in EinheitStadtDatentypen.GebäudeID;
      HinzufügenEntfernenExtern : in Boolean)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).GebäudeVorhanden (WelchesGebäudeExtern) := HinzufügenEntfernenExtern;
      
   end GebäudeVorhanden;
   
   
   
   procedure Name
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      NameExtern : in Unbounded_Wide_Wide_String)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Name := NameExtern;
      
   end Name;
   
   
   
   procedure UmgebungBewirtschaftung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      YPositionExtern, XPositionExtern : in KartenDatentypen.LoopRangeMinusDreiZuDrei;
      BelegenEntfernenExtern : in Boolean)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungBewirtschaftung (YPositionExtern, XPositionExtern) := BelegenEntfernenExtern;
      
   end UmgebungBewirtschaftung;
   
   
   
   procedure UmgebungGröße
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      UmgebungGrößeExtern : in KartenDatentypen.LoopRangeMinusDreiZuDrei;
      ÄndernSetzenExtern : in Boolean)
   is begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße + UmgebungGrößeExtern > KartenDatentypen.LoopRangeMinusDreiZuDrei'Last
            then
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße := KartenDatentypen.LoopRangeMinusDreiZuDrei'Last;
               
            elsif
              GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße + UmgebungGrößeExtern < StadtKonstanten.LeerStadt.UmgebungGröße
            then
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße := StadtKonstanten.LeerStadt.UmgebungGröße;
               
            else
               GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße
                 := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße + UmgebungGrößeExtern;
            end if;
            
         when False =>
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße := UmgebungGrößeExtern;
      end case;
      
   end UmgebungGröße;
      
   
      
   procedure Meldungen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      WelcheMeldungExtern : in EinheitStadtDatentypen.Stadt_Meldung_Art_Enum;
      MeldungExtern : in EinheitStadtDatentypen.Stadt_Meldung_Enum)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Meldungen (WelcheMeldungExtern) := MeldungExtern;
      
   end Meldungen;
   
      
      
   procedure KIBeschäftigung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      BeschäftigungExtern : in KIDatentypen.Stadt_Aufgabe_Enum)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).KIBeschäftigung := BeschäftigungExtern;
      
   end KIBeschäftigung;
   
   
   
   procedure Nullsetzung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer) := StadtKonstanten.LeerStadt;
      
   end Nullsetzung;
   
   
   
   procedure GanzerEintrag
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EintragExtern : in EinheitStadtRecords.StadtGebautRecord)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer) := EintragExtern;
      
   end GanzerEintrag;

end SchreibeStadtGebaut;
