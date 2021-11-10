pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;

package Diplomatie is

   procedure DiplomatieMöglich
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemDatentypen.Spieler_Mensch);

private

   KriegJetzt : Boolean;

   DiplomatischeAktion : Integer;
   StatusAuswahl : Integer;
   WelcheRasse : Integer;

   procedure DiplomatieMenü
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemDatentypen.Spieler_Mensch);



   function DiplomatischenStatusÄndern
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum;

   function AndereRassenVorhanden
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemDatentypen.Spieler_Mensch);

end Diplomatie;
