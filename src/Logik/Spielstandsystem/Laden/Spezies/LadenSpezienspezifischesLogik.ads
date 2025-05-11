with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

with SpeziesDatentypen;

private with SpielRecords;
private with ZahlenDatentypen;
private with ProduktionDatentypen;
private with ForschungenDatentypen;
private with StadtDatentypen;
private with EinheitenDatentypen;
private with SystemDatentypen;
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
   
   Geldmenge : ZahlenDatentypen.EigenerInteger;
   
   GeldRundengewinn : ProduktionDatentypen.Produktion;
   
   GesamteForschungsrate : ProduktionDatentypen.Lagermenge;
   
   Forschungsmenge : ProduktionDatentypen.Lagermenge;
   
   VerbleibendeForschungszeit : ProduktionDatentypen.Lagermenge;
   
   Forschungsprojekt : ForschungenDatentypen.ForschungID;
   
   ForschungVorhanden : SystemDatentypen.VierByte;
   
   Potenz : ZahlenDatentypen.EigenesNatural;
   
   Erforscht : ForschungenDatentypen.ErforschtArray;
   
   AnzahlStädte : StadtDatentypen.Städtebereich;
   
   AnzahlArbeiter : EinheitenDatentypen.Einheitenbereich;
   
   AnzahlKämpfer : EinheitenDatentypen.Einheitenbereich;
   
   AnzahlSonstiges : EinheitenDatentypen.Einheitenbereich;
   
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
