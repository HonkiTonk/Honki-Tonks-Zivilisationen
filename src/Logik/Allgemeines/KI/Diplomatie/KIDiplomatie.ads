pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SonstigeVariablen;

package KIDiplomatie is

   procedure Diplomatie
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Spieler_KI_Enum);

   procedure DiplomatieKIMensch
     (RasseMenschExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseKIExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseMenschExtern) = RassenDatentypen.Spieler_Mensch_Enum
          and
            SonstigeVariablen.RassenImSpiel (RasseKIExtern) = RassenDatentypen.Spieler_KI_Enum);

   procedure DiplomatieKIKI
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseKIExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (EigeneRasseExtern) = RassenDatentypen.Spieler_KI_Enum
          and
            SonstigeVariablen.RassenImSpiel (FremdeRasseKIExtern) = RassenDatentypen.Spieler_KI_Enum);

end KIDiplomatie;
