pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;

package KIDiplomatie is

   procedure Diplomatie
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.KI_Spieler_Enum
              );

   procedure DiplomatieKIMensch
     (RasseMenschExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseKIExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseMenschExtern) = RassenDatentypen.Mensch_Spieler_Enum
               and
                 SpielVariablen.RassenImSpiel (RasseKIExtern) = RassenDatentypen.KI_Spieler_Enum
              );

   procedure DiplomatieKIKI
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseKIExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (EigeneRasseExtern) = RassenDatentypen.KI_Spieler_Enum
               and
                 SpielVariablen.RassenImSpiel (FremdeRasseKIExtern) = RassenDatentypen.KI_Spieler_Enum
              );

end KIDiplomatie;
