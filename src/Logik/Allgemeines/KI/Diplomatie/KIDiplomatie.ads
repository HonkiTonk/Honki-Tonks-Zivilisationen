pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;

package KIDiplomatie is

   procedure Diplomatie
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemDatentypen.Spieler_KI_Enum);

   procedure DiplomatieKIMensch
     (RasseMenschExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      RasseKIExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseMenschExtern) = SystemDatentypen.Spieler_Mensch_Enum
          and
            GlobaleVariablen.RassenImSpiel (RasseKIExtern) = SystemDatentypen.Spieler_KI_Enum);

   procedure DiplomatieKIKI
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseKIExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = SystemDatentypen.Spieler_KI_Enum
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseKIExtern) = SystemDatentypen.Spieler_KI_Enum);

end KIDiplomatie;
