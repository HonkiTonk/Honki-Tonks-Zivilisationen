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
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in KartenverbesserungDatentypen.Verbesserung_Stadt_ID_Enum)
   is begin
      
      GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).ID := IDExtern;
      
   end ID;
   
   
   
   procedure Koordinaten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibeStadtGebaut.Koordinaten: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            
         when others =>
            GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).KoordinatenAktuell := KoordinatenExtern;
      end case;
      
   end Koordinaten;
   
   
   
   procedure EinwohnerArbeiter
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinwohnerArbeiterExtern : in Boolean;
      WachsenSchrumpfenExtern : in Boolean)
   is
      use type ProduktionDatentypen.Einwohner;
   begin
      
      case
        EinwohnerArbeiterExtern
      is
         when True =>
            AktuelleEinwohner := GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).EinwohnerArbeiter (1);
            
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
            
            GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).EinwohnerArbeiter (1) := AktuelleEinwohner;
            
         when False =>
            AktuelleArbeiter := GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).EinwohnerArbeiter (2);
            
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
            
            GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).EinwohnerArbeiter (2) := AktuelleArbeiter;
      end case;
      
   end EinwohnerArbeiter;
   
      
      
   procedure Nahrungsmittel
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
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
              GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Nahrungsmittel + NahrungsmittelExtern >= ProduktionDatentypen.Stadtproduktion'Last
            then
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Nahrungsmittel := ProduktionDatentypen.StadtLagermenge'Last;
               
            elsif
              GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Nahrungsmittel + NahrungsmittelExtern <= ProduktionDatentypen.Stadtproduktion'First
            then
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Nahrungsmittel := StadtKonstanten.LeerNahrungsmittel;
               
            else
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Nahrungsmittel
                 := GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Nahrungsmittel + NahrungsmittelExtern;
            end if;
            
         when False =>
            GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Nahrungsmittel := NahrungsmittelExtern;
      end case;
      
   end Nahrungsmittel;
   
   
   
   procedure Nahrungsproduktion
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
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
              GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Nahrungsproduktion + NahrungsproduktionExtern >= ProduktionDatentypen.Stadtproduktion'Last
            then
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Nahrungsproduktion := ProduktionDatentypen.Stadtproduktion'Last;
               
            elsif
              GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Nahrungsproduktion + NahrungsproduktionExtern <= ProduktionDatentypen.Stadtproduktion'First
            then
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Nahrungsproduktion := ProduktionDatentypen.Stadtproduktion'First;
               
            else
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Nahrungsproduktion
                 := GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Nahrungsproduktion + NahrungsproduktionExtern;
            end if;
            
         when False =>
            GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Nahrungsproduktion := NahrungsproduktionExtern;
      end case;
      
   end Nahrungsproduktion;
   
   
   
   procedure Material
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      MaterialExtern : in ProduktionDatentypen.Produktion;
      ÄndernSetzenExtern : in Boolean)
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Material + MaterialExtern >= ProduktionDatentypen.StadtLagermenge'Last
            then
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Material := ProduktionDatentypen.StadtLagermenge'Last;
               
            elsif
              GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Material + MaterialExtern <= StadtKonstanten.LeerMaterial
            then
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Material := StadtKonstanten.LeerMaterial;
               
            else
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Material
                 := GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Material + MaterialExtern;
            end if;
            
         when False =>
            GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Material := MaterialExtern;
      end case;
      
      Bauzeit (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
   end Material;
   
   
   
   procedure Produktionrate
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
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
              GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Produktionrate + ProduktionrateExtern >= ProduktionDatentypen.Stadtproduktion'Last
            then
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Produktionrate := ProduktionDatentypen.Stadtproduktion'Last;
               
            elsif
              GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Produktionrate + ProduktionrateExtern <= ProduktionDatentypen.Stadtproduktion'First
            then
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Produktionrate := ProduktionDatentypen.Stadtproduktion'First;
               
            else
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Produktionrate
                 := GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Produktionrate + ProduktionrateExtern;
            end if;
            
         when False =>
            GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Produktionrate := ProduktionrateExtern;
      end case;
      
      Bauzeit (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
   end Produktionrate;
   
   
   
   procedure Geldgewinnung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
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
              GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Geldgewinnung + GeldgewinnungExtern >= ProduktionDatentypen.Stadtproduktion'Last
            then
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Geldgewinnung := ProduktionDatentypen.Stadtproduktion'Last;
               
            elsif
              GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Geldgewinnung + GeldgewinnungExtern <= ProduktionDatentypen.Stadtproduktion'First
            then
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Geldgewinnung := ProduktionDatentypen.Stadtproduktion'First;
               
            else
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Geldgewinnung
                 := GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Geldgewinnung + GeldgewinnungExtern;
            end if;
            
         when False =>
            GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Geldgewinnung := GeldgewinnungExtern;
      end case;
      
   end Geldgewinnung;
   
   
   
   procedure PermanenteKostenPosten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
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
              GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).PermanenteKostenPosten (WelcherPostenExtern) + KostenExtern >= ProduktionDatentypen.Stadtproduktion'Last
            then
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).PermanenteKostenPosten (WelcherPostenExtern) := ProduktionDatentypen.Stadtproduktion'Last;
               
            elsif
              GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).PermanenteKostenPosten (WelcherPostenExtern) + KostenExtern <= ProduktionDatentypen.Stadtproduktion'First
            then
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).PermanenteKostenPosten (WelcherPostenExtern) := ProduktionDatentypen.Stadtproduktion'First;
               
            else
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).PermanenteKostenPosten (WelcherPostenExtern)
                 := GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).PermanenteKostenPosten (WelcherPostenExtern) + KostenExtern;
            end if;
            
         when False =>
            GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).PermanenteKostenPosten (WelcherPostenExtern) := KostenExtern;
      end case;
      
   end PermanenteKostenPosten;
   
   
      
   procedure Forschungsrate
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
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
              GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Forschungsrate + ForschungsrateExtern >= ProduktionDatentypen.Stadtproduktion'Last
            then
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Forschungsrate := ProduktionDatentypen.Stadtproduktion'Last;
               
            elsif
              GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Forschungsrate + ForschungsrateExtern <= StadtKonstanten.LeerForschungsrate
            then
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Forschungsrate := StadtKonstanten.LeerForschungsrate;
               
            else
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Forschungsrate
                 := GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Forschungsrate + ForschungsrateExtern;
            end if;
            
         when False =>
            GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Forschungsrate := ForschungsrateExtern;
      end case;
      
   end Forschungsrate;
   
   
   
   procedure Bauprojekt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      BauprojektExtern : in StadtRecords.BauprojektRecord)
   is begin
      
      GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Bauprojekt := BauprojektExtern;
      
      Bauzeit (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
   end Bauprojekt;
   
   
   
   procedure Bauzeit
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      if
        (GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Bauprojekt.Gebäude = 0
         and
           GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Bauprojekt.Einheit = 0)
        or
          GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Produktionrate <= 0
      then
         GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Bauzeit := ProduktionDatentypen.Produktion'Last;
         
      elsif
        GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Bauprojekt.Gebäude /= 0
      then
         GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Bauzeit
           := (LeseGebaeudeDatenbank.Produktionskosten (SpeziesExtern => StadtSpeziesNummerExtern.Spezies,
                                                        IDExtern    => StadtDatentypen.GebäudeID (GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Bauprojekt.Gebäude))
               - GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Material)
             / GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Produktionrate;
                  
      else
         GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Bauzeit
           := (LeseEinheitenDatenbank.Produktionskosten (SpeziesExtern => StadtSpeziesNummerExtern.Spezies,
                                                         IDExtern    => EinheitenDatentypen.EinheitenID (GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Bauprojekt.Einheit))
               - GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Material)
             / GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Produktionrate;
      end if;
      
   end Bauzeit;
   
   
   
   procedure Korruption
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
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
              GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Korruption + KorruptionExtern >= ProduktionDatentypen.Stadtproduktion'Last
            then
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Korruption := ProduktionDatentypen.Stadtproduktion'Last;
               
            elsif
              GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Korruption + KorruptionExtern <= StadtKonstanten.LeerKorruption
            then
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Korruption := StadtKonstanten.LeerKorruption;
               
            else
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Korruption
                 := GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Korruption + KorruptionExtern;
            end if;
            
         when False =>
            GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Korruption := KorruptionExtern;
      end case;
      
   end Korruption;
   
   
   
   procedure Zufriedenheit
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
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
              GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Zufriedenheit + ZufriedenheitExtern >= ProduktionDatentypen.Feldproduktion'Last
            then
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Zufriedenheit := ProduktionDatentypen.Feldproduktion'Last;
               
               -- Der Änderungswert kann aktuell nicht kleiner als 0 sein, später mal anpassen. äöü
               -- Passe ich den Datentyp an sich an oder tausche ich ihn aus? äöü
               -- Vermutlich ist austauschen am sinnvollsten. äöü
            elsif
              GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Zufriedenheit + ZufriedenheitExtern = StadtKonstanten.LeerZufriedenheit
            then
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Zufriedenheit := StadtKonstanten.LeerZufriedenheit;
               
            else
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Zufriedenheit
                 := GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Zufriedenheit + ZufriedenheitExtern;
            end if;
            
         when False =>
            GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Zufriedenheit := ZufriedenheitExtern;
      end case;
      
   end Zufriedenheit;
   
   
   
   procedure GebäudeVorhanden
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      WelchesGebäudeExtern : in StadtDatentypen.GebäudeID;
      HinzufügenEntfernenExtern : in Boolean)
   is begin
      
      GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).GebäudeVorhanden (WelchesGebäudeExtern) := HinzufügenEntfernenExtern;
      
   end GebäudeVorhanden;
   
   
   
   procedure Name
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      NameExtern : in Unbounded_Wide_Wide_String)
   is begin
      
      GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Name := NameExtern;
      
   end Name;
   
   
   
   procedure UmgebungBewirtschaftung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      YKoordinateExtern : in KartenDatentypen.UmgebungsbereichDrei;
      XKoordinateExtern : in KartenDatentypen.UmgebungsbereichDrei;
      BelegenEntfernenExtern : in Boolean)
   is begin
      
      GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).UmgebungBewirtschaftung (YKoordinateExtern, XKoordinateExtern) := BelegenEntfernenExtern;
      
   end UmgebungBewirtschaftung;
   
   
   
   procedure UmgebungGröße
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      UmgebungGrößeExtern : in KartenDatentypen.UmgebungsbereichDrei;
      ÄndernSetzenExtern : in Boolean)
   is begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).UmgebungGröße + UmgebungGrößeExtern >= KartenDatentypen.UmgebungsbereichDrei'Last
            then
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).UmgebungGröße := KartenDatentypen.UmgebungsbereichDrei'Last;
               
            elsif
              GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).UmgebungGröße + UmgebungGrößeExtern <= StadtKonstanten.LeerUmgebungGröße
            then
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).UmgebungGröße := StadtKonstanten.LeerUmgebungGröße;
               
            else
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).UmgebungGröße
                 := GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).UmgebungGröße + UmgebungGrößeExtern;
            end if;
            
         when False =>
            GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).UmgebungGröße := UmgebungGrößeExtern;
      end case;
      
   end UmgebungGröße;
      
   
      
   procedure Meldungen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      WelcheMeldungExtern : in StadtDatentypen.Stadt_Meldung_Art_Enum;
      MeldungExtern : in StadtDatentypen.Stadt_Meldung_Enum)
   is begin
      
      GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Meldungen (WelcheMeldungExtern) := MeldungExtern;
      
   end Meldungen;
      
   
      
   procedure LeerMeldungen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
      
      GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Meldungen := (others => StadtDatentypen.Leer_Stadt_Meldung_Enum);
      
   end LeerMeldungen;
   
      
      
   procedure KIBeschäftigung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      BeschäftigungExtern : in KIDatentypen.Stadt_Aufgabe_Enum)
   is begin
      
      GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).KIBeschäftigung := BeschäftigungExtern;
      
   end KIBeschäftigung;
   
   
   
   procedure Bewohnerentfernung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
      
      GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).EinwohnerArbeiter (1) := 0;
      GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).EinwohnerArbeiter (2) := 0;
      
   end Bewohnerentfernung;
   
   
   
   procedure Nullsetzung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
      
      Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
      case
        Stadtkoordinaten.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            null;
            
         when others =>
            SchreibeWeltkarte.Verbesserung (KoordinatenExtern  => Stadtkoordinaten,
                                            VerbesserungExtern => KartenverbesserungDatentypen.Leer_Verbesserung_Enum);
      end case;
      
      GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer) := StadtRecordKonstanten.LeerStadt;
      
   end Nullsetzung;
   
   
   
   procedure GanzerEintrag
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EintragExtern : in StadtRecords.StadtGebautRecord)
   is begin
      
      GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer) := EintragExtern;
      
   end GanzerEintrag;
   
   
   
   procedure Standardeinstellungen
   is begin
      
      GebautVariablen.StadtGebaut := (others => (others => StadtRecordKonstanten.LeerStadt));
      
   end Standardeinstellungen;

end SchreibeStadtGebaut;
