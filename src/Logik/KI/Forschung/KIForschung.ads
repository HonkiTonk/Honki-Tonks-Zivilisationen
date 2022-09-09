pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;

private with ForschungenDatentypen;

private with ForschungenDatenbank;

private with KIDatentypen;

package KIForschung is

   procedure Forschung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.KI_Spieler_Enum
              );
   
private
   
   ForschungMöglich : Boolean;
   
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

end KIForschung;
