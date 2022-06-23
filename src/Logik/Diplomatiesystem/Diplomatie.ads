pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with RueckgabeDatentypen;
with SonstigeVariablen;

package Diplomatie is

   procedure DiplomatieMöglich
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );

private

   KriegJetzt : Boolean;

   DiplomatischeAktion : Integer;
   StatusAuswahl : Integer;
   WelcheRasse : Integer;

   procedure DiplomatieMenü
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );



   function DiplomatischenStatusÄndern
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
     with
       Pre => (
                 SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
               and
                 SonstigeVariablen.RassenImSpiel (KontaktierteRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

   function AndereRassenVorhanden
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre => (
                 SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

end Diplomatie;
