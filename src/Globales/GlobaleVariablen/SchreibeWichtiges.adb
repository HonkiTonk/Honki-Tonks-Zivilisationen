pragma SPARK_Mode (On);

with GlobaleKonstanten;

with LeseForschungsDatenbank;

package body SchreibeWichtiges is

   procedure Geldmenge
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
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
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      GeldZugewinnExtern : in GlobaleDatentypen.GesamtproduktionStadt;
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
              GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde + GeldZugewinnExtern < GlobaleDatentypen.KostenLager'First
            then
               GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde := GlobaleDatentypen.KostenLager'First;
               
            else
               GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde := GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde + GeldZugewinnExtern;
            end if;
            
         when False =>
            GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde := GeldZugewinnExtern;
      end case;
      
   end GeldZugewinnProRunde;
   
   
   
   procedure GesamteForschungsrate
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      ForschungsrateZugewinnExtern : in GlobaleDatentypen.GesamtproduktionStadt;
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
              GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate + ForschungsrateZugewinnExtern < GlobaleKonstanten.LeerWichtigesZeug.GesamteForschungsrate
            then
               GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate := GlobaleKonstanten.LeerWichtigesZeug.GesamteForschungsrate;
               
            else
               GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate := GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate + ForschungsrateZugewinnExtern;
            end if;
            
         when False =>
            if
              ForschungsrateZugewinnExtern < GlobaleKonstanten.LeerWichtigesZeug.GesamteForschungsrate
            then
               GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate := GlobaleKonstanten.LeerWichtigesZeug.GesamteForschungsrate;
               
            else
               GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate := ForschungsrateZugewinnExtern;
            end if;
      end case;
      
      VerbleibendeForschungszeit (RasseExtern => RasseExtern);
      
   end GesamteForschungsrate;
   
   
   
   procedure Forschungsmenge
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      ForschungZugewinnExtern : in GlobaleDatentypen.KostenLager;
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
              GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge + ForschungZugewinnExtern < GlobaleKonstanten.LeerWichtigesZeug.Forschungsmenge
            then
               GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge := GlobaleKonstanten.LeerWichtigesZeug.Forschungsmenge;
            
            else
               GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge := GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge + ForschungZugewinnExtern;
            end if;
            
         when False =>
            if
              ForschungZugewinnExtern < GlobaleKonstanten.LeerWichtigesZeug.Forschungsmenge
            then
               GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge := GlobaleKonstanten.LeerWichtigesZeug.Forschungsmenge;
               
            else
               GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge := ForschungZugewinnExtern;
            end if;
      end case;
      
      VerbleibendeForschungszeit (RasseExtern => RasseExtern);
      
   end Forschungsmenge;
   
   
   
   procedure VerbleibendeForschungszeit
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        GlobaleVariablen.Wichtiges (RasseExtern).Forschungsprojekt = GlobaleDatentypen.ForschungIDMitNullWert'First
        or
          GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate = 0
      then
         GlobaleVariablen.Wichtiges (RasseExtern).VerbleibendeForschungszeit := GlobaleDatentypen.KostenLager'Last;
         
      else
         GlobaleVariablen.Wichtiges (RasseExtern).VerbleibendeForschungszeit
           := (LeseForschungsDatenbank.PreisForschung (RasseExtern => RasseExtern,
                                                       IDExtern    => GlobaleVariablen.Wichtiges (RasseExtern).Forschungsprojekt)
               - GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge)
             / GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate;
      end if;
      
   end VerbleibendeForschungszeit;
   
   
   
   procedure Forschungsprojekt
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      ForschungIDExtern : in GlobaleDatentypen.ForschungIDMitNullWert)
   is begin
      
      GlobaleVariablen.Wichtiges (RasseExtern).Forschungsprojekt := ForschungIDExtern;
      GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge := GlobaleKonstanten.LeerWichtigesZeug.Forschungsmenge;
      SchreibeWichtiges.VerbleibendeForschungszeit (RasseExtern => RasseExtern);
      
   end Forschungsprojekt;
   
   

   procedure Erforscht
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
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
      
end SchreibeWichtiges;
