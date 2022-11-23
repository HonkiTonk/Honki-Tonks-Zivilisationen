with EinheitenDatentypen;
with StadtDatentypen;
with WichtigesKonstanten;
with ForschungKonstanten;
with ProduktionKonstanten;
with WichtigesRecordKonstanten;
with SpielVariablen;

with LeseForschungenDatenbank;
with LeseGrenzen;

with Fehlermeldungssystem;

package body SchreibeWichtiges is

   -- Warum kann die vorhandene Geldmenge überhaupt kleiner als 0 sein? Das mal ändern? äöü
   procedure Geldmenge
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      GeldZugewinnExtern : in ZahlenDatentypen.EigenerInteger;
      RechnenSetzenExtern : in Boolean)
   is begin
         
      case
        RechnenSetzenExtern
      is
         when True =>
            if
              SpielVariablen.Wichtiges (RasseExtern).Geldmenge + GeldZugewinnExtern >= LeseGrenzen.Geldgrenze (RasseExtern => RasseExtern)
            then
               SpielVariablen.Wichtiges (RasseExtern).Geldmenge := LeseGrenzen.Geldgrenze (RasseExtern => RasseExtern);
            
            elsif
              SpielVariablen.Wichtiges (RasseExtern).Geldmenge + GeldZugewinnExtern <= ZahlenDatentypen.EigenerInteger'First
            then
               SpielVariablen.Wichtiges (RasseExtern).Geldmenge := ZahlenDatentypen.EigenerInteger'First;
            
            else
               SpielVariablen.Wichtiges (RasseExtern).Geldmenge := SpielVariablen.Wichtiges (RasseExtern).Geldmenge + GeldZugewinnExtern;
            end if;
            
         when False =>
            SpielVariablen.Wichtiges (RasseExtern).Geldmenge := GeldZugewinnExtern;
      end case;
      
   end Geldmenge;
   
   
   
   procedure GeldZugewinnProRunde
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      GeldZugewinnExtern : in ProduktionDatentypen.Stadtproduktion;
      RechnenSetzenExtern : in Boolean)
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      case
        RechnenSetzenExtern
      is
         when True =>
            if
              SpielVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde + GeldZugewinnExtern >= LeseGrenzen.Geldgewinngrenze (RasseExtern => RasseExtern)
            then
               SpielVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde := LeseGrenzen.Geldgewinngrenze (RasseExtern => RasseExtern);
               
            elsif
              SpielVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde + GeldZugewinnExtern <= ProduktionDatentypen.Produktion'First
            then
               SpielVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde := ProduktionDatentypen.Produktion'First;
               
            else
               SpielVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde := SpielVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde + GeldZugewinnExtern;
            end if;
            
         when False =>
            SpielVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde := GeldZugewinnExtern;
      end case;
      
   end GeldZugewinnProRunde;
   
   
   
   procedure GesamteForschungsrate
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ForschungsrateZugewinnExtern : in ProduktionDatentypen.Stadtproduktion;
      RechnenSetzenExtern : in Boolean)
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      case
        RechnenSetzenExtern
      is
         when True =>
            if
              SpielVariablen.Wichtiges (RasseExtern).GesamteForschungsrate + ForschungsrateZugewinnExtern >= LeseGrenzen.Forschungsgewinngrenze (RasseExtern => RasseExtern)
            then
               SpielVariablen.Wichtiges (RasseExtern).GesamteForschungsrate := LeseGrenzen.Forschungsgewinngrenze (RasseExtern => RasseExtern);
               
            elsif
              SpielVariablen.Wichtiges (RasseExtern).GesamteForschungsrate + ForschungsrateZugewinnExtern <= WichtigesKonstanten.LeerGesamteForschungsrate
            then
               SpielVariablen.Wichtiges (RasseExtern).GesamteForschungsrate := WichtigesKonstanten.LeerGesamteForschungsrate;
               
            else
               SpielVariablen.Wichtiges (RasseExtern).GesamteForschungsrate := SpielVariablen.Wichtiges (RasseExtern).GesamteForschungsrate + ForschungsrateZugewinnExtern;
            end if;
            
         when False =>
            if
              ForschungsrateZugewinnExtern <= WichtigesKonstanten.LeerGesamteForschungsrate
            then
               SpielVariablen.Wichtiges (RasseExtern).GesamteForschungsrate := WichtigesKonstanten.LeerGesamteForschungsrate;
               
            else
               SpielVariablen.Wichtiges (RasseExtern).GesamteForschungsrate := ForschungsrateZugewinnExtern;
            end if;
      end case;
      
      VerbleibendeForschungszeit (RasseExtern => RasseExtern);
      
   end GesamteForschungsrate;
   
   
   
   procedure Forschungsmenge
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ForschungZugewinnExtern : in ProduktionDatentypen.Produktion;
      RechnenSetzenExtern : in Boolean)
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      case
        RechnenSetzenExtern
      is
         when True =>
            if
              SpielVariablen.Wichtiges (RasseExtern).Forschungsmenge + ForschungZugewinnExtern >= LeseGrenzen.Forschungsgrenze (RasseExtern => RasseExtern)
            then
               SpielVariablen.Wichtiges (RasseExtern).Forschungsmenge := LeseGrenzen.Forschungsgrenze (RasseExtern => RasseExtern);
               
            elsif
              SpielVariablen.Wichtiges (RasseExtern).Forschungsmenge + ForschungZugewinnExtern <= WichtigesKonstanten.LeerForschungsmenge
            then
               SpielVariablen.Wichtiges (RasseExtern).Forschungsmenge := WichtigesKonstanten.LeerForschungsmenge;
            
            else
               SpielVariablen.Wichtiges (RasseExtern).Forschungsmenge := SpielVariablen.Wichtiges (RasseExtern).Forschungsmenge + ForschungZugewinnExtern;
            end if;
            
         when False =>
            if
              ForschungZugewinnExtern <= WichtigesKonstanten.LeerForschungsmenge
            then
               SpielVariablen.Wichtiges (RasseExtern).Forschungsmenge := WichtigesKonstanten.LeerForschungsmenge;
               
            else
               SpielVariablen.Wichtiges (RasseExtern).Forschungsmenge := ForschungZugewinnExtern;
            end if;
      end case;
      
      VerbleibendeForschungszeit (RasseExtern => RasseExtern);
      
   end Forschungsmenge;
   
   
   
   procedure VerbleibendeForschungszeit
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is
      use type ProduktionDatentypen.Produktion;
      use type ForschungenDatentypen.ForschungIDNichtMöglich;
   begin
      
      if
        SpielVariablen.Wichtiges (RasseExtern).Forschungsprojekt = ForschungenDatentypen.ForschungIDMitNullWert'First
        or
          SpielVariablen.Wichtiges (RasseExtern).GesamteForschungsrate = ProduktionKonstanten.LeerProduktion
      then
         SpielVariablen.Wichtiges (RasseExtern).VerbleibendeForschungszeit := ProduktionDatentypen.Lagermenge'Last;
         
      elsif
        LeseForschungenDatenbank.Kosten (RasseExtern => RasseExtern,
                                         IDExtern    => SpielVariablen.Wichtiges (RasseExtern).Forschungsprojekt)
          - SpielVariablen.Wichtiges (RasseExtern).Forschungsmenge
        <= ForschungKonstanten.LeerKosten
      then
         SpielVariablen.Wichtiges (RasseExtern).VerbleibendeForschungszeit := 1;
        
      else
         SpielVariablen.Wichtiges (RasseExtern).VerbleibendeForschungszeit
           := (LeseForschungenDatenbank.Kosten (RasseExtern => RasseExtern,
                                                IDExtern    => SpielVariablen.Wichtiges (RasseExtern).Forschungsprojekt)
               - SpielVariablen.Wichtiges (RasseExtern).Forschungsmenge) / SpielVariablen.Wichtiges (RasseExtern).GesamteForschungsrate;
      end if;
      
   end VerbleibendeForschungszeit;
   
   
   
   procedure Forschungsprojekt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ForschungIDExtern : in ForschungenDatentypen.ForschungIDMitNullWert)
   is begin
      
      SpielVariablen.Wichtiges (RasseExtern).Forschungsprojekt := ForschungIDExtern;
      
      Forschungsmenge (RasseExtern             => RasseExtern,
                       ForschungZugewinnExtern => WichtigesKonstanten.LeerForschungsmenge,
                       RechnenSetzenExtern     => False);
      
   end Forschungsprojekt;
   
   

   procedure Erforscht
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        SpielVariablen.Wichtiges (RasseExtern).Forschungsprojekt
      is
         when ForschungKonstanten.LeerForschung =>
            null;
            
         when others =>
            SpielVariablen.Wichtiges (RasseExtern).Erforscht (SpielVariablen.Wichtiges (RasseExtern).Forschungsprojekt) := True;
      end case;
      
   end Erforscht;
   
   
   
   procedure ErforschtDebug
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      SpielVariablen.Wichtiges (RasseExtern).Erforscht := (others => True);
      
   end ErforschtDebug;
   
   
   
   procedure AnzahlStädte
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      PlusMinusExtern : in Boolean)
   is
      use type StadtDatentypen.MaximaleStädteMitNullWert;
   begin
      
      case
        PlusMinusExtern
      is
         when True =>
            if
              SpielVariablen.Wichtiges (RasseExtern).AnzahlStädte > LeseGrenzen.Städtegrenzen (RasseExtern => RasseExtern)
            then
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibeWichtiges.AnzahlStädte > Städtegrenze");
               
            else
               SpielVariablen.Wichtiges (RasseExtern).AnzahlStädte := SpielVariablen.Wichtiges (RasseExtern).AnzahlStädte + 1;
            end if;
            
         when False =>
            if
              SpielVariablen.Wichtiges (RasseExtern).AnzahlStädte = StadtDatentypen.MaximaleStädteMitNullWert'First
            then
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibeWichtiges.AnzahlStädte < 0");
               
            else
               SpielVariablen.Wichtiges (RasseExtern).AnzahlStädte := SpielVariablen.Wichtiges (RasseExtern).AnzahlStädte - 1;
            end if;
      end case;
      
   end AnzahlStädte;
   
   
     
   procedure AnzahlArbeiter
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      PlusMinusExtern : in Boolean)
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      case
        PlusMinusExtern
      is
         when True =>
            if
              SpielVariablen.Wichtiges (RasseExtern).AnzahlArbeiter + SpielVariablen.Wichtiges (RasseExtern).AnzahlKämpfer + SpielVariablen.Wichtiges (RasseExtern).AnzahlSonstiges
              > LeseGrenzen.Einheitengrenze (RasseExtern => RasseExtern)
            then
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibeWichtiges.AnzahlArbeiter > Einheitengrenze");
               
            else
               SpielVariablen.Wichtiges (RasseExtern).AnzahlArbeiter := SpielVariablen.Wichtiges (RasseExtern).AnzahlArbeiter + 1;
            end if;
            
         when False =>
            if
              SpielVariablen.Wichtiges (RasseExtern).AnzahlArbeiter = EinheitenDatentypen.MaximaleEinheitenMitNullWert'First
            then
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibeWichtiges.AnzahlArbeiter < 0");
               
            else
               SpielVariablen.Wichtiges (RasseExtern).AnzahlArbeiter := SpielVariablen.Wichtiges (RasseExtern).AnzahlArbeiter - 1;
            end if;
      end case;
            
   end AnzahlArbeiter;
   
   
     
   procedure AnzahlKämpfer
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      PlusMinusExtern : in Boolean)
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      case
        PlusMinusExtern
      is
         when True =>
            if
              SpielVariablen.Wichtiges (RasseExtern).AnzahlArbeiter + SpielVariablen.Wichtiges (RasseExtern).AnzahlKämpfer + SpielVariablen.Wichtiges (RasseExtern).AnzahlSonstiges
              > LeseGrenzen.Einheitengrenze (RasseExtern => RasseExtern)
            then
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibeWichtiges.AnzahlKämpfer > Einheitengrenze");
               
            else
               SpielVariablen.Wichtiges (RasseExtern).AnzahlKämpfer := SpielVariablen.Wichtiges (RasseExtern).AnzahlKämpfer + 1;
            end if;
            
         when False =>
            if
              SpielVariablen.Wichtiges (RasseExtern).AnzahlKämpfer = EinheitenDatentypen.MaximaleEinheitenMitNullWert'First
            then
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibeWichtiges.AnzahlKämpfer < 0");
               
            else
               SpielVariablen.Wichtiges (RasseExtern).AnzahlKämpfer := SpielVariablen.Wichtiges (RasseExtern).AnzahlKämpfer - 1;
            end if;
      end case;
      
   end AnzahlKämpfer;
   
   
     
   procedure AnzahlSonstiges
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      PlusMinusExtern : in Boolean)
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      case
        PlusMinusExtern
      is
         when True =>
            if
              SpielVariablen.Wichtiges (RasseExtern).AnzahlArbeiter + SpielVariablen.Wichtiges (RasseExtern).AnzahlKämpfer + SpielVariablen.Wichtiges (RasseExtern).AnzahlSonstiges
              > LeseGrenzen.Einheitengrenze (RasseExtern => RasseExtern)
            then
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibeWichtiges.AnzahlSonstiges > Einheitengrenze");
               
            else
               SpielVariablen.Wichtiges (RasseExtern).AnzahlSonstiges := SpielVariablen.Wichtiges (RasseExtern).AnzahlSonstiges + 1;
            end if;
            
         when False =>
            if
              SpielVariablen.Wichtiges (RasseExtern).AnzahlSonstiges = EinheitenDatentypen.MaximaleEinheitenMitNullWert'First
            then
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibeWichtiges.AnzahlSonstiges < 0");
               
            else
               SpielVariablen.Wichtiges (RasseExtern).AnzahlSonstiges := SpielVariablen.Wichtiges (RasseExtern).AnzahlSonstiges - 1;
            end if;
      end case;
      
   end AnzahlSonstiges;
   
   
   
   procedure Standardeinstellungen
   is begin
      
      SpielVariablen.Wichtiges := (others => WichtigesRecordKonstanten.LeerWichtigesZeug);
      
   end Standardeinstellungen;
   
   
   
   procedure LeerEintrag
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      SpielVariablen.Wichtiges (RasseExtern) := WichtigesRecordKonstanten.LeerWichtigesZeug;
      
   end LeerEintrag;
   
   
   
   procedure GanzerEintrag
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      EintragExtern : in SpielRecords.WichtigesRecord)
   is begin
      
      SpielVariablen.Wichtiges (RasseExtern) := EintragExtern;
      
   end GanzerEintrag;
   
end SchreibeWichtiges;
