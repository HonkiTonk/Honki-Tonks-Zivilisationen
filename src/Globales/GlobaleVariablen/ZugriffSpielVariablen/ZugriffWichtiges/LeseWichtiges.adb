with SpielVariablen;

package body LeseWichtiges is

   function Geldmenge
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Integer
   is begin

      return SpielVariablen.Wichtiges (SpeziesExtern).Geldmenge;

   end Geldmenge;
   


   function GeldRundengewinn
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return ProduktionDatentypen.Produktion
   is begin

      return SpielVariablen.Wichtiges (SpeziesExtern).GeldRundengewinn;

   end GeldRundengewinn;
   
   

   function GesamteForschungsrate
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return ProduktionDatentypen.Lagermenge
   is begin
      
      return SpielVariablen.Wichtiges (SpeziesExtern).GesamteForschungsrate;

   end GesamteForschungsrate;
   
   
   
   function Forschungsmenge
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return ProduktionDatentypen.Lagermenge
   is begin

      return SpielVariablen.Wichtiges (SpeziesExtern).Forschungsmenge;

   end Forschungsmenge;
   
   
   
   function VerbleibendeForschungszeit
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return ProduktionDatentypen.Lagermenge
   is begin

      return SpielVariablen.Wichtiges (SpeziesExtern).VerbleibendeForschungszeit;

   end VerbleibendeForschungszeit;
   
   
   
   function Forschungsprojekt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return ForschungenDatentypen.ForschungID
   is begin

      return SpielVariablen.Wichtiges (SpeziesExtern).Forschungsprojekt;

   end Forschungsprojekt;
   
   

   function Erforscht
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      WelcheTechnologieExtern : in ForschungenDatentypen.ForschungIDVorhanden)
      return Boolean
   is begin

      return SpielVariablen.Wichtiges (SpeziesExtern).Erforscht (WelcheTechnologieExtern);

   end Erforscht;
   
   
   
   function AnzahlStädte
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return StadtDatentypen.Städtebereich
   is begin
      
      return SpielVariablen.Wichtiges (SpeziesExtern).AnzahlStädte;
      
   end AnzahlStädte;
   
   
   
   function AnzahlEinheiten
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return EinheitenDatentypen.Einheitenbereich
   is begin
      
      return SpielVariablen.Wichtiges (SpeziesExtern).AnzahlArbeiter + SpielVariablen.Wichtiges (SpeziesExtern).AnzahlKämpfer + SpielVariablen.Wichtiges (SpeziesExtern).AnzahlSonstiges;
      
   end AnzahlEinheiten;
     
   
     
   function AnzahlArbeiter
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return EinheitenDatentypen.Einheitenbereich
   is begin
      
      return SpielVariablen.Wichtiges (SpeziesExtern).AnzahlArbeiter;
      
   end AnzahlArbeiter;
   
   
     
   function AnzahlKämpfer
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return EinheitenDatentypen.Einheitenbereich
   is begin
      
      return SpielVariablen.Wichtiges (SpeziesExtern).AnzahlKämpfer;
      
   end AnzahlKämpfer;
   
   
     
   function AnzahlSonstiges
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return EinheitenDatentypen.Einheitenbereich
   is begin
      
      return SpielVariablen.Wichtiges (SpeziesExtern).AnzahlSonstiges;
      
   end AnzahlSonstiges;
   
   
   
   function GanzerEintrag
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return SpielRecords.WichtigesRecord
   is begin
      
      return SpielVariablen.Wichtiges (SpeziesExtern);
      
   end GanzerEintrag;

end LeseWichtiges;
