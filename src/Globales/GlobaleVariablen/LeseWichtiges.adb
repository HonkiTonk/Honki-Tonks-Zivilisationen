pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ProduktionDatentypen; use ProduktionDatentypen;
with WichtigesKonstanten;

package body LeseWichtiges is

   function Geldmenge
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Integer
   is begin

      return SpielVariablen.Wichtiges (RasseExtern).Geldmenge;

   end Geldmenge;
   


   function GeldZugewinnProRunde
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.KostenLager
   is begin

      return SpielVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde;

   end GeldZugewinnProRunde;
   
   

   function GesamteForschungsrate
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.KostenLager
   is begin

      if
        SpielVariablen.Wichtiges (RasseExtern).GesamteForschungsrate < WichtigesKonstanten.LeerWichtigesZeug.GesamteForschungsrate
      then
         SpielVariablen.Wichtiges (RasseExtern).GesamteForschungsrate := WichtigesKonstanten.LeerWichtigesZeug.GesamteForschungsrate;
         
      else
         null;
      end if;
      
      return SpielVariablen.Wichtiges (RasseExtern).GesamteForschungsrate;

   end GesamteForschungsrate;
   
   
   
   function Forschungsmenge
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.KostenLager
   is begin

      if
        SpielVariablen.Wichtiges (RasseExtern).Forschungsmenge < WichtigesKonstanten.LeerWichtigesZeug.Forschungsmenge
      then
         SpielVariablen.Wichtiges (RasseExtern).Forschungsmenge := WichtigesKonstanten.LeerWichtigesZeug.Forschungsmenge;
         
      else
         null;
      end if;

      return SpielVariablen.Wichtiges (RasseExtern).Forschungsmenge;

   end Forschungsmenge;
   
   
   
   function VerbleibendeForschungszeit
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ProduktionDatentypen.KostenLager
   is begin

      if
        SpielVariablen.Wichtiges (RasseExtern).VerbleibendeForschungszeit > WichtigesKonstanten.LeerWichtigesZeug.VerbleibendeForschungszeit
      then
         SpielVariablen.Wichtiges (RasseExtern).VerbleibendeForschungszeit := WichtigesKonstanten.LeerWichtigesZeug.VerbleibendeForschungszeit;
         
      else
         null;
      end if;

      return SpielVariablen.Wichtiges (RasseExtern).VerbleibendeForschungszeit;

   end VerbleibendeForschungszeit;
   
   
   
   function Forschungsprojekt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ForschungenDatentypen.ForschungIDMitNullWert
   is begin

      return SpielVariablen.Wichtiges (RasseExtern).Forschungsprojekt;

   end Forschungsprojekt;
   
   

   function Erforscht
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WelcheTechnologieExtern : in ForschungenDatentypen.ForschungID)
      return Boolean
   is begin

      return SpielVariablen.Wichtiges (RasseExtern).Erforscht (WelcheTechnologieExtern);

   end Erforscht;
   
   
   
   function AnzahlStädte
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return StadtDatentypen.MaximaleStädteMitNullWert
   is begin
      
      return SpielVariablen.Wichtiges (RasseExtern).AnzahlStädte;
      
   end AnzahlStädte;
   
   
   
   function AnzahlEinheiten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      return SpielVariablen.Wichtiges (RasseExtern).AnzahlArbeiter + SpielVariablen.Wichtiges (RasseExtern).AnzahlKämpfer + SpielVariablen.Wichtiges (RasseExtern).AnzahlSonstiges;
      
   end AnzahlEinheiten;
     
   
     
   function AnzahlArbeiter
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      return SpielVariablen.Wichtiges (RasseExtern).AnzahlArbeiter;
      
   end AnzahlArbeiter;
   
   
     
   function AnzahlKämpfer
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      return SpielVariablen.Wichtiges (RasseExtern).AnzahlKämpfer;
      
   end AnzahlKämpfer;
   
   
     
   function AnzahlSonstiges
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      return SpielVariablen.Wichtiges (RasseExtern).AnzahlSonstiges;
      
   end AnzahlSonstiges;

end LeseWichtiges;
