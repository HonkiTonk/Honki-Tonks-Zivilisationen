with MeldungssystemHTSEB;

with StadtRecordKonstanten;
with GebautVariablen;

with LeseGebaeudeDatenbank;
with LeseEinheitenDatenbank;
with SchreibeWeltkarte;
with LeseStadtGebaut;
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
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
   is begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.LeerEbene =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "SchreibeStadtGebaut.Koordinaten: " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
            
         when others =>
            GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Koordinaten := KoordinatenExtern;
      end case;
      
   end Koordinaten;
   
   
   
   procedure IDKoordinatenLaden
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in KartenverbesserungDatentypen.Verbesserung_Städte_Enum;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
   is begin
      
      ID (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
          IDExtern                 => IDExtern);
      
      SchreibeWeltkarte.Verbesserung (KoordinatenExtern  => KoordinatenExtern,
                                      VerbesserungExtern => IDExtern);
      
      Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                   KoordinatenExtern        => KoordinatenExtern);
      
   end IDKoordinatenLaden;
   
   
   
   procedure EinwohnerArbeiter
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinwohnerArbeiterExtern : in Boolean;
      WachsenSchrumpfenExtern : in Boolean)
   is
      use type StadtDatentypen.Einwohner;
   begin
      
      case
        EinwohnerArbeiterExtern
      is
         when True =>
            AktuelleEinwohner := GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).EinwohnerArbeiter (1);
            
            if
              WachsenSchrumpfenExtern
              and
                AktuelleEinwohner + 1 >= StadtDatentypen.Einwohner'Last
            then
               AktuelleEinwohner := StadtDatentypen.Einwohner'Last;
               
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
                AktuelleArbeiter + 1 >= StadtDatentypen.Einwohner'Last
            then
               AktuelleArbeiter := StadtDatentypen.Einwohner'Last;
               
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
   
   
   
   procedure EinwohnerArbeiterLaden
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinwohnerArbeiterExtern : in StadtRecords.EinwohnerArbeiterArray)
   is begin
      
      GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).EinwohnerArbeiter := EinwohnerArbeiterExtern;
      
   end EinwohnerArbeiterLaden;
   
      
      
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
      WelcherPostenExtern : in ProduktionDatentypen.Permanente_Kosten_Vorhanden_Enum;
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
   
   
   
   procedure AlleKostenposten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      AlleKostenpostenExtern : in StadtRecords.PermanenteKostenArray)
   is begin
      
      GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).PermanenteKostenPosten := AlleKostenpostenExtern;
      
   end AlleKostenposten;
   
   
      
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
                                                        IDExtern    =>
                                                          StadtDatentypen.GebäudeIDVorhanden (GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Bauprojekt.Gebäude))
               - GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Material)
             / GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Produktionrate;
                  
      else
         GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Bauzeit
           := (LeseEinheitenDatenbank.Produktionskosten (SpeziesExtern => StadtSpeziesNummerExtern.Spezies,
                                                         IDExtern      => EinheitenDatentypen.EinheitenIDVorhanden (GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies,
                                                           StadtSpeziesNummerExtern.Nummer).Bauprojekt.Einheit))
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
      ZufriedenheitExtern : in ProduktionDatentypen.Zufriedenheit;
      ÄndernSetzenExtern : in Boolean)
   is
      use type ProduktionDatentypen.Zufriedenheit;
   begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Zufriedenheit + ZufriedenheitExtern >= ProduktionDatentypen.ZufriedenheitVorhanden'Last
            then
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Zufriedenheit := ProduktionDatentypen.ZufriedenheitVorhanden'Last;
               
            elsif
              GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Zufriedenheit + ZufriedenheitExtern <= StadtKonstanten.LeerZufriedenheit
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
      WelchesGebäudeExtern : in StadtDatentypen.GebäudeIDVorhanden;
      HinzufügenEntfernenExtern : in Boolean)
   is begin
      
      GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Gebäude (WelchesGebäudeExtern) := HinzufügenEntfernenExtern;
      
   end GebäudeVorhanden;
   
   
   
   procedure AlleGebäude
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      GebäudeExtern : in StadtArrays.GebäudeArray)
   is begin
      
      GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Gebäude := GebäudeExtern;
      
   end AlleGebäude;
   
   
   
   procedure Name
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      NameExtern : in Unbounded_Wide_Wide_String)
   is begin
      
      GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Name := NameExtern;
      
   end Name;
   
   
   
   procedure UmgebungBewirtschaftung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      YKoordinateExtern : in KartenDatentypen.SenkrechteUmgebungDrei;
      XKoordinateExtern : in KartenDatentypen.WaagerechteUmgebungDrei;
      BelegenEntfernenExtern : in Boolean)
   is begin
      
      GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).UmgebungBewirtschaftung (YKoordinateExtern, XKoordinateExtern) := BelegenEntfernenExtern;
      
   end UmgebungBewirtschaftung;
   
   
   
   procedure GesamteBewirtschaftung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      BewirtschaftungExtern : in StadtRecords.UmgebungBewirtschaftungArray)
   is begin
      
      GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).UmgebungBewirtschaftung := BewirtschaftungExtern;
      
   end GesamteBewirtschaftung;
   
   
   
   procedure Gesamtumgebung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      UmgebungGrößeExtern : in KartenRecords.UmgebungDreiRecord;
      ÄndernSetzenExtern : in Boolean)
   is begin
      
      Umgebungssenkrechte (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                           UmgebungExtern           => UmgebungGrößeExtern.Senkrechte,
                           ÄndernSetzenExtern       => ÄndernSetzenExtern);
      
      Umgebungswaagerechte (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                            UmgebungExtern           => UmgebungGrößeExtern.Waagerechte,
                            ÄndernSetzenExtern       => ÄndernSetzenExtern);
      
   end Gesamtumgebung;
   
   
   
   procedure Umgebungssenkrechte
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      UmgebungExtern : in KartenDatentypen.SenkrechteUmgebungDrei;
      ÄndernSetzenExtern : in Boolean)
   is begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).UmgebungGröße.Senkrechte + UmgebungExtern >= KartenDatentypen.SenkrechteUmgebungDrei'Last
            then
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).UmgebungGröße.Senkrechte := KartenDatentypen.SenkrechteUmgebungDrei'Last;
               
            elsif
              GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).UmgebungGröße.Senkrechte + UmgebungExtern <= StadtKonstanten.LeerUmgebungGröße.Senkrechte
            then
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).UmgebungGröße.Senkrechte := StadtKonstanten.LeerUmgebungGröße.Senkrechte;
               
            else
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).UmgebungGröße.Senkrechte
                 := GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).UmgebungGröße.Senkrechte + UmgebungExtern;
            end if;
            
         when False =>
            GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).UmgebungGröße.Senkrechte := UmgebungExtern;
      end case;
      
   end Umgebungssenkrechte;
     
   
   
   procedure Umgebungswaagerechte
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      UmgebungExtern : in KartenDatentypen.WaagerechteUmgebungDrei;
      ÄndernSetzenExtern : in Boolean)
   is begin
      
      case
        ÄndernSetzenExtern
      is
         when True =>
            if
              GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).UmgebungGröße.Waagerechte + UmgebungExtern >= KartenDatentypen.WaagerechteUmgebungDrei'Last
            then
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).UmgebungGröße.Waagerechte := KartenDatentypen.WaagerechteUmgebungDrei'Last;
               
            elsif
              GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).UmgebungGröße.Waagerechte + UmgebungExtern <= StadtKonstanten.LeerUmgebungGröße.Waagerechte
            then
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).UmgebungGröße.Waagerechte := StadtKonstanten.LeerUmgebungGröße.Waagerechte;
               
            else
               GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).UmgebungGröße.Waagerechte
                 := GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).UmgebungGröße.Waagerechte + UmgebungExtern;
            end if;
            
         when False =>
            GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).UmgebungGröße.Waagerechte := UmgebungExtern;
      end case;
      
   end Umgebungswaagerechte;
      
   
      
   procedure Meldungen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      WelcheMeldungExtern : in StadtDatentypen.Stadt_Meldung_Art_Enum;
      MeldungExtern : in StadtDatentypen.Stadt_Meldung_Enum)
   is begin
      
      GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Meldungen (WelcheMeldungExtern) := MeldungExtern;
      
   end Meldungen;
      
   
      
   procedure AlleMeldungen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      MeldungenExtern : in StadtRecords.StadtMeldungenArray)
   is begin
      
      GebautVariablen.StadtGebaut (StadtSpeziesNummerExtern.Spezies, StadtSpeziesNummerExtern.Nummer).Meldungen := MeldungenExtern;
      
   end AlleMeldungen;
      
   
      
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
        Stadtkoordinaten.Ebene
      is
         when KartenKonstanten.LeerEbene =>
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
