pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;

private with ForschungenDatentypen;

private with ForschungenDatenbank;

private with KIDatentypen;

package KIForschungLogik is
   pragma Elaborate_Body;

   procedure Forschung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.KI_Spieler_Enum
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
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.KI_Spieler_Enum
              );

end KIForschungLogik;
