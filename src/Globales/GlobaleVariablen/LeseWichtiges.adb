pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with WichtigesKonstanten;

package body LeseWichtiges is

   function Geldmenge
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Integer
   is begin

      return GlobaleVariablen.Wichtiges (RasseExtern).Geldmenge;

   end Geldmenge;
   


   function GeldZugewinnProRunde
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.KostenLager
   is begin

      return GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde;

   end GeldZugewinnProRunde;
   
   

   function GesamteForschungsrate
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.KostenLager
   is begin

      if
        GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate < WichtigesKonstanten.LeerWichtigesZeug.GesamteForschungsrate
      then
         GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate := WichtigesKonstanten.LeerWichtigesZeug.GesamteForschungsrate;
         
      else
         null;
      end if;
      
      return GlobaleVariablen.Wichtiges (RasseExtern).GesamteForschungsrate;

   end GesamteForschungsrate;
   
   
   
   function Forschungsmenge
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.KostenLager
   is begin

      if
        GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge < WichtigesKonstanten.LeerWichtigesZeug.Forschungsmenge
      then
         GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge := WichtigesKonstanten.LeerWichtigesZeug.Forschungsmenge;
         
      else
         null;
      end if;

      return GlobaleVariablen.Wichtiges (RasseExtern).Forschungsmenge;

   end Forschungsmenge;
   
   
   
   function VerbleibendeForschungszeit
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.KostenLager
   is begin

      if
        GlobaleVariablen.Wichtiges (RasseExtern).VerbleibendeForschungszeit > WichtigesKonstanten.LeerWichtigesZeug.VerbleibendeForschungszeit
      then
         GlobaleVariablen.Wichtiges (RasseExtern).VerbleibendeForschungszeit := WichtigesKonstanten.LeerWichtigesZeug.VerbleibendeForschungszeit;
         
      else
         null;
      end if;

      return GlobaleVariablen.Wichtiges (RasseExtern).VerbleibendeForschungszeit;

   end VerbleibendeForschungszeit;
   
   
   
   function Forschungsprojekt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ForschungIDMitNullWert
   is begin

      return GlobaleVariablen.Wichtiges (RasseExtern).Forschungsprojekt;

   end Forschungsprojekt;
   
   

   function Erforscht
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      WelcheTechnologieExtern : in EinheitStadtDatentypen.ForschungID)
      return Boolean
   is begin

      return GlobaleVariablen.Wichtiges (RasseExtern).Erforscht (WelcheTechnologieExtern);

   end Erforscht;
   
   
   
   function AnzahlStädte
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.MaximaleStädteMitNullWert
   is begin
      
      return GlobaleVariablen.Wichtiges (RasseExtern).AnzahlStädte;
      
   end AnzahlStädte;
   
   
   
   function AnzahlEinheiten
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      return GlobaleVariablen.Wichtiges (RasseExtern).AnzahlArbeiter + GlobaleVariablen.Wichtiges (RasseExtern).AnzahlKämpfer + GlobaleVariablen.Wichtiges (RasseExtern).AnzahlSonstiges;
      
   end AnzahlEinheiten;
     
   
     
   function AnzahlArbeiter
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      return GlobaleVariablen.Wichtiges (RasseExtern).AnzahlArbeiter;
      
   end AnzahlArbeiter;
   
   
     
   function AnzahlKämpfer
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      return GlobaleVariablen.Wichtiges (RasseExtern).AnzahlKämpfer;
      
   end AnzahlKämpfer;
   
   
     
   function AnzahlSonstiges
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      return GlobaleVariablen.Wichtiges (RasseExtern).AnzahlSonstiges;
      
   end AnzahlSonstiges;

end LeseWichtiges;
