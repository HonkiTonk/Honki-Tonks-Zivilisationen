pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;

package KIDiplomatie is

   procedure Diplomatie
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemDatentypen.Spieler_KI);

   procedure DiplomatieKIMensch
     (RasseMenschExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      RasseKIExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseMenschExtern) = SystemDatentypen.Spieler_Mensch
          and
            GlobaleVariablen.RassenImSpiel (RasseKIExtern) = SystemDatentypen.Spieler_KI);

   procedure DiplomatieKIKI
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseKIExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = SystemDatentypen.Spieler_KI
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseKIExtern) = SystemDatentypen.Spieler_KI);

end KIDiplomatie;
