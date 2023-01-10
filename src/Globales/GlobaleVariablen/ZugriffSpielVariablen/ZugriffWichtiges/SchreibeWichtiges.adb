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
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      GeldZugewinnExtern : in ZahlenDatentypen.EigenerInteger;
      RechnenSetzenExtern : in Boolean)
   is begin
         
      case
        RechnenSetzenExtern
      is
         when True =>
            if
              SpielVariablen.Wichtiges (SpeziesExtern).Geldmenge + GeldZugewinnExtern >= LeseGrenzen.Geldgrenze (SpeziesExtern => SpeziesExtern)
            then
               SpielVariablen.Wichtiges (SpeziesExtern).Geldmenge := LeseGrenzen.Geldgrenze (SpeziesExtern => SpeziesExtern);
            
            elsif
              SpielVariablen.Wichtiges (SpeziesExtern).Geldmenge + GeldZugewinnExtern <= ZahlenDatentypen.EigenerInteger'First
            then
               SpielVariablen.Wichtiges (SpeziesExtern).Geldmenge := ZahlenDatentypen.EigenerInteger'First;
            
            else
               SpielVariablen.Wichtiges (SpeziesExtern).Geldmenge := SpielVariablen.Wichtiges (SpeziesExtern).Geldmenge + GeldZugewinnExtern;
            end if;
            
         when False =>
            SpielVariablen.Wichtiges (SpeziesExtern).Geldmenge := GeldZugewinnExtern;
      end case;
      
   end Geldmenge;
   
   
   
   procedure GeldZugewinnProRunde
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
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
              SpielVariablen.Wichtiges (SpeziesExtern).GeldZugewinnProRunde + GeldZugewinnExtern >= LeseGrenzen.Geldgewinngrenze (SpeziesExtern => SpeziesExtern)
            then
               SpielVariablen.Wichtiges (SpeziesExtern).GeldZugewinnProRunde := LeseGrenzen.Geldgewinngrenze (SpeziesExtern => SpeziesExtern);
               
            elsif
              SpielVariablen.Wichtiges (SpeziesExtern).GeldZugewinnProRunde + GeldZugewinnExtern <= ProduktionDatentypen.Produktion'First
            then
               SpielVariablen.Wichtiges (SpeziesExtern).GeldZugewinnProRunde := ProduktionDatentypen.Produktion'First;
               
            else
               SpielVariablen.Wichtiges (SpeziesExtern).GeldZugewinnProRunde := SpielVariablen.Wichtiges (SpeziesExtern).GeldZugewinnProRunde + GeldZugewinnExtern;
            end if;
            
         when False =>
            SpielVariablen.Wichtiges (SpeziesExtern).GeldZugewinnProRunde := GeldZugewinnExtern;
      end case;
      
   end GeldZugewinnProRunde;
   
   
   
   procedure GesamteForschungsrate
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
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
              SpielVariablen.Wichtiges (SpeziesExtern).GesamteForschungsrate + ForschungsrateZugewinnExtern >= LeseGrenzen.Forschungsgewinngrenze (SpeziesExtern => SpeziesExtern)
            then
               SpielVariablen.Wichtiges (SpeziesExtern).GesamteForschungsrate := LeseGrenzen.Forschungsgewinngrenze (SpeziesExtern => SpeziesExtern);
               
            elsif
              SpielVariablen.Wichtiges (SpeziesExtern).GesamteForschungsrate + ForschungsrateZugewinnExtern <= WichtigesKonstanten.LeerGesamteForschungsrate
            then
               SpielVariablen.Wichtiges (SpeziesExtern).GesamteForschungsrate := WichtigesKonstanten.LeerGesamteForschungsrate;
               
            else
               SpielVariablen.Wichtiges (SpeziesExtern).GesamteForschungsrate := SpielVariablen.Wichtiges (SpeziesExtern).GesamteForschungsrate + ForschungsrateZugewinnExtern;
            end if;
            
         when False =>
            if
              ForschungsrateZugewinnExtern <= WichtigesKonstanten.LeerGesamteForschungsrate
            then
               SpielVariablen.Wichtiges (SpeziesExtern).GesamteForschungsrate := WichtigesKonstanten.LeerGesamteForschungsrate;
               
            else
               SpielVariablen.Wichtiges (SpeziesExtern).GesamteForschungsrate := ForschungsrateZugewinnExtern;
            end if;
      end case;
      
      VerbleibendeForschungszeit (SpeziesExtern => SpeziesExtern);
      
   end GesamteForschungsrate;
   
   
   
   procedure Forschungsmenge
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
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
              SpielVariablen.Wichtiges (SpeziesExtern).Forschungsmenge + ForschungZugewinnExtern >= LeseGrenzen.Forschungsgrenze (SpeziesExtern => SpeziesExtern)
            then
               SpielVariablen.Wichtiges (SpeziesExtern).Forschungsmenge := LeseGrenzen.Forschungsgrenze (SpeziesExtern => SpeziesExtern);
               
            elsif
              SpielVariablen.Wichtiges (SpeziesExtern).Forschungsmenge + ForschungZugewinnExtern <= WichtigesKonstanten.LeerForschungsmenge
            then
               SpielVariablen.Wichtiges (SpeziesExtern).Forschungsmenge := WichtigesKonstanten.LeerForschungsmenge;
            
            else
               SpielVariablen.Wichtiges (SpeziesExtern).Forschungsmenge := SpielVariablen.Wichtiges (SpeziesExtern).Forschungsmenge + ForschungZugewinnExtern;
            end if;
            
         when False =>
            if
              ForschungZugewinnExtern <= WichtigesKonstanten.LeerForschungsmenge
            then
               SpielVariablen.Wichtiges (SpeziesExtern).Forschungsmenge := WichtigesKonstanten.LeerForschungsmenge;
               
            else
               SpielVariablen.Wichtiges (SpeziesExtern).Forschungsmenge := ForschungZugewinnExtern;
            end if;
      end case;
      
      VerbleibendeForschungszeit (SpeziesExtern => SpeziesExtern);
      
   end Forschungsmenge;
   
   
   
   procedure VerbleibendeForschungszeit
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is
      use type ProduktionDatentypen.Produktion;
      use type ForschungenDatentypen.ForschungIDNichtMöglich;
   begin
      
      if
        SpielVariablen.Wichtiges (SpeziesExtern).Forschungsprojekt = ForschungenDatentypen.ForschungIDMitNullWert'First
        or
          SpielVariablen.Wichtiges (SpeziesExtern).GesamteForschungsrate = ProduktionKonstanten.LeerProduktion
      then
         SpielVariablen.Wichtiges (SpeziesExtern).VerbleibendeForschungszeit := ProduktionDatentypen.Lagermenge'Last;
         
      elsif
        LeseForschungenDatenbank.Kosten (SpeziesExtern => SpeziesExtern,
                                         IDExtern    => SpielVariablen.Wichtiges (SpeziesExtern).Forschungsprojekt)
          - SpielVariablen.Wichtiges (SpeziesExtern).Forschungsmenge
        <= ForschungKonstanten.LeerKosten
      then
         SpielVariablen.Wichtiges (SpeziesExtern).VerbleibendeForschungszeit := 1;
        
      else
         SpielVariablen.Wichtiges (SpeziesExtern).VerbleibendeForschungszeit
           := (LeseForschungenDatenbank.Kosten (SpeziesExtern => SpeziesExtern,
                                                IDExtern    => SpielVariablen.Wichtiges (SpeziesExtern).Forschungsprojekt)
               - SpielVariablen.Wichtiges (SpeziesExtern).Forschungsmenge) / SpielVariablen.Wichtiges (SpeziesExtern).GesamteForschungsrate;
      end if;
      
   end VerbleibendeForschungszeit;
   
   
   
   procedure Forschungsprojekt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      ForschungIDExtern : in ForschungenDatentypen.ForschungIDMitNullWert)
   is begin
      
      SpielVariablen.Wichtiges (SpeziesExtern).Forschungsprojekt := ForschungIDExtern;
      
      Forschungsmenge (SpeziesExtern             => SpeziesExtern,
                       ForschungZugewinnExtern => WichtigesKonstanten.LeerForschungsmenge,
                       RechnenSetzenExtern     => False);
      
   end Forschungsprojekt;
   
   

   procedure Erforscht
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      case
        SpielVariablen.Wichtiges (SpeziesExtern).Forschungsprojekt
      is
         when ForschungKonstanten.LeerForschung =>
            null;
            
         when others =>
            SpielVariablen.Wichtiges (SpeziesExtern).Erforscht (SpielVariablen.Wichtiges (SpeziesExtern).Forschungsprojekt) := True;
      end case;
      
   end Erforscht;
   
   
   
   procedure ErforschtDebug
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      SpielVariablen.Wichtiges (SpeziesExtern).Erforscht := (others => True);
      
   end ErforschtDebug;
   
   
   
   procedure AnzahlStädte
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      PlusMinusExtern : in Boolean)
   is
      use type StadtDatentypen.MaximaleStädteMitNullWert;
   begin
      
      case
        PlusMinusExtern
      is
         when True =>
            if
              SpielVariablen.Wichtiges (SpeziesExtern).AnzahlStädte > LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern)
            then
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibeWichtiges.AnzahlStädte > Städtegrenze");
               
            else
               SpielVariablen.Wichtiges (SpeziesExtern).AnzahlStädte := SpielVariablen.Wichtiges (SpeziesExtern).AnzahlStädte + 1;
            end if;
            
         when False =>
            if
              SpielVariablen.Wichtiges (SpeziesExtern).AnzahlStädte = StadtDatentypen.MaximaleStädteMitNullWert'First
            then
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibeWichtiges.AnzahlStädte < 0");
               
            else
               SpielVariablen.Wichtiges (SpeziesExtern).AnzahlStädte := SpielVariablen.Wichtiges (SpeziesExtern).AnzahlStädte - 1;
            end if;
      end case;
      
   end AnzahlStädte;
   
   
     
   procedure AnzahlArbeiter
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      PlusMinusExtern : in Boolean)
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      case
        PlusMinusExtern
      is
         when True =>
            if
              SpielVariablen.Wichtiges (SpeziesExtern).AnzahlArbeiter + SpielVariablen.Wichtiges (SpeziesExtern).AnzahlKämpfer + SpielVariablen.Wichtiges (SpeziesExtern).AnzahlSonstiges
              > LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern)
            then
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibeWichtiges.AnzahlArbeiter > Einheitengrenze");
               
            else
               SpielVariablen.Wichtiges (SpeziesExtern).AnzahlArbeiter := SpielVariablen.Wichtiges (SpeziesExtern).AnzahlArbeiter + 1;
            end if;
            
         when False =>
            if
              SpielVariablen.Wichtiges (SpeziesExtern).AnzahlArbeiter = EinheitenDatentypen.MaximaleEinheitenMitNullWert'First
            then
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibeWichtiges.AnzahlArbeiter < 0");
               
            else
               SpielVariablen.Wichtiges (SpeziesExtern).AnzahlArbeiter := SpielVariablen.Wichtiges (SpeziesExtern).AnzahlArbeiter - 1;
            end if;
      end case;
            
   end AnzahlArbeiter;
   
   
     
   procedure AnzahlKämpfer
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      PlusMinusExtern : in Boolean)
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      case
        PlusMinusExtern
      is
         when True =>
            if
              SpielVariablen.Wichtiges (SpeziesExtern).AnzahlArbeiter + SpielVariablen.Wichtiges (SpeziesExtern).AnzahlKämpfer + SpielVariablen.Wichtiges (SpeziesExtern).AnzahlSonstiges
              > LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern)
            then
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibeWichtiges.AnzahlKämpfer > Einheitengrenze");
               
            else
               SpielVariablen.Wichtiges (SpeziesExtern).AnzahlKämpfer := SpielVariablen.Wichtiges (SpeziesExtern).AnzahlKämpfer + 1;
            end if;
            
         when False =>
            if
              SpielVariablen.Wichtiges (SpeziesExtern).AnzahlKämpfer = EinheitenDatentypen.MaximaleEinheitenMitNullWert'First
            then
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibeWichtiges.AnzahlKämpfer < 0");
               
            else
               SpielVariablen.Wichtiges (SpeziesExtern).AnzahlKämpfer := SpielVariablen.Wichtiges (SpeziesExtern).AnzahlKämpfer - 1;
            end if;
      end case;
      
   end AnzahlKämpfer;
   
   
     
   procedure AnzahlSonstiges
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      PlusMinusExtern : in Boolean)
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      case
        PlusMinusExtern
      is
         when True =>
            if
              SpielVariablen.Wichtiges (SpeziesExtern).AnzahlArbeiter + SpielVariablen.Wichtiges (SpeziesExtern).AnzahlKämpfer + SpielVariablen.Wichtiges (SpeziesExtern).AnzahlSonstiges
              > LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern)
            then
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibeWichtiges.AnzahlSonstiges > Einheitengrenze");
               
            else
               SpielVariablen.Wichtiges (SpeziesExtern).AnzahlSonstiges := SpielVariablen.Wichtiges (SpeziesExtern).AnzahlSonstiges + 1;
            end if;
            
         when False =>
            if
              SpielVariablen.Wichtiges (SpeziesExtern).AnzahlSonstiges = EinheitenDatentypen.MaximaleEinheitenMitNullWert'First
            then
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibeWichtiges.AnzahlSonstiges < 0");
               
            else
               SpielVariablen.Wichtiges (SpeziesExtern).AnzahlSonstiges := SpielVariablen.Wichtiges (SpeziesExtern).AnzahlSonstiges - 1;
            end if;
      end case;
      
   end AnzahlSonstiges;
   
   
   
   procedure Standardeinstellungen
   is begin
      
      SpielVariablen.Wichtiges := (others => WichtigesRecordKonstanten.LeerWichtigesZeug);
      
   end Standardeinstellungen;
   
   
   
   procedure LeerEintrag
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      SpielVariablen.Wichtiges (SpeziesExtern) := WichtigesRecordKonstanten.LeerWichtigesZeug;
      
   end LeerEintrag;
   
   
   
   procedure GanzerEintrag
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      EintragExtern : in SpielRecords.WichtigesRecord)
   is begin
      
      SpielVariablen.Wichtiges (SpeziesExtern) := EintragExtern;
      
   end GanzerEintrag;
   
end SchreibeWichtiges;
