pragma SPARK_Mode (On);

package body WichtigesSetzen is

   procedure GeldFestlegen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      GeldZugewinnExtern : in Integer)
   is begin
         
      if
        GlobaleVariablen.Wichtiges (RasseExtern).Geldmenge + GeldZugewinnExtern > Integer'Last
      then
         GlobaleVariablen.Wichtiges (RasseExtern).Geldmenge := Integer'Last;
            
      elsif
        GlobaleVariablen.Wichtiges (RasseExtern).Geldmenge + GeldZugewinnExtern < Integer'First
      then
         GlobaleVariablen.Wichtiges (RasseExtern).Geldmenge := Integer'First;
            
      else
         GlobaleVariablen.Wichtiges (RasseExtern).Geldmenge := GlobaleVariablen.Wichtiges (RasseExtern).Geldmenge + GeldZugewinnExtern;
      end if;
      
   end GeldFestlegen;
   
   
   
   procedure ForschungsmengeFestlegen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      ForschungZugewinnExtern : in GlobaleDatentypen.KostenLager)
   is begin
      
      if
        GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge + ForschungZugewinnExtern > GlobaleDatentypen.KostenLager'Last
      then
         GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge := GlobaleDatentypen.KostenLager'Last;
            
      else
         GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge := GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge + ForschungZugewinnExtern;
      end if;
      
   end ForschungsmengeFestlegen;
   
   
   
   procedure ForschungsrateFestlegen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      ForschungsrateZugewinnExtern : in GlobaleDatentypen.GesamtproduktionStadt)
   is begin
      
      if
        GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate + ForschungsrateZugewinnExtern > GlobaleDatentypen.KostenLager'Last
      then
         GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate := GlobaleDatentypen.KostenLager'Last;
               
      else
         GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate := GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate + ForschungsrateZugewinnExtern;
      end if;
      
   end ForschungsrateFestlegen;
   
   
   
   procedure GeldZugewinnFestlegen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      GeldZugewinnExtern : in GlobaleDatentypen.GesamtproduktionStadt)
   is begin
      
      if
        GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde + GeldZugewinnExtern > GlobaleDatentypen.KostenLager'Last
      then
         GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde := GlobaleDatentypen.KostenLager'Last;
               
      else
         GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde := GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde + GeldZugewinnExtern;
      end if;
      
   end GeldZugewinnFestlegen;

end WichtigesSetzen;
