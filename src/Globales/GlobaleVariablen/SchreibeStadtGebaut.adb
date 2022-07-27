pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ProduktionDatentypen; use ProduktionDatentypen;
with StadtKonstanten;
with StadtRecordKonstanten;

with LeseGebaeudeDatenbank;
with LeseEinheitenDatenbank;

-- Stadt (und eventuell einige andere Sachen) werden nicht vollständig auf Leer gesetzt beim entfernen, das mal besser ändern. äöü
--  and
-- KoordinatenExtern.YAchse in Karten.WeltkarteArray'First (2) .. Karten.Karteneinstellungen.Kartengröße.YAchse
--  and
-- KoordinatenExtern.XAchse in Karten.WeltkarteArray'First (3) .. Karten.Karteneinstellungen.Kartengröße.XAchse);
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
      WachsenSchrumpfenExtern : in Boolean)
   is begin
      
      case
        EinwohnerArbeiterExtern
      is
         when True =>
            AktuelleEinwohner := SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).EinwohnerArbeiter (1);
            
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
            
            SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).EinwohnerArbeiter (1) := AktuelleEinwohner;
            
         when False =>
            AktuelleArbeiter := SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).EinwohnerArbeiter (2);
            
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
            
            SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).EinwohnerArbeiter (2) := AktuelleArbeiter;
      end case;
      
   end EinwohnerArbeiter;
   
      
      
   procedure Nahrungsmittel
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      NahrungsmittelExtern : in ProduktionDatentypen.Stadtproduktion;
      ÄndernSetzenExtern : in Boolean)
   is begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsmittel + NahrungsmittelExtern >= ProduktionDatentypen.StadtLagermenge'Last
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsmittel := ProduktionDatentypen.StadtLagermenge'Last;
               
            elsif
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsmittel + NahrungsmittelExtern <= StadtKonstanten.LeerNahrungsmittel
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsmittel := StadtKonstanten.LeerNahrungsmittel;
               
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
      NahrungsproduktionExtern : in ProduktionDatentypen.Stadtproduktion;
      ÄndernSetzenExtern : in Boolean)
   is begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsproduktion + NahrungsproduktionExtern >= ProduktionDatentypen.Stadtproduktion'Last
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsproduktion := ProduktionDatentypen.Stadtproduktion'Last;
               
            elsif
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsproduktion + NahrungsproduktionExtern <= ProduktionDatentypen.Stadtproduktion'First
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Nahrungsproduktion := ProduktionDatentypen.Stadtproduktion'First;
               
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
      RessourcenExtern : in ProduktionDatentypen.Produktion;
      ÄndernSetzenExtern : in Boolean)
   is begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Ressourcen + RessourcenExtern >= ProduktionDatentypen.Produktion'Last
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Ressourcen := ProduktionDatentypen.StadtLagermenge'Last;
               
            elsif
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Ressourcen + RessourcenExtern <= StadtKonstanten.LeerRessourcen
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Ressourcen := StadtKonstanten.LeerRessourcen;
               
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
      ProduktionrateExtern : in ProduktionDatentypen.Stadtproduktion;
      ÄndernSetzenExtern : in Boolean)
   is begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Produktionrate + ProduktionrateExtern >= ProduktionDatentypen.Stadtproduktion'Last
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Produktionrate := ProduktionDatentypen.Stadtproduktion'Last;
               
            elsif
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Produktionrate + ProduktionrateExtern <= ProduktionDatentypen.Stadtproduktion'First
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Produktionrate := ProduktionDatentypen.Stadtproduktion'First;
               
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
      GeldgewinnungExtern : in ProduktionDatentypen.Stadtproduktion;
      ÄndernSetzenExtern : in Boolean)
   is begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Geldgewinnung + GeldgewinnungExtern >= ProduktionDatentypen.Stadtproduktion'Last
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Geldgewinnung := ProduktionDatentypen.Stadtproduktion'Last;
               
            elsif
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Geldgewinnung + GeldgewinnungExtern <= ProduktionDatentypen.Stadtproduktion'First
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Geldgewinnung := ProduktionDatentypen.Stadtproduktion'First;
               
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
      KostenExtern : in ProduktionDatentypen.Stadtproduktion;
      ÄndernSetzenExtern : in Boolean)
   is begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).PermanenteKostenPosten (WelcherPostenExtern) + KostenExtern >= ProduktionDatentypen.Stadtproduktion'Last
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).PermanenteKostenPosten (WelcherPostenExtern) := ProduktionDatentypen.Stadtproduktion'Last;
               
            elsif
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).PermanenteKostenPosten (WelcherPostenExtern) + KostenExtern <= ProduktionDatentypen.Stadtproduktion'First
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).PermanenteKostenPosten (WelcherPostenExtern) := ProduktionDatentypen.Stadtproduktion'First;
               
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
      ForschungsrateExtern : in ProduktionDatentypen.Stadtproduktion;
      ÄndernSetzenExtern : in Boolean)
   is begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Forschungsrate + ForschungsrateExtern >= ProduktionDatentypen.Stadtproduktion'Last
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Forschungsrate := ProduktionDatentypen.Stadtproduktion'Last;
               
            elsif
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Forschungsrate + ForschungsrateExtern <= StadtKonstanten.LeerForschungsrate
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Forschungsrate := StadtKonstanten.LeerForschungsrate;
               
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
         SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Bauzeit := ProduktionDatentypen.Produktion'Last;
         
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
      KorruptionExtern : in ProduktionDatentypen.Stadtproduktion;
      ÄndernSetzenExtern : in Boolean)
   is begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Korruption + KorruptionExtern >= ProduktionDatentypen.Stadtproduktion'Last
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Korruption := ProduktionDatentypen.Stadtproduktion'Last;
               
            elsif
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Korruption + KorruptionExtern <= StadtKonstanten.LeerKorruption
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Korruption := StadtKonstanten.LeerKorruption;
               
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
      ZufriedenheitExtern : in ProduktionDatentypen.Feldproduktion;
      ÄndernSetzenExtern : in Boolean)
   is begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Zufriedenheit + ZufriedenheitExtern >= ProduktionDatentypen.Feldproduktion'Last
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Zufriedenheit := ProduktionDatentypen.Feldproduktion'Last;
               
               -- Der Änderungswert kann aktuell nicht kleiner als 0 sein, später mal anpassen. äöü
            elsif
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Zufriedenheit + ZufriedenheitExtern = StadtKonstanten.LeerZufriedenheit
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Zufriedenheit := StadtKonstanten.LeerZufriedenheit;
               
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
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).UmgebungGröße + UmgebungGrößeExtern >= KartenDatentypen.UmgebungsbereichDrei'Last
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).UmgebungGröße := KartenDatentypen.UmgebungsbereichDrei'Last;
               
            elsif
              SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).UmgebungGröße + UmgebungGrößeExtern <= StadtKonstanten.LeerUmgebungGröße
            then
               SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).UmgebungGröße := StadtKonstanten.LeerUmgebungGröße;
               
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
      
      SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer) := StadtRecordKonstanten.LeerStadt;
      
   end Nullsetzung;
   
   
   
   procedure GanzerEintrag
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EintragExtern : in StadtRecords.StadtGebautRecord)
   is begin
      
      SpielVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer) := EintragExtern;
      
   end GanzerEintrag;

end SchreibeStadtGebaut;
