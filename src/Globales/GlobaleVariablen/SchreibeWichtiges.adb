pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ForschungenDatentypen; use ForschungenDatentypen;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
with WichtigesKonstanten;
with SpielVariablen;

with LeseForschungenDatenbank;

with Fehler;

package body SchreibeWichtiges is

   procedure Geldmenge
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      GeldZugewinnExtern : in Integer;
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
              SpielVariablen.Wichtiges (RasseExtern).Geldmenge + GeldZugewinnExtern < Integer'First
            then
               SpielVariablen.Wichtiges (RasseExtern).Geldmenge := Integer'First;
            
            else
               SpielVariablen.Wichtiges (RasseExtern).Geldmenge := SpielVariablen.Wichtiges (RasseExtern).Geldmenge + GeldZugewinnExtern;
            end if;
            
         when False =>
            SpielVariablen.Wichtiges (RasseExtern).Geldmenge := GeldZugewinnExtern;
      end case;
      
   end Geldmenge;
   
   
   
   procedure GeldZugewinnProRunde
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      GeldZugewinnExtern : in ProduktionDatentypen.GesamtproduktionStadt;
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
              SpielVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde + GeldZugewinnExtern < ProduktionDatentypen.KostenLager'First
            then
               SpielVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde := ProduktionDatentypen.KostenLager'First;
               
            else
               SpielVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde := SpielVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde + GeldZugewinnExtern;
            end if;
            
         when False =>
            SpielVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde := GeldZugewinnExtern;
      end case;
      
   end GeldZugewinnProRunde;
   
   
   
   procedure GesamteForschungsrate
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ForschungsrateZugewinnExtern : in ProduktionDatentypen.GesamtproduktionStadt;
      RechnenSetzenExtern : in Boolean)
   is begin
      
      case
        RechnenSetzenExtern
      is
         when True =>
            if
              SpielVariablen.Wichtiges (RasseExtern).GesamteForschungsrate + ForschungsrateZugewinnExtern > SpielVariablen.Grenzen (RasseExtern).ForschungGewinngrenze
            then
               SpielVariablen.Wichtiges (RasseExtern).GesamteForschungsrate := SpielVariablen.Grenzen (RasseExtern).ForschungGewinngrenze;
               
            elsif
              SpielVariablen.Wichtiges (RasseExtern).GesamteForschungsrate + ForschungsrateZugewinnExtern < WichtigesKonstanten.LeerWichtigesZeug.GesamteForschungsrate
            then
               SpielVariablen.Wichtiges (RasseExtern).GesamteForschungsrate := WichtigesKonstanten.LeerWichtigesZeug.GesamteForschungsrate;
               
            else
               SpielVariablen.Wichtiges (RasseExtern).GesamteForschungsrate := SpielVariablen.Wichtiges (RasseExtern).GesamteForschungsrate + ForschungsrateZugewinnExtern;
            end if;
            
         when False =>
            if
              ForschungsrateZugewinnExtern < WichtigesKonstanten.LeerWichtigesZeug.GesamteForschungsrate
            then
               SpielVariablen.Wichtiges (RasseExtern).GesamteForschungsrate := WichtigesKonstanten.LeerWichtigesZeug.GesamteForschungsrate;
               
            else
               SpielVariablen.Wichtiges (RasseExtern).GesamteForschungsrate := ForschungsrateZugewinnExtern;
            end if;
      end case;
      
      VerbleibendeForschungszeit (RasseExtern => RasseExtern);
      
   end GesamteForschungsrate;
   
   
   
   procedure Forschungsmenge
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ForschungZugewinnExtern : in ProduktionDatentypen.KostenLager;
      RechnenSetzenExtern : in Boolean)
   is begin
      
      case
        RechnenSetzenExtern
      is
         when True =>
            if
              SpielVariablen.Wichtiges (RasseExtern).Forschungsmenge + ForschungZugewinnExtern > SpielVariablen.Grenzen (RasseExtern).Forschungsgrenze
            then
               SpielVariablen.Wichtiges (RasseExtern).Forschungsmenge := SpielVariablen.Grenzen (RasseExtern).Forschungsgrenze;
               
            elsif
              SpielVariablen.Wichtiges (RasseExtern).Forschungsmenge + ForschungZugewinnExtern < WichtigesKonstanten.LeerWichtigesZeug.Forschungsmenge
            then
               SpielVariablen.Wichtiges (RasseExtern).Forschungsmenge := WichtigesKonstanten.LeerWichtigesZeug.Forschungsmenge;
            
            else
               SpielVariablen.Wichtiges (RasseExtern).Forschungsmenge := SpielVariablen.Wichtiges (RasseExtern).Forschungsmenge + ForschungZugewinnExtern;
            end if;
            
         when False =>
            if
              ForschungZugewinnExtern < WichtigesKonstanten.LeerWichtigesZeug.Forschungsmenge
            then
               SpielVariablen.Wichtiges (RasseExtern).Forschungsmenge := WichtigesKonstanten.LeerWichtigesZeug.Forschungsmenge;
               
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
         SpielVariablen.Wichtiges (RasseExtern).VerbleibendeForschungszeit := ProduktionDatentypen.KostenLager'Last;
         
      else
         SpielVariablen.Wichtiges (RasseExtern).VerbleibendeForschungszeit
           := (LeseForschungenDatenbank.PreisForschung (RasseExtern => RasseExtern,
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
                       ForschungZugewinnExtern => WichtigesKonstanten.LeerWichtigesZeug.Forschungsmenge,
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
              SpielVariablen.Wichtiges (RasseExtern).AnzahlStädte >= SpielVariablen.Grenzen (RasseExtern).Städtegrenze
            then
               Fehler.LogikFehler (FehlermeldungExtern => "SchreibeWichtiges.AnzahlStädte - >= SpielVariablen.Grenzen (RasseExtern).Städtegrenze");
               
            else
               SpielVariablen.Wichtiges (RasseExtern).AnzahlStädte := SpielVariablen.Wichtiges (RasseExtern).AnzahlStädte + 1;
            end if;
            
         when False =>
            if
              SpielVariablen.Wichtiges (RasseExtern).AnzahlStädte = EinheitStadtDatentypen.MaximaleStädteMitNullWert'First
            then
               Fehler.LogikFehler (FehlermeldungExtern => "SchreibeWichtiges.AnzahlStädte - = EinheitStadtDatentypen.MaximaleStädteMitNullWert'First");
               
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
              >= SpielVariablen.Grenzen (RasseExtern).Einheitengrenze
            then
               Fehler.LogikFehler (FehlermeldungExtern => "SchreibeWichtiges.AnzahlArbeiter - >= SpielVariablen.Grenzen (RasseExtern).Einheitengrenze");
               
            else
               SpielVariablen.Wichtiges (RasseExtern).AnzahlArbeiter := SpielVariablen.Wichtiges (RasseExtern).AnzahlArbeiter + 1;
            end if;
            
         when False =>
            if
              SpielVariablen.Wichtiges (RasseExtern).AnzahlArbeiter = EinheitStadtDatentypen.MaximaleEinheitenMitNullWert'First
            then
               Fehler.LogikFehler (FehlermeldungExtern => "SchreibeWichtiges.AnzahlArbeiter - = EinheitStadtDatentypen.MaximaleEinheitenMitNullWert'First");
               
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
              >= SpielVariablen.Grenzen (RasseExtern).Einheitengrenze
            then
               Fehler.LogikFehler (FehlermeldungExtern => "SchreibeWichtiges.AnzahlKämpfer - >= SpielVariablen.Grenzen (RasseExtern).Einheitengrenze");
               
            else
               SpielVariablen.Wichtiges (RasseExtern).AnzahlKämpfer := SpielVariablen.Wichtiges (RasseExtern).AnzahlKämpfer + 1;
            end if;
            
         when False =>
            if
              SpielVariablen.Wichtiges (RasseExtern).AnzahlKämpfer = EinheitStadtDatentypen.MaximaleEinheitenMitNullWert'First
            then
               Fehler.LogikFehler (FehlermeldungExtern => "SchreibeWichtiges.AnzahlKämpfer - = EinheitStadtDatentypen.MaximaleEinheitenMitNullWert'First");
               
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
              = SpielVariablen.Grenzen (RasseExtern).Einheitengrenze
            then
               Fehler.LogikFehler (FehlermeldungExtern => "SchreibeWichtiges.AnzahlSonstiges - = SpielVariablen.Grenzen (RasseExtern).Einheitengrenze");
               
            else
               SpielVariablen.Wichtiges (RasseExtern).AnzahlSonstiges := SpielVariablen.Wichtiges (RasseExtern).AnzahlSonstiges + 1;
            end if;
            
         when False =>
            if
              SpielVariablen.Wichtiges (RasseExtern).AnzahlSonstiges = EinheitStadtDatentypen.MaximaleEinheitenMitNullWert'First
            then
               Fehler.LogikFehler (FehlermeldungExtern => "SchreibeWichtiges.AnzahlSonstiges - = EinheitStadtDatentypen.MaximaleEinheitenMitNullWert'First");
               
            else
               SpielVariablen.Wichtiges (RasseExtern).AnzahlSonstiges := SpielVariablen.Wichtiges (RasseExtern).AnzahlSonstiges - 1;
            end if;
      end case;
      
   end AnzahlSonstiges;
      
end SchreibeWichtiges;
