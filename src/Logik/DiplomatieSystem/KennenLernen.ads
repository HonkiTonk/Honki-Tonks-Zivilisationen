pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with SystemKonstanten;

package KennenLernen is

   procedure Erstkontakt
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) /= SystemKonstanten.LeerSpielerKonstante
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) /= SystemKonstanten.LeerSpielerKonstante);

private

   procedure ErstkontaktMenschMensch
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = SystemKonstanten.SpielerMenschKonstante
          and
            GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) = SystemKonstanten.SpielerMenschKonstante);

   procedure ErstkontaktMenschKI
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (EigeneRasseExtern /= FremdeRasseExtern
          and
            (GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = SystemKonstanten.SpielerMenschKonstante
             or
               GlobaleVariablen.RassenImSpiel (FremdeRasseExtern) = SystemKonstanten.SpielerMenschKonstante));

end KennenLernen;
