pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package Diplomatie is

   procedure DiplomatieMöglich
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = GlobaleDatentypen.Spieler_Mensch);

private

   AndereRassenVorhanden : Boolean;
   KriegJetzt : Boolean;

   DiplomatischeAktion : Integer;
   StatusAuswahl : Integer;
   WelcheRasse : Integer;

   procedure DiplomatieMenü
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = GlobaleDatentypen.Spieler_Mensch);



   function DiplomatischenStatusÄndern
     (RasseExtern, KontaktierteRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Integer;

end Diplomatie;
