private with AllgemeineBerechnungenHTSEB;

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
   
   Ladezeit : ForschungenDatentypen.ForschungIDVorhanden;
   
   WelchesProjekt : ForschungenDatentypen.ForschungID;
   
   Bewertung : KIDatentypen.AufgabenWichtigkeitKlein;
   
   type MöglicheForschungenArray is array (ForschungenDatenbank.ForschungslisteArray'Range (2)) of KIDatentypen.AufgabenWichtigkeitKlein;
   MöglicheForschungen : MöglicheForschungenArray;
      
   procedure NeuesForschungsprojekt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
   
   
   function Basiszeitwert is new AllgemeineBerechnungenHTSEB.Basiszeitwert (GanzeZahl => Positive);

end KIForschungLogik;
