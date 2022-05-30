pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
with StadtKonstanten;

with LeseGebaeudeDatenbank;
with LeseEinheitenDatenbank;

package body SchreibeStadtGebaut is

   procedure ID
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      IDExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Stadt_ID_Enum)
   is begin
      
      SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).ID := IDExtern;
      
   end ID;
   
   
   
   procedure Koordinaten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).KoordinatenAktuell := KoordinatenExtern;
      
   end Koordinaten;
   
   
   
   procedure EinwohnerArbeiter
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EinwohnerArbeiterExtern : in Boolean;
      ÄnderungExtern : in ProduktionDatentypen.ProduktionFeld)
   is begin
      
      case
        EinwohnerArbeiterExtern
      is
         when True =>
            if
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).EinwohnerArbeiter (1) + ÄnderungExtern > ProduktionDatentypen.ProduktionFeld'Last
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).EinwohnerArbeiter (1) := ProduktionDatentypen.ProduktionFeld'Last;
               
            elsif
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).EinwohnerArbeiter (1) + ÄnderungExtern < 0
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).EinwohnerArbeiter (1) := 0;
            
            else
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).EinwohnerArbeiter (1)
                 := SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).EinwohnerArbeiter (1) + ÄnderungExtern;
            end if;
            
         when False =>
            if
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).EinwohnerArbeiter (2) + ÄnderungExtern > ProduktionDatentypen.ProduktionFeld'Last
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).EinwohnerArbeiter (2) := ProduktionDatentypen.ProduktionFeld'Last;
               
            elsif
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).EinwohnerArbeiter (2) + ÄnderungExtern < 0
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).EinwohnerArbeiter (2) := 0;
            
            else
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).EinwohnerArbeiter (2)
                 := SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).EinwohnerArbeiter (2) + ÄnderungExtern;
            end if;
      end case;
      
   end EinwohnerArbeiter;
   
      
      
   procedure Nahrungsmittel
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      NahrungsmittelExtern : in ProduktionDatentypen.GesamtproduktionStadt;
      ÄndernSetzenExtern : in Boolean)
   is begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsmittel + NahrungsmittelExtern > ProduktionDatentypen.GesamtproduktionStadt'Last
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsmittel := ProduktionDatentypen.GesamtproduktionStadt'Last;
               
            elsif
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsmittel + NahrungsmittelExtern < ProduktionDatentypen.GesamtproduktionStadt'First
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsmittel := ProduktionDatentypen.GesamtproduktionStadt'First;
               
            else
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsmittel
                 := SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsmittel + NahrungsmittelExtern;
            end if;
            
         when False =>
            SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsmittel := NahrungsmittelExtern;
      end case;
      
   end Nahrungsmittel;
   
   
   
   procedure Nahrungsproduktion
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      NahrungsproduktionExtern : in ProduktionDatentypen.GesamtproduktionStadt;
      ÄndernSetzenExtern : in Boolean)
   is begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsproduktion + NahrungsproduktionExtern > ProduktionDatentypen.GesamtproduktionStadt'Last
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsproduktion := ProduktionDatentypen.GesamtproduktionStadt'Last;
               
            elsif
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsproduktion + NahrungsproduktionExtern < ProduktionDatentypen.GesamtproduktionStadt'First
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsproduktion := ProduktionDatentypen.GesamtproduktionStadt'First;
               
            else
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsproduktion
                 := SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsproduktion + NahrungsproduktionExtern;
            end if;
            
         when False =>
            SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsproduktion := NahrungsproduktionExtern;
      end case;
      
   end Nahrungsproduktion;
   
   
   
   procedure Ressourcen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      RessourcenExtern : in ProduktionDatentypen.KostenLager;
      ÄndernSetzenExtern : in Boolean)
   is begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Ressourcen + RessourcenExtern > ProduktionDatentypen.KostenLager'Last
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Ressourcen := ProduktionDatentypen.KostenLager'Last;
               
            elsif
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Ressourcen + RessourcenExtern < ProduktionDatentypen.KostenLager'First
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Ressourcen := ProduktionDatentypen.KostenLager'First;
               
            else
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Ressourcen
                 := SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Ressourcen + RessourcenExtern;
            end if;
            
         when False =>
            SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Ressourcen := RessourcenExtern;
      end case;
      
      Bauzeit (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
   end Ressourcen;
   
   
   
   procedure Produktionrate
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      ProduktionrateExtern : in ProduktionDatentypen.GesamtproduktionStadt;
      ÄndernSetzenExtern : in Boolean)
   is begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Produktionrate + ProduktionrateExtern > ProduktionDatentypen.GesamtproduktionStadt'Last
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Produktionrate := ProduktionDatentypen.GesamtproduktionStadt'Last;
               
            elsif
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Produktionrate + ProduktionrateExtern < ProduktionDatentypen.GesamtproduktionStadt'First
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Produktionrate := ProduktionDatentypen.GesamtproduktionStadt'First;
               
            else
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Produktionrate
                 := SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Produktionrate + ProduktionrateExtern;
            end if;
            
         when False =>
            SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Produktionrate := ProduktionrateExtern;
      end case;
      
      Bauzeit (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
   end Produktionrate;
   
   
   
   procedure Geldgewinnung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      GeldgewinnungExtern : in ProduktionDatentypen.GesamtproduktionStadt;
      ÄndernSetzenExtern : in Boolean)
   is begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Geldgewinnung + GeldgewinnungExtern > ProduktionDatentypen.GesamtproduktionStadt'Last
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Geldgewinnung := ProduktionDatentypen.GesamtproduktionStadt'Last;
               
            elsif
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Geldgewinnung + GeldgewinnungExtern < ProduktionDatentypen.GesamtproduktionStadt'First
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Geldgewinnung := ProduktionDatentypen.GesamtproduktionStadt'First;
               
            else
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Geldgewinnung
                 := SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Geldgewinnung + GeldgewinnungExtern;
            end if;
            
         when False =>
            SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Geldgewinnung := GeldgewinnungExtern;
      end case;
      
   end Geldgewinnung;
   
   
   
   procedure PermanenteKostenPosten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      WelcherPostenExtern : in ProduktionDatentypen.Permanente_Kosten_Verwendet_Enum;
      KostenExtern : in ProduktionDatentypen.GesamtePermanenteKosten;
      ÄndernSetzenExtern : in Boolean)
   is begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).PermanenteKostenPosten (WelcherPostenExtern) + KostenExtern > ProduktionDatentypen.GesamtproduktionStadt'Last
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).PermanenteKostenPosten (WelcherPostenExtern) := ProduktionDatentypen.GesamtproduktionStadt'Last;
               
            elsif
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).PermanenteKostenPosten (WelcherPostenExtern) + KostenExtern < ProduktionDatentypen.GesamtproduktionStadt'First
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).PermanenteKostenPosten (WelcherPostenExtern) := ProduktionDatentypen.GesamtproduktionStadt'First;
               
            else
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).PermanenteKostenPosten (WelcherPostenExtern)
                 := SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).PermanenteKostenPosten (WelcherPostenExtern) + KostenExtern;
            end if;
            
         when False =>
            SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).PermanenteKostenPosten (WelcherPostenExtern) := KostenExtern;
      end case;
      
   end PermanenteKostenPosten;
   
   
      
   procedure Forschungsrate
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      ForschungsrateExtern : in ProduktionDatentypen.GesamtproduktionStadt;
      ÄndernSetzenExtern : in Boolean)
   is begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Forschungsrate + ForschungsrateExtern > ProduktionDatentypen.GesamtproduktionStadt'Last
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Forschungsrate := ProduktionDatentypen.GesamtproduktionStadt'Last;
               
            elsif
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Forschungsrate + ForschungsrateExtern < StadtKonstanten.LeerStadt.Forschungsrate
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Forschungsrate := StadtKonstanten.LeerStadt.Forschungsrate;
               
            else
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Forschungsrate
                 := SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Forschungsrate + ForschungsrateExtern;
            end if;
            
         when False =>
            SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Forschungsrate := ForschungsrateExtern;
      end case;
      
   end Forschungsrate;
   
   
   
   procedure Bauprojekt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      BauprojektExtern : in StadtRecords.BauprojektRecord)
   is begin
      
      SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Bauprojekt := BauprojektExtern;
      
      Bauzeit (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
   end Bauprojekt;
   
   
   
   procedure Bauzeit
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      if
        (SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Bauprojekt.Gebäude = 0
         and
           SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Bauprojekt.Einheit = 0)
        or
          SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Produktionrate <= 0
      then
         SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Bauzeit := ProduktionDatentypen.KostenLager'Last;
         
      elsif
        SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Bauprojekt.Gebäude /= 0
      then
         SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Bauzeit
           := (LeseGebaeudeDatenbank.PreisRessourcen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                      IDExtern    => StadtDatentypen.GebäudeID (SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Bauprojekt.Gebäude))
               - SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Ressourcen)
             / SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Produktionrate;
                  
      else
         SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Bauzeit
           := (LeseEinheitenDatenbank.PreisRessourcen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                       IDExtern    => EinheitenDatentypen.EinheitenID (SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Bauprojekt.Einheit))
               - SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Ressourcen)
             / SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Produktionrate;
      end if;
      
   end Bauzeit;
   
   
   
   procedure Korruption
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KorruptionExtern : in ProduktionDatentypen.GesamtproduktionStadt;
      ÄndernSetzenExtern : in Boolean)
   is begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Korruption + KorruptionExtern > ProduktionDatentypen.GesamtproduktionStadt'Last
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Korruption := ProduktionDatentypen.GesamtproduktionStadt'Last;
               
            elsif
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Korruption + KorruptionExtern < ProduktionDatentypen.GesamtproduktionStadt'First
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Korruption := ProduktionDatentypen.GesamtproduktionStadt'First;
               
            else
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Korruption
                 := SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Korruption + KorruptionExtern;
            end if;
            
         when False =>
            SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Korruption := KorruptionExtern;
      end case;
      
   end Korruption;
   
   
   
   procedure Zufriedenheit
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      ZufriedenheitExtern : in ProduktionDatentypen.ProduktionFeld;
      ÄndernSetzenExtern : in Boolean)
   is begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Zufriedenheit + ZufriedenheitExtern > ProduktionDatentypen.ProduktionFeld'Last
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Zufriedenheit := ProduktionDatentypen.ProduktionFeld'Last;
               
            elsif
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Zufriedenheit + ZufriedenheitExtern < ProduktionDatentypen.ProduktionFeld'First
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Zufriedenheit := ProduktionDatentypen.ProduktionFeld'First;
               
            else
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Zufriedenheit
                 := SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Zufriedenheit + ZufriedenheitExtern;
            end if;
            
         when False =>
            SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Zufriedenheit := ZufriedenheitExtern;
      end case;
      
   end Zufriedenheit;
   
   
   
   procedure GebäudeVorhanden
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      WelchesGebäudeExtern : in StadtDatentypen.GebäudeID;
      HinzufügenEntfernenExtern : in Boolean)
   is begin
      
      SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).GebäudeVorhanden (WelchesGebäudeExtern) := HinzufügenEntfernenExtern;
      
   end GebäudeVorhanden;
   
   
   
   procedure Name
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      NameExtern : in Unbounded_Wide_Wide_String)
   is begin
      
      SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Name := NameExtern;
      
   end Name;
   
   
   
   procedure UmgebungBewirtschaftung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      YKoordinateExtern : in KartenDatentypen.UmgebungsbereichDrei;
      XKoordinateExtern : in KartenDatentypen.UmgebungsbereichDrei;
      BelegenEntfernenExtern : in Boolean)
   is begin
      
      SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).UmgebungBewirtschaftung (YKoordinateExtern, XKoordinateExtern) := BelegenEntfernenExtern;
      
   end UmgebungBewirtschaftung;
   
   
   
   procedure UmgebungGröße
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      UmgebungGrößeExtern : in KartenDatentypen.UmgebungsbereichDrei;
      ÄndernSetzenExtern : in Boolean)
   is begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).UmgebungGröße + UmgebungGrößeExtern > KartenDatentypen.UmgebungsbereichDrei'Last
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).UmgebungGröße := KartenDatentypen.UmgebungsbereichDrei'Last;
               
            elsif
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).UmgebungGröße + UmgebungGrößeExtern < StadtKonstanten.LeerStadt.UmgebungGröße
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).UmgebungGröße := StadtKonstanten.LeerStadt.UmgebungGröße;
               
            else
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).UmgebungGröße
                 := SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).UmgebungGröße + UmgebungGrößeExtern;
            end if;
            
         when False =>
            SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).UmgebungGröße := UmgebungGrößeExtern;
      end case;
      
   end UmgebungGröße;
      
   
      
   procedure Meldungen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      WelcheMeldungExtern : in StadtDatentypen.Stadt_Meldung_Art_Enum;
      MeldungExtern : in StadtDatentypen.Stadt_Meldung_Enum)
   is begin
      
      SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Meldungen (WelcheMeldungExtern) := MeldungExtern;
      
   end Meldungen;
   
      
      
   procedure KIBeschäftigung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      BeschäftigungExtern : in KIDatentypen.Stadt_Aufgabe_Enum)
   is begin
      
      SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).KIBeschäftigung := BeschäftigungExtern;
      
   end KIBeschäftigung;
   
   
   
   procedure Nullsetzung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer) := StadtKonstanten.LeerStadt;
      
   end Nullsetzung;
   
   
   
   procedure GanzerEintrag
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EintragExtern : in StadtRecords.StadtGebautRecord)
   is begin
      
      SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer) := EintragExtern;
      
   end GanzerEintrag;

end SchreibeStadtGebaut;
