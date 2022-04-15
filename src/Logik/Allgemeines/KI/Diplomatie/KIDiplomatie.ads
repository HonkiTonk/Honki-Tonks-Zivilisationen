pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with GlobaleVariablen;

package KIDiplomatie is

   procedure Diplomatie
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Spieler_KI_Enum);

   procedure DiplomatieKIMensch
     (RasseMenschExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseKIExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseMenschExtern) = RassenDatentypen.Spieler_Mensch_Enum
          and
            GlobaleVariablen.RassenImSpiel (RasseKIExtern) = RassenDatentypen.Spieler_KI_Enum);

   procedure DiplomatieKIKI
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseKIExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = RassenDatentypen.Spieler_KI_Enum
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseKIExtern) = RassenDatentypen.Spieler_KI_Enum);

end KIDiplomatie;
