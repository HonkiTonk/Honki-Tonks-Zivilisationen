with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with SystemDatentypenHTSEB;

with SpeziesDatentypen;

private with SpielRecords;
private with ProduktionDatentypen;
private with ForschungenDatentypen;
private with StadtDatentypen;
private with EinheitenDatentypen;
private with KartenRecords;

package LadenSpezienspezifischesLogik is
   pragma Elaborate_Body;

   function Aufteilung
     (LadenPrüfenExtern : in Boolean;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiLadenExtern : in File_Type)
      return Boolean;
   
private
   
   AlleGrenzen : SpielRecords.GrenzenRecord;
   
   Geldmenge : SystemDatentypenHTSEB.EigenerInteger;
   
   GeldRundengewinn : ProduktionDatentypen.Produktion;
   
   GesamteForschungsrate : ProduktionDatentypen.Lagermenge;
   
   Forschungsmenge : ProduktionDatentypen.Lagermenge;
   
   VerbleibendeForschungszeit : ProduktionDatentypen.Lagermenge;
   
   Forschungsprojekt : ForschungenDatentypen.ForschungIDMöglich;
   
   ForschungVorhanden : SystemDatentypenHTSEB.VierByte;
   
   Potenz : SystemDatentypenHTSEB.EigenesNatural;
   
   Erforscht : ForschungenDatentypen.ErforschtArray;
   
   AnzahlStädte : StadtDatentypen.StädtebereichBasis;
   
   AnzahlArbeiter : EinheitenDatentypen.EinheitenbereichBasis;
   
   AnzahlKämpfer : EinheitenDatentypen.EinheitenbereichBasis;
   
   AnzahlSonstiges : EinheitenDatentypen.EinheitenbereichBasis;
   
   Zeiger : KartenRecords.ZeigerRecord;
   
   
   
   function Grenzen
     (LadenPrüfenExtern : in Boolean;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiLadenExtern : in File_Type)
      return Boolean;
   
   function Wichtiges
     (LadenPrüfenExtern : in Boolean;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiLadenExtern : in File_Type)
      return Boolean;

end LadenSpezienspezifischesLogik;
