with SpeziesDatentypen;

private with ForschungenDatentypen;
private with ForschungenDatenbank;

with LeseSpeziesbelegung;

private with KIDatentypen;

package KIForschungLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure Forschung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
private
   
   ForschungMöglich : Boolean;
   
   WelchesProjekt : ForschungenDatentypen.ForschungIDMöglich;
   
   Bewertung : KIDatentypen.AufgabenWichtigkeitKlein;

   LadezeitBasis : Float;
   
   type MöglicheForschungenArray is array (ForschungenDatenbank.ForschungslisteArray'Range (2)) of KIDatentypen.AufgabenWichtigkeitKlein;
   MöglicheForschungen : MöglicheForschungenArray;
      
   procedure NeuesForschungsprojekt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              );

end KIForschungLogik;
