pragma SPARK_Mode (On);

with GlobaleVariablen, SonstigeDatentypen;
use SonstigeDatentypen;

package Diplomatie is

   procedure DiplomatieMöglich
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SonstigeDatentypen.Spieler_Mensch);

private

   KriegJetzt : Boolean;

   DiplomatischeAktion : Integer;
   StatusAuswahl : Integer;
   WelcheRasse : Integer;

   procedure DiplomatieMenü
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SonstigeDatentypen.Spieler_Mensch);



   function DiplomatischenStatusÄndern
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return Integer;

   function AndereRassenVorhanden
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SonstigeDatentypen.Spieler_Mensch);

end Diplomatie;
