with StadtRecordKonstanten;
with GebautVariablen;

with LeseGebaeudeDatenbank;
with LeseEinheitenDatenbank;
with SchreibeWeltkarte;
with LeseStadtGebaut;

with Fehlermeldungssystem;
with FehlermeldungssystemZusatzinformationen;

package body SchreibeStadtGebaut is

   procedure ID
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      IDExtern : in KartenverbesserungDatentypen.Karten_Verbesserung_Stadt_ID_Enum)
   is begin
      
      GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).ID := IDExtern;
      
   end ID;
   
   
   
   procedure Koordinaten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibeStadtGebaut.Koordinaten: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            
         when others =>
            GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).KoordinatenAktuell := KoordinatenExtern;
      end case;
      
   end Koordinaten;
   
   
   
   procedure EinwohnerArbeiter
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EinwohnerArbeiterExtern : in Boolean;
      WachsenSchrumpfenExtern : in Boolean)
   is
      use type ProduktionDatentypen.Einwohner;
   begin
      
      case
        EinwohnerArbeiterExtern
      is
         when True =>
            AktuelleEinwohner := GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).EinwohnerArbeiter (1);
            
            if
              WachsenSchrumpfenExtern
              and
                AktuelleEinwohner + 1 >= ProduktionDatentypen.Einwohner'Last
            then
               AktuelleEinwohner := ProduktionDatentypen.Einwohner'Last;
               
            elsif
              WachsenSchrumpfenExtern
            then
               AktuelleEinwohner := AktuelleEinwohner + 1;
               
            elsif
              WachsenSchrumpfenExtern = False
              and
                AktuelleEinwohner - 1 <= StadtKonstanten.LeerEinwohner
            then
               AktuelleEinwohner := StadtKonstanten.LeerEinwohner;
            
            else
               AktuelleEinwohner := AktuelleEinwohner - 1;
            end if;
            
            GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).EinwohnerArbeiter (1) := AktuelleEinwohner;
            
         when False =>
            AktuelleArbeiter := GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).EinwohnerArbeiter (2);
            
            if
              WachsenSchrumpfenExtern
              and
                AktuelleArbeiter + 1 >= ProduktionDatentypen.Einwohner'Last
            then
               AktuelleArbeiter := ProduktionDatentypen.Einwohner'Last;
               
            elsif
              WachsenSchrumpfenExtern
            then
               AktuelleArbeiter := AktuelleArbeiter + 1;
               
            elsif
              WachsenSchrumpfenExtern = False
              and
                AktuelleArbeiter - 1 <= StadtKonstanten.LeerArbeiter
            then
               AktuelleArbeiter := StadtKonstanten.LeerArbeiter;
            
            else
               AktuelleArbeiter := AktuelleArbeiter - 1;
            end if;
            
            GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).EinwohnerArbeiter (2) := AktuelleArbeiter;
      end case;
      
   end EinwohnerArbeiter;
   
      
      
   procedure Nahrungsmittel
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      NahrungsmittelExtern : in ProduktionDatentypen.Stadtproduktion;
      ÄndernSetzenExtern : in Boolean)
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsmittel + NahrungsmittelExtern >= ProduktionDatentypen.Stadtproduktion'Last
            then
               GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsmittel := ProduktionDatentypen.StadtLagermenge'Last;
               
            elsif
              GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsmittel + NahrungsmittelExtern <= ProduktionDatentypen.Stadtproduktion'First
            then
               GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsmittel := StadtKonstanten.LeerNahrungsmittel;
               
            else
               GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsmittel
                 := GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsmittel + NahrungsmittelExtern;
            end if;
            
         when False =>
            GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsmittel := NahrungsmittelExtern;
      end case;
      
   end Nahrungsmittel;
   
   
   
   procedure Nahrungsproduktion
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      NahrungsproduktionExtern : in ProduktionDatentypen.Stadtproduktion;
      ÄndernSetzenExtern : in Boolean)
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsproduktion + NahrungsproduktionExtern >= ProduktionDatentypen.Stadtproduktion'Last
            then
               GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsproduktion := ProduktionDatentypen.Stadtproduktion'Last;
               
            elsif
              GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsproduktion + NahrungsproduktionExtern <= ProduktionDatentypen.Stadtproduktion'First
            then
               GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsproduktion := ProduktionDatentypen.Stadtproduktion'First;
               
            else
               GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsproduktion
                 := GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsproduktion + NahrungsproduktionExtern;
            end if;
            
         when False =>
            GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsproduktion := NahrungsproduktionExtern;
      end case;
      
   end Nahrungsproduktion;
   
   
   
   procedure Ressourcen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      RessourcenExtern : in ProduktionDatentypen.Produktion;
      ÄndernSetzenExtern : in Boolean)
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Ressourcen + RessourcenExtern >= ProduktionDatentypen.StadtLagermenge'Last
            then
               GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Ressourcen := ProduktionDatentypen.StadtLagermenge'Last;
               
            elsif
              GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Ressourcen + RessourcenExtern <= StadtKonstanten.LeerRessourcen
            then
               GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Ressourcen := StadtKonstanten.LeerRessourcen;
               
            else
               GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Ressourcen
                 := GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Ressourcen + RessourcenExtern;
            end if;
            
         when False =>
            GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Ressourcen := RessourcenExtern;
      end case;
      
      Bauzeit (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
   end Ressourcen;
   
   
   
   procedure Produktionrate
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      ProduktionrateExtern : in ProduktionDatentypen.Stadtproduktion;
      ÄndernSetzenExtern : in Boolean)
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Produktionrate + ProduktionrateExtern >= ProduktionDatentypen.Stadtproduktion'Last
            then
               GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Produktionrate := ProduktionDatentypen.Stadtproduktion'Last;
               
            elsif
              GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Produktionrate + ProduktionrateExtern <= ProduktionDatentypen.Stadtproduktion'First
            then
               GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Produktionrate := ProduktionDatentypen.Stadtproduktion'First;
               
            else
               GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Produktionrate
                 := GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Produktionrate + ProduktionrateExtern;
            end if;
            
         when False =>
            GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Produktionrate := ProduktionrateExtern;
      end case;
      
      Bauzeit (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
   end Produktionrate;
   
   
   
   procedure Geldgewinnung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      GeldgewinnungExtern : in ProduktionDatentypen.Stadtproduktion;
      ÄndernSetzenExtern : in Boolean)
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Geldgewinnung + GeldgewinnungExtern >= ProduktionDatentypen.Stadtproduktion'Last
            then
               GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Geldgewinnung := ProduktionDatentypen.Stadtproduktion'Last;
               
            elsif
              GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Geldgewinnung + GeldgewinnungExtern <= ProduktionDatentypen.Stadtproduktion'First
            then
               GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Geldgewinnung := ProduktionDatentypen.Stadtproduktion'First;
               
            else
               GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Geldgewinnung
                 := GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Geldgewinnung + GeldgewinnungExtern;
            end if;
            
         when False =>
            GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Geldgewinnung := GeldgewinnungExtern;
      end case;
      
   end Geldgewinnung;
   
   
   
   procedure PermanenteKostenPosten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      WelcherPostenExtern : in ProduktionDatentypen.Permanente_Kosten_Verwendet_Enum;
      KostenExtern : in ProduktionDatentypen.Stadtproduktion;
      ÄndernSetzenExtern : in Boolean)
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).PermanenteKostenPosten (WelcherPostenExtern) + KostenExtern >= ProduktionDatentypen.Stadtproduktion'Last
            then
               GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).PermanenteKostenPosten (WelcherPostenExtern) := ProduktionDatentypen.Stadtproduktion'Last;
               
            elsif
              GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).PermanenteKostenPosten (WelcherPostenExtern) + KostenExtern <= ProduktionDatentypen.Stadtproduktion'First
            then
               GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).PermanenteKostenPosten (WelcherPostenExtern) := ProduktionDatentypen.Stadtproduktion'First;
               
            else
               GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).PermanenteKostenPosten (WelcherPostenExtern)
                 := GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).PermanenteKostenPosten (WelcherPostenExtern) + KostenExtern;
            end if;
            
         when False =>
            GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).PermanenteKostenPosten (WelcherPostenExtern) := KostenExtern;
      end case;
      
   end PermanenteKostenPosten;
   
   
      
   procedure Forschungsrate
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      ForschungsrateExtern : in ProduktionDatentypen.Stadtproduktion;
      ÄndernSetzenExtern : in Boolean)
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Forschungsrate + ForschungsrateExtern >= ProduktionDatentypen.Stadtproduktion'Last
            then
               GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Forschungsrate := ProduktionDatentypen.Stadtproduktion'Last;
               
            elsif
              GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Forschungsrate + ForschungsrateExtern <= StadtKonstanten.LeerForschungsrate
            then
               GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Forschungsrate := StadtKonstanten.LeerForschungsrate;
               
            else
               GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Forschungsrate
                 := GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Forschungsrate + ForschungsrateExtern;
            end if;
            
         when False =>
            GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Forschungsrate := ForschungsrateExtern;
      end case;
      
   end Forschungsrate;
   
   
   
   procedure Bauprojekt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      BauprojektExtern : in StadtRecords.BauprojektRecord)
   is begin
      
      GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Bauprojekt := BauprojektExtern;
      
      Bauzeit (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
   end Bauprojekt;
   
   
   
   procedure Bauzeit
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      if
        (GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Bauprojekt.Gebäude = 0
         and
           GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Bauprojekt.Einheit = 0)
        or
          GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Produktionrate <= 0
      then
         GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Bauzeit := ProduktionDatentypen.Produktion'Last;
         
      elsif
        GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Bauprojekt.Gebäude /= 0
      then
         GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Bauzeit
           := (LeseGebaeudeDatenbank.Produktionskosten (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                        IDExtern    => StadtDatentypen.GebäudeID (GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Bauprojekt.Gebäude))
               - GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Ressourcen)
             / GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Produktionrate;
                  
      else
         GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Bauzeit
           := (LeseEinheitenDatenbank.Produktionskosten (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                         IDExtern    => EinheitenDatentypen.EinheitenID (GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Bauprojekt.Einheit))
               - GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Ressourcen)
             / GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Produktionrate;
      end if;
      
   end Bauzeit;
   
   
   
   procedure Korruption
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KorruptionExtern : in ProduktionDatentypen.Stadtproduktion;
      ÄndernSetzenExtern : in Boolean)
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Korruption + KorruptionExtern >= ProduktionDatentypen.Stadtproduktion'Last
            then
               GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Korruption := ProduktionDatentypen.Stadtproduktion'Last;
               
            elsif
              GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Korruption + KorruptionExtern <= StadtKonstanten.LeerKorruption
            then
               GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Korruption := StadtKonstanten.LeerKorruption;
               
            else
               GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Korruption
                 := GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Korruption + KorruptionExtern;
            end if;
            
         when False =>
            GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Korruption := KorruptionExtern;
      end case;
      
   end Korruption;
   
   
   
   procedure Zufriedenheit
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      ZufriedenheitExtern : in ProduktionDatentypen.Feldproduktion;
      ÄndernSetzenExtern : in Boolean)
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Zufriedenheit + ZufriedenheitExtern >= ProduktionDatentypen.Feldproduktion'Last
            then
               GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Zufriedenheit := ProduktionDatentypen.Feldproduktion'Last;
               
               -- Der Änderungswert kann aktuell nicht kleiner als 0 sein, später mal anpassen. äöü
               -- Passe ich den Datentyp an sich an oder tausche ich ihn aus? äöü
               -- Vermutlich ist austauschen am sinnvollsten. äöü
            elsif
              GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Zufriedenheit + ZufriedenheitExtern = StadtKonstanten.LeerZufriedenheit
            then
               GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Zufriedenheit := StadtKonstanten.LeerZufriedenheit;
               
            else
               GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Zufriedenheit
                 := GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Zufriedenheit + ZufriedenheitExtern;
            end if;
            
         when False =>
            GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Zufriedenheit := ZufriedenheitExtern;
      end case;
      
   end Zufriedenheit;
   
   
   
   procedure GebäudeVorhanden
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      WelchesGebäudeExtern : in StadtDatentypen.GebäudeID;
      HinzufügenEntfernenExtern : in Boolean)
   is begin
      
      GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).GebäudeVorhanden (WelchesGebäudeExtern) := HinzufügenEntfernenExtern;
      
   end GebäudeVorhanden;
   
   
   
   procedure Name
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      NameExtern : in Unbounded_Wide_Wide_String)
   is begin
      
      GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Name := NameExtern;
      
   end Name;
   
   
   
   procedure UmgebungBewirtschaftung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      YKoordinateExtern : in KartenDatentypen.UmgebungsbereichDrei;
      XKoordinateExtern : in KartenDatentypen.UmgebungsbereichDrei;
      BelegenEntfernenExtern : in Boolean)
   is begin
      
      GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).UmgebungBewirtschaftung (YKoordinateExtern, XKoordinateExtern) := BelegenEntfernenExtern;
      
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
              GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).UmgebungGröße + UmgebungGrößeExtern >= KartenDatentypen.UmgebungsbereichDrei'Last
            then
               GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).UmgebungGröße := KartenDatentypen.UmgebungsbereichDrei'Last;
               
            elsif
              GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).UmgebungGröße + UmgebungGrößeExtern <= StadtKonstanten.LeerUmgebungGröße
            then
               GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).UmgebungGröße := StadtKonstanten.LeerUmgebungGröße;
               
            else
               GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).UmgebungGröße
                 := GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).UmgebungGröße + UmgebungGrößeExtern;
            end if;
            
         when False =>
            GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).UmgebungGröße := UmgebungGrößeExtern;
      end case;
      
   end UmgebungGröße;
      
   
      
   procedure Meldungen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      WelcheMeldungExtern : in StadtDatentypen.Stadt_Meldung_Art_Enum;
      MeldungExtern : in StadtDatentypen.Stadt_Meldung_Enum)
   is begin
      
      GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Meldungen (WelcheMeldungExtern) := MeldungExtern;
      
   end Meldungen;
      
   
      
   procedure LeerMeldungen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Meldungen := (others => StadtDatentypen.Leer_Stadt_Meldung_Enum);
      
   end LeerMeldungen;
   
      
      
   procedure KIBeschäftigung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      BeschäftigungExtern : in KIDatentypen.Stadt_Aufgabe_Enum)
   is begin
      
      GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).KIBeschäftigung := BeschäftigungExtern;
      
   end KIBeschäftigung;
   
   
   
   procedure Bewohnerentfernung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).EinwohnerArbeiter (1) := 0;
      GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).EinwohnerArbeiter (2) := 0;
      
   end Bewohnerentfernung;
   
   
   
   procedure Nullsetzung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      case
        Stadtkoordinaten.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            null;
            
         when others =>
            SchreibeWeltkarte.Verbesserung (KoordinatenExtern  => Stadtkoordinaten,
                                            VerbesserungExtern => KartenverbesserungDatentypen.Leer_Verbesserung_Enum);
      end case;
      
      GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer) := StadtRecordKonstanten.LeerStadt;
      
   end Nullsetzung;
   
   
   
   procedure GanzerEintrag
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EintragExtern : in StadtRecords.StadtGebautRecord)
   is begin
      
      GebautVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer) := EintragExtern;
      
   end GanzerEintrag;
   
   
   
   procedure Standardeinstellungen
   is begin
      
      GebautVariablen.StadtGebaut := (others => (others => StadtRecordKonstanten.LeerStadt));
      
   end Standardeinstellungen;

end SchreibeStadtGebaut;
