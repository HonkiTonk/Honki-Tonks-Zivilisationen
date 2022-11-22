with RassenDatentypen;

private with ForschungenDatentypen;
private with ForschungenDatenbank;

with LeseRassenbelegung;

private with KIDatentypen;

package KIForschungLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   procedure Forschung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) = RassenDatentypen.KI_Spieler_Enum
              );
   
private
   
   ForschungMöglich : Boolean;
   
   Ladezeit : ForschungenDatentypen.ForschungID;
   
   WelchesProjekt : ForschungenDatentypen.ForschungIDMitNullWert;
   
   Bewertung : KIDatentypen.AufgabenWichtigkeitKlein;
   
   type MöglicheForschungenArray is array (ForschungenDatenbank.ForschungslisteArray'Range (2)) of KIDatentypen.AufgabenWichtigkeitKlein;
   MöglicheForschungen : MöglicheForschungenArray;
      
   procedure NeuesForschungsprojekt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) = RassenDatentypen.KI_Spieler_Enum
              );

end KIForschungLogik;
