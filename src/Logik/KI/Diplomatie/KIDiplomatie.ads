pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with SystemKonstanten;

package KIDiplomatie is

   procedure Diplomatie
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemKonstanten.SpielerKIKonstante);

   procedure DiplomatieKIMensch
     (RasseMenschExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      RasseKIExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseMenschExtern) = SystemKonstanten.SpielerMenschKonstante
          and
            GlobaleVariablen.RassenImSpiel (RasseKIExtern) = SystemKonstanten.SpielerKIKonstante);

   procedure DiplomatieKIKI
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseKIExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = SystemKonstanten.SpielerKIKonstante
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseKIExtern) = SystemKonstanten.SpielerKIKonstante);

end KIDiplomatie;
