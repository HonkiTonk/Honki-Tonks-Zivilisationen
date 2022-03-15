pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with SonstigesKonstanten;

with LeseForschungsDatenbank;

with Fehler;

package body SchreibeWichtiges is

   procedure Geldmenge
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      GeldZugewinnExtern : in Integer;
      RechnenSetzenExtern : in Boolean)
   is begin
         
      case
        RechnenSetzenExtern
      is
         when True =>
            if
              GlobaleVariablen.Wichtiges (RasseExtern).Geldmenge + GeldZugewinnExtern > GlobaleVariablen.Grenzen (RasseExtern).Geldgrenze
            then
               GlobaleVariablen.Wichtiges (RasseExtern).Geldmenge := GlobaleVariablen.Grenzen (RasseExtern).Geldgrenze;
            
            elsif
              GlobaleVariablen.Wichtiges (RasseExtern).Geldmenge + GeldZugewinnExtern < Integer'First
            then
               GlobaleVariablen.Wichtiges (RasseExtern).Geldmenge := Integer'First;
            
            else
               GlobaleVariablen.Wichtiges (RasseExtern).Geldmenge := GlobaleVariablen.Wichtiges (RasseExtern).Geldmenge + GeldZugewinnExtern;
            end if;
            
         when False =>
            GlobaleVariablen.Wichtiges (RasseExtern).Geldmenge := GeldZugewinnExtern;
      end case;
      
   end Geldmenge;
   
   
   
   procedure GeldZugewinnProRunde
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      GeldZugewinnExtern : in EinheitStadtDatentypen.GesamtproduktionStadt;
      RechnenSetzenExtern : in Boolean)
   is begin
      
      case
        RechnenSetzenExtern
      is
         when True =>
            if
              GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde + GeldZugewinnExtern > GlobaleVariablen.Grenzen (RasseExtern).Geldgewinngrenze
            then
               GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde := GlobaleVariablen.Grenzen (RasseExtern).Geldgewinngrenze;
               
            elsif
              GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde + GeldZugewinnExtern < EinheitStadtDatentypen.KostenLager'First
            then
               GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde := EinheitStadtDatentypen.KostenLager'First;
               
            else
               GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde := GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde + GeldZugewinnExtern;
            end if;
            
         when False =>
            GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde := GeldZugewinnExtern;
      end case;
      
   end GeldZugewinnProRunde;
   
   
   
   procedure GesamteForschungsrate
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      ForschungsrateZugewinnExtern : in EinheitStadtDatentypen.GesamtproduktionStadt;
      RechnenSetzenExtern : in Boolean)
   is begin
      
      case
        RechnenSetzenExtern
      is
         when True =>
            if
              GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate + ForschungsrateZugewinnExtern > GlobaleVariablen.Grenzen (RasseExtern).ForschungGewinngrenze
            then
               GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate := GlobaleVariablen.Grenzen (RasseExtern).ForschungGewinngrenze;
               
            elsif
              GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate + ForschungsrateZugewinnExtern < SonstigesKonstanten.LeerWichtigesZeug.GesamteForschungsrate
            then
               GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate := SonstigesKonstanten.LeerWichtigesZeug.GesamteForschungsrate;
               
            else
               GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate := GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate + ForschungsrateZugewinnExtern;
            end if;
            
         when False =>
            if
              ForschungsrateZugewinnExtern < SonstigesKonstanten.LeerWichtigesZeug.GesamteForschungsrate
            then
               GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate := SonstigesKonstanten.LeerWichtigesZeug.GesamteForschungsrate;
               
            else
               GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate := ForschungsrateZugewinnExtern;
            end if;
      end case;
      
      VerbleibendeForschungszeit (RasseExtern => RasseExtern);
      
   end GesamteForschungsrate;
   
   
   
   procedure Forschungsmenge
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      ForschungZugewinnExtern : in EinheitStadtDatentypen.KostenLager;
      RechnenSetzenExtern : in Boolean)
   is begin
      
      case
        RechnenSetzenExtern
      is
         when True =>
            if
              GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge + ForschungZugewinnExtern > GlobaleVariablen.Grenzen (RasseExtern).Forschungsgrenze
            then
               GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge := GlobaleVariablen.Grenzen (RasseExtern).Forschungsgrenze;
               
            elsif
              GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge + ForschungZugewinnExtern < SonstigesKonstanten.LeerWichtigesZeug.Forschungsmenge
            then
               GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge := SonstigesKonstanten.LeerWichtigesZeug.Forschungsmenge;
            
            else
               GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge := GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge + ForschungZugewinnExtern;
            end if;
            
         when False =>
            if
              ForschungZugewinnExtern < SonstigesKonstanten.LeerWichtigesZeug.Forschungsmenge
            then
               GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge := SonstigesKonstanten.LeerWichtigesZeug.Forschungsmenge;
               
            else
               GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge := ForschungZugewinnExtern;
            end if;
      end case;
      
      VerbleibendeForschungszeit (RasseExtern => RasseExtern);
      
   end Forschungsmenge;
   
   
   
   procedure VerbleibendeForschungszeit
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        GlobaleVariablen.Wichtiges (RasseExtern).Forschungsprojekt = EinheitStadtDatentypen.ForschungIDMitNullWert'First
        or
          GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate = 0
      then
         GlobaleVariablen.Wichtiges (RasseExtern).VerbleibendeForschungszeit := EinheitStadtDatentypen.KostenLager'Last;
         
      else
         GlobaleVariablen.Wichtiges (RasseExtern).VerbleibendeForschungszeit
           := (LeseForschungsDatenbank.PreisForschung (RasseExtern => RasseExtern,
                                                       IDExtern    => GlobaleVariablen.Wichtiges (RasseExtern).Forschungsprojekt)
               - GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge)
             / GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate;
      end if;
      
   end VerbleibendeForschungszeit;
   
   
   
   procedure Forschungsprojekt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      ForschungIDExtern : in EinheitStadtDatentypen.ForschungIDMitNullWert)
   is begin
      
      GlobaleVariablen.Wichtiges (RasseExtern).Forschungsprojekt := ForschungIDExtern;
      Forschungsmenge (RasseExtern             => RasseExtern,
                       ForschungZugewinnExtern => SonstigesKonstanten.LeerWichtigesZeug.Forschungsmenge,
                       RechnenSetzenExtern     => False);
      
   end Forschungsprojekt;
   
   

   procedure Erforscht
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        GlobaleVariablen.Wichtiges (RasseExtern).Forschungsprojekt
      is
         when 0 =>
            null;
            
         when others =>
            GlobaleVariablen.Wichtiges (RasseExtern).Erforscht (GlobaleVariablen.Wichtiges (RasseExtern).Forschungsprojekt) := True;
      end case;
      
   end Erforscht;
   
   
   
   procedure AnzahlStädte
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      PlusMinusExtern : in Boolean)
   is begin
      
      case
        PlusMinusExtern
      is
         when True =>
            if
              GlobaleVariablen.Wichtiges (RasseExtern).AnzahlStädte >= GlobaleVariablen.Grenzen (RasseExtern).Städtegrenze
            then
               Fehler.LogikFehler (FehlermeldungExtern => "SchreibeWichtiges.AnzahlStädte - >= GlobaleVariablen.Grenzen (RasseExtern).Städtegrenze");
               
            else
               GlobaleVariablen.Wichtiges (RasseExtern).AnzahlStädte := GlobaleVariablen.Wichtiges (RasseExtern).AnzahlStädte + 1;
            end if;
            
         when False =>
            if
              GlobaleVariablen.Wichtiges (RasseExtern).AnzahlStädte = EinheitStadtDatentypen.MaximaleStädteMitNullWert'First
            then
               Fehler.LogikFehler (FehlermeldungExtern => "SchreibeWichtiges.AnzahlStädte - = EinheitStadtDatentypen.MaximaleStädteMitNullWert'First");
               
            else
               GlobaleVariablen.Wichtiges (RasseExtern).AnzahlStädte := GlobaleVariablen.Wichtiges (RasseExtern).AnzahlStädte - 1;
            end if;
      end case;
      
   end AnzahlStädte;
   
   
     
   procedure AnzahlArbeiter
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      PlusMinusExtern : in Boolean)
   is begin
      
      case
        PlusMinusExtern
      is
         when True =>
            if
              GlobaleVariablen.Wichtiges (RasseExtern).AnzahlArbeiter + GlobaleVariablen.Wichtiges (RasseExtern).AnzahlKämpfer + GlobaleVariablen.Wichtiges (RasseExtern).AnzahlSonstiges
              >= GlobaleVariablen.Grenzen (RasseExtern).Einheitengrenze
            then
               Fehler.LogikFehler (FehlermeldungExtern => "SchreibeWichtiges.AnzahlArbeiter - >= GlobaleVariablen.Grenzen (RasseExtern).Einheitengrenze");
               
            else
               GlobaleVariablen.Wichtiges (RasseExtern).AnzahlArbeiter := GlobaleVariablen.Wichtiges (RasseExtern).AnzahlArbeiter + 1;
            end if;
            
         when False =>
            if
              GlobaleVariablen.Wichtiges (RasseExtern).AnzahlArbeiter = EinheitStadtDatentypen.MaximaleEinheitenMitNullWert'First
            then
               Fehler.LogikFehler (FehlermeldungExtern => "SchreibeWichtiges.AnzahlArbeiter - = EinheitStadtDatentypen.MaximaleEinheitenMitNullWert'First");
               
            else
               GlobaleVariablen.Wichtiges (RasseExtern).AnzahlArbeiter := GlobaleVariablen.Wichtiges (RasseExtern).AnzahlArbeiter - 1;
            end if;
      end case;
            
   end AnzahlArbeiter;
   
   
     
   procedure AnzahlKämpfer
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      PlusMinusExtern : in Boolean)
   is begin
      
      case
        PlusMinusExtern
      is
         when True =>
            if
              GlobaleVariablen.Wichtiges (RasseExtern).AnzahlArbeiter + GlobaleVariablen.Wichtiges (RasseExtern).AnzahlKämpfer + GlobaleVariablen.Wichtiges (RasseExtern).AnzahlSonstiges
              >= GlobaleVariablen.Grenzen (RasseExtern).Einheitengrenze
            then
               Fehler.LogikFehler (FehlermeldungExtern => "SchreibeWichtiges.AnzahlKämpfer - >= GlobaleVariablen.Grenzen (RasseExtern).Einheitengrenze");
               
            else
               GlobaleVariablen.Wichtiges (RasseExtern).AnzahlKämpfer := GlobaleVariablen.Wichtiges (RasseExtern).AnzahlKämpfer + 1;
            end if;
            
         when False =>
            if
              GlobaleVariablen.Wichtiges (RasseExtern).AnzahlKämpfer = EinheitStadtDatentypen.MaximaleEinheitenMitNullWert'First
            then
               Fehler.LogikFehler (FehlermeldungExtern => "SchreibeWichtiges.AnzahlKämpfer - = EinheitStadtDatentypen.MaximaleEinheitenMitNullWert'First");
               
            else
               GlobaleVariablen.Wichtiges (RasseExtern).AnzahlKämpfer := GlobaleVariablen.Wichtiges (RasseExtern).AnzahlKämpfer - 1;
            end if;
      end case;
      
   end AnzahlKämpfer;
   
   
     
   procedure AnzahlSonstiges
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      PlusMinusExtern : in Boolean)
   is begin
      
      case
        PlusMinusExtern
      is
         when True =>
            if
              GlobaleVariablen.Wichtiges (RasseExtern).AnzahlArbeiter + GlobaleVariablen.Wichtiges (RasseExtern).AnzahlKämpfer + GlobaleVariablen.Wichtiges (RasseExtern).AnzahlSonstiges
              = GlobaleVariablen.Grenzen (RasseExtern).Einheitengrenze
            then
               Fehler.LogikFehler (FehlermeldungExtern => "SchreibeWichtiges.AnzahlSonstiges - = GlobaleVariablen.Grenzen (RasseExtern).Einheitengrenze");
               
            else
               GlobaleVariablen.Wichtiges (RasseExtern).AnzahlSonstiges := GlobaleVariablen.Wichtiges (RasseExtern).AnzahlSonstiges + 1;
            end if;
            
         when False =>
            if
              GlobaleVariablen.Wichtiges (RasseExtern).AnzahlSonstiges = EinheitStadtDatentypen.MaximaleEinheitenMitNullWert'First
            then
               Fehler.LogikFehler (FehlermeldungExtern => "SchreibeWichtiges.AnzahlSonstiges - = EinheitStadtDatentypen.MaximaleEinheitenMitNullWert'First");
               
            else
               GlobaleVariablen.Wichtiges (RasseExtern).AnzahlSonstiges := GlobaleVariablen.Wichtiges (RasseExtern).AnzahlSonstiges - 1;
            end if;
      end case;
      
   end AnzahlSonstiges;
      
end SchreibeWichtiges;
