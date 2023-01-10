with SpielVariablen;

package body LeseWichtiges is

   function Geldmenge
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Integer
   is begin

      return SpielVariablen.Wichtiges (SpeziesExtern).Geldmenge;

   end Geldmenge;
   


   function GeldZugewinnProRunde
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Produktion
   is begin

      return SpielVariablen.Wichtiges (SpeziesExtern).GeldZugewinnProRunde;

   end GeldZugewinnProRunde;
   
   

   function GesamteForschungsrate
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Lagermenge
   is begin
      
      return SpielVariablen.Wichtiges (SpeziesExtern).GesamteForschungsrate;

   end GesamteForschungsrate;
   
   
   
   function Forschungsmenge
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Lagermenge
   is begin

      return SpielVariablen.Wichtiges (SpeziesExtern).Forschungsmenge;

   end Forschungsmenge;
   
   
   
   function VerbleibendeForschungszeit
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ProduktionDatentypen.Lagermenge
   is begin

      return SpielVariablen.Wichtiges (SpeziesExtern).VerbleibendeForschungszeit;

   end VerbleibendeForschungszeit;
   
   
   
   function Forschungsprojekt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ForschungenDatentypen.ForschungIDMitNullWert
   is begin

      return SpielVariablen.Wichtiges (SpeziesExtern).Forschungsprojekt;

   end Forschungsprojekt;
   
   

   function Erforscht
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      WelcheTechnologieExtern : in ForschungenDatentypen.ForschungID)
      return Boolean
   is begin

      return SpielVariablen.Wichtiges (SpeziesExtern).Erforscht (WelcheTechnologieExtern);

   end Erforscht;
   
   
   
   function AnzahlStädte
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return StadtDatentypen.MaximaleStädteMitNullWert
   is begin
      
      return SpielVariablen.Wichtiges (SpeziesExtern).AnzahlStädte;
      
   end AnzahlStädte;
   
   
   
   function AnzahlEinheiten
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      return SpielVariablen.Wichtiges (SpeziesExtern).AnzahlArbeiter + SpielVariablen.Wichtiges (SpeziesExtern).AnzahlKämpfer + SpielVariablen.Wichtiges (SpeziesExtern).AnzahlSonstiges;
      
   end AnzahlEinheiten;
     
   
     
   function AnzahlArbeiter
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      return SpielVariablen.Wichtiges (SpeziesExtern).AnzahlArbeiter;
      
   end AnzahlArbeiter;
   
   
     
   function AnzahlKämpfer
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      return SpielVariablen.Wichtiges (SpeziesExtern).AnzahlKämpfer;
      
   end AnzahlKämpfer;
   
   
     
   function AnzahlSonstiges
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      return SpielVariablen.Wichtiges (SpeziesExtern).AnzahlSonstiges;
      
   end AnzahlSonstiges;
   
   
   
   function GanzerEintrag
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return SpielRecords.WichtigesRecord
   is begin
      
      return SpielVariablen.Wichtiges (SpeziesExtern);
      
   end GanzerEintrag;

end LeseWichtiges;
