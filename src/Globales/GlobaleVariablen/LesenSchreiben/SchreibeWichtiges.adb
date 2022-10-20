pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ForschungenDatentypen; use ForschungenDatentypen;
with EinheitenDatentypen; use EinheitenDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
with StadtDatentypen; use StadtDatentypen;
with WichtigesKonstanten;
with ForschungKonstanten;

with LeseForschungenDatenbank;

with Fehler;

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
              SpielVariablen.Wichtiges (RasseExtern).Geldmenge + GeldZugewinnExtern > SpielVariablen.Grenzen (RasseExtern).Geldgrenze
            then
               SpielVariablen.Wichtiges (RasseExtern).Geldmenge := SpielVariablen.Grenzen (RasseExtern).Geldgrenze;
            
            elsif
              SpielVariablen.Wichtiges (RasseExtern).Geldmenge + GeldZugewinnExtern < ZahlenDatentypen.EigenerInteger'First
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
   is begin
      
      case
        RechnenSetzenExtern
      is
         when True =>
            if
              SpielVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde + GeldZugewinnExtern > SpielVariablen.Grenzen (RasseExtern).Geldgewinngrenze
            then
               SpielVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde := SpielVariablen.Grenzen (RasseExtern).Geldgewinngrenze;
               
            elsif
              SpielVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde + GeldZugewinnExtern < ProduktionDatentypen.Produktion'First
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
   is begin
      
      case
        RechnenSetzenExtern
      is
         when True =>
            if
              SpielVariablen.Wichtiges (RasseExtern).GesamteForschungsrate + ForschungsrateZugewinnExtern >= SpielVariablen.Grenzen (RasseExtern).ForschungGewinngrenze
            then
               SpielVariablen.Wichtiges (RasseExtern).GesamteForschungsrate := SpielVariablen.Grenzen (RasseExtern).ForschungGewinngrenze;
               
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
   is begin
      
      case
        RechnenSetzenExtern
      is
         when True =>
            if
              SpielVariablen.Wichtiges (RasseExtern).Forschungsmenge + ForschungZugewinnExtern >= SpielVariablen.Grenzen (RasseExtern).Forschungsgrenze
            then
               SpielVariablen.Wichtiges (RasseExtern).Forschungsmenge := SpielVariablen.Grenzen (RasseExtern).Forschungsgrenze;
               
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
   is begin
      
      if
        SpielVariablen.Wichtiges (RasseExtern).Forschungsprojekt = ForschungenDatentypen.ForschungIDMitNullWert'First
        or
          SpielVariablen.Wichtiges (RasseExtern).GesamteForschungsrate = 0
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
               - SpielVariablen.Wichtiges (RasseExtern).Forschungsmenge)
             / SpielVariablen.Wichtiges (RasseExtern).GesamteForschungsrate;
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
         when 0 =>
            null;
            
         when others =>
            SpielVariablen.Wichtiges (RasseExtern).Erforscht (SpielVariablen.Wichtiges (RasseExtern).Forschungsprojekt) := True;
      end case;
      
   end Erforscht;
   
   
   
   procedure AnzahlStädte
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      PlusMinusExtern : in Boolean)
   is begin
      
      case
        PlusMinusExtern
      is
         when True =>
            if
              SpielVariablen.Wichtiges (RasseExtern).AnzahlStädte > SpielVariablen.Grenzen (RasseExtern).Städtegrenze
            then
               Fehler.LogikFehler (FehlermeldungExtern => "SchreibeWichtiges.AnzahlStädte > Städtegrenze");
               
            else
               SpielVariablen.Wichtiges (RasseExtern).AnzahlStädte := SpielVariablen.Wichtiges (RasseExtern).AnzahlStädte + 1;
            end if;
            
         when False =>
            if
              SpielVariablen.Wichtiges (RasseExtern).AnzahlStädte = StadtDatentypen.MaximaleStädteMitNullWert'First
            then
               Fehler.LogikFehler (FehlermeldungExtern => "SchreibeWichtiges.AnzahlStädte < 0");
               
            else
               SpielVariablen.Wichtiges (RasseExtern).AnzahlStädte := SpielVariablen.Wichtiges (RasseExtern).AnzahlStädte - 1;
            end if;
      end case;
      
   end AnzahlStädte;
   
   
     
   procedure AnzahlArbeiter
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      PlusMinusExtern : in Boolean)
   is begin
      
      case
        PlusMinusExtern
      is
         when True =>
            if
              SpielVariablen.Wichtiges (RasseExtern).AnzahlArbeiter + SpielVariablen.Wichtiges (RasseExtern).AnzahlKämpfer + SpielVariablen.Wichtiges (RasseExtern).AnzahlSonstiges
              > SpielVariablen.Grenzen (RasseExtern).Einheitengrenze
            then
               Fehler.LogikFehler (FehlermeldungExtern => "SchreibeWichtiges.AnzahlArbeiter > Einheitengrenze");
               
            else
               SpielVariablen.Wichtiges (RasseExtern).AnzahlArbeiter := SpielVariablen.Wichtiges (RasseExtern).AnzahlArbeiter + 1;
            end if;
            
         when False =>
            if
              SpielVariablen.Wichtiges (RasseExtern).AnzahlArbeiter = EinheitenDatentypen.MaximaleEinheitenMitNullWert'First
            then
               Fehler.LogikFehler (FehlermeldungExtern => "SchreibeWichtiges.AnzahlArbeiter < 0");
               
            else
               SpielVariablen.Wichtiges (RasseExtern).AnzahlArbeiter := SpielVariablen.Wichtiges (RasseExtern).AnzahlArbeiter - 1;
            end if;
      end case;
            
   end AnzahlArbeiter;
   
   
     
   procedure AnzahlKämpfer
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      PlusMinusExtern : in Boolean)
   is begin
      
      case
        PlusMinusExtern
      is
         when True =>
            if
              SpielVariablen.Wichtiges (RasseExtern).AnzahlArbeiter + SpielVariablen.Wichtiges (RasseExtern).AnzahlKämpfer + SpielVariablen.Wichtiges (RasseExtern).AnzahlSonstiges
              > SpielVariablen.Grenzen (RasseExtern).Einheitengrenze
            then
               Fehler.LogikFehler (FehlermeldungExtern => "SchreibeWichtiges.AnzahlKämpfer > Einheitengrenze");
               
            else
               SpielVariablen.Wichtiges (RasseExtern).AnzahlKämpfer := SpielVariablen.Wichtiges (RasseExtern).AnzahlKämpfer + 1;
            end if;
            
         when False =>
            if
              SpielVariablen.Wichtiges (RasseExtern).AnzahlKämpfer = EinheitenDatentypen.MaximaleEinheitenMitNullWert'First
            then
               Fehler.LogikFehler (FehlermeldungExtern => "SchreibeWichtiges.AnzahlKämpfer < 0");
               
            else
               SpielVariablen.Wichtiges (RasseExtern).AnzahlKämpfer := SpielVariablen.Wichtiges (RasseExtern).AnzahlKämpfer - 1;
            end if;
      end case;
      
   end AnzahlKämpfer;
   
   
     
   procedure AnzahlSonstiges
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      PlusMinusExtern : in Boolean)
   is begin
      
      case
        PlusMinusExtern
      is
         when True =>
            if
              SpielVariablen.Wichtiges (RasseExtern).AnzahlArbeiter + SpielVariablen.Wichtiges (RasseExtern).AnzahlKämpfer + SpielVariablen.Wichtiges (RasseExtern).AnzahlSonstiges
              > SpielVariablen.Grenzen (RasseExtern).Einheitengrenze
            then
               Fehler.LogikFehler (FehlermeldungExtern => "SchreibeWichtiges.AnzahlSonstiges > Einheitengrenze");
               
            else
               SpielVariablen.Wichtiges (RasseExtern).AnzahlSonstiges := SpielVariablen.Wichtiges (RasseExtern).AnzahlSonstiges + 1;
            end if;
            
         when False =>
            if
              SpielVariablen.Wichtiges (RasseExtern).AnzahlArbeiter = EinheitenDatentypen.MaximaleEinheitenMitNullWert'First
            then
               Fehler.LogikFehler (FehlermeldungExtern => "SchreibeWichtiges.AnzahlSonstiges < 0");
               
            else
               SpielVariablen.Wichtiges (RasseExtern).AnzahlSonstiges := SpielVariablen.Wichtiges (RasseExtern).AnzahlSonstiges - 1;
            end if;
      end case;
      
   end AnzahlSonstiges;
      
end SchreibeWichtiges;
