pragma SPARK_Mode (On);

with SonstigeDatentypen; use SonstigeDatentypen;
with SystemDatentypen;
with GlobaleVariablen;

package KIDiplomatie is

   procedure Diplomatie
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SonstigeDatentypen.Spieler_KI);

   procedure DiplomatieKIMensch
     (RasseMenschExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      RasseKIExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseMenschExtern) = SonstigeDatentypen.Spieler_Mensch
          and
            GlobaleVariablen.RassenImSpiel (RasseKIExtern) = SonstigeDatentypen.Spieler_KI);

   procedure DiplomatieKIKI
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseKIExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = SonstigeDatentypen.Spieler_KI
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseKIExtern) = SonstigeDatentypen.Spieler_KI);

end KIDiplomatie;
