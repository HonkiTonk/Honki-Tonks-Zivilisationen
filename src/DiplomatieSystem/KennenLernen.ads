pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;

package KennenLernen is

   procedure Erstkontakt
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) /= SystemDatentypen.Leer
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) /= SystemDatentypen.Leer);

private

   procedure ErstkontaktMenschMensch
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = SystemDatentypen.Spieler_Mensch
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) = SystemDatentypen.Spieler_Mensch);

   procedure ErstkontaktMenschKI
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            (GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = SystemDatentypen.Spieler_Mensch
             or
               GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) = SystemDatentypen.Spieler_Mensch));

end KennenLernen;
