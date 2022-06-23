pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SonstigeVariablen;
with ZahlenDatentypen;
with ForschungenDatentypen;

with ForschungenDatenbank;

with KIDatentypen;

package KIForschung is

   procedure Forschung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.KI_Spieler_Enum
              );
   
private
   
   WelchesProjekt : ForschungenDatentypen.ForschungIDMitNullWert;
   
   Bewertung : KIDatentypen.AufgabenWichtigkeit;
   
   Multiplikator : ZahlenDatentypen.EigenesPositive;
   
   type MöglicheForschungenArray is array (ForschungenDatenbank.ForschungslisteArray'Range (2)) of KIDatentypen.AufgabenWichtigkeit;
   MöglicheForschungen : MöglicheForschungenArray;
      
   procedure NeuesForschungsprojekt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.KI_Spieler_Enum
              );

end KIForschung;
