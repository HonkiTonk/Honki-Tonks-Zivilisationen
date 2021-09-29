pragma SPARK_Mode (On);

with SonstigesKonstanten;

package body LeseWichtiges is

   function Geldmenge
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Integer
   is begin

      return GlobaleVariablen.Wichtiges (RasseExtern).Geldmenge;

   end Geldmenge;
   


   function GeldZugewinnProRunde
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.KostenLager
   is begin

      return GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde;

   end GeldZugewinnProRunde;
   
   

   function GesamteForschungsrate
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.KostenLager
   is begin

      if
        GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate < SonstigesKonstanten.LeerWichtigesZeug.GesamteForschungsrate
      then
         GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate := SonstigesKonstanten.LeerWichtigesZeug.GesamteForschungsrate;
         
      else
         null;
      end if;
      
      return GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate;

   end GesamteForschungsrate;
   
   
   
   function Forschungsmenge
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.KostenLager
   is begin

      if
        GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge < SonstigesKonstanten.LeerWichtigesZeug.Forschungsmenge
      then
         GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge := SonstigesKonstanten.LeerWichtigesZeug.Forschungsmenge;
         
      else
         null;
      end if;

      return GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge;

   end Forschungsmenge;
   
   
   
   function VerbleibendeForschungszeit
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.KostenLager
   is begin

      if
        GlobaleVariablen.Wichtiges (RasseExtern).VerbleibendeForschungszeit > SonstigesKonstanten.LeerWichtigesZeug.VerbleibendeForschungszeit
      then
         GlobaleVariablen.Wichtiges (RasseExtern).VerbleibendeForschungszeit := SonstigesKonstanten.LeerWichtigesZeug.VerbleibendeForschungszeit;
         
      else
         null;
      end if;

      return GlobaleVariablen.Wichtiges (RasseExtern).VerbleibendeForschungszeit;

   end VerbleibendeForschungszeit;
   
   
   
   function Forschungsprojekt
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.ForschungIDMitNullWert
   is begin

      return GlobaleVariablen.Wichtiges (RasseExtern).Forschungsprojekt;

   end Forschungsprojekt;
   
   

   function Erforscht
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      WelcheTechnologieExtern : in GlobaleDatentypen.ForschungID)
      return Boolean
   is begin

      return GlobaleVariablen.Wichtiges (RasseExtern).Erforscht (WelcheTechnologieExtern);

   end Erforscht;
   
   
   
   function AnzahlStädte
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.MaximaleStädteMitNullWert
   is begin
      
      return GlobaleVariablen.Wichtiges (RasseExtern).AnzahlStädte;
      
   end AnzahlStädte;
   
   
   
   function AnzahlEinheiten
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      return GlobaleVariablen.Wichtiges (RasseExtern).AnzahlArbeiter + GlobaleVariablen.Wichtiges (RasseExtern).AnzahlKämpfer + GlobaleVariablen.Wichtiges (RasseExtern).AnzahlSonstiges;
      
   end AnzahlEinheiten;
     
   
     
   function AnzahlArbeiter
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      return GlobaleVariablen.Wichtiges (RasseExtern).AnzahlArbeiter;
      
   end AnzahlArbeiter;
   
   
     
   function AnzahlKämpfer
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      return GlobaleVariablen.Wichtiges (RasseExtern).AnzahlKämpfer;
      
   end AnzahlKämpfer;
   
   
     
   function AnzahlSonstiges
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      return GlobaleVariablen.Wichtiges (RasseExtern).AnzahlSonstiges;
      
   end AnzahlSonstiges;

end LeseWichtiges;
