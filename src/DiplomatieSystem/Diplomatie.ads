pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package Diplomatie is

   procedure DiplomatieMenü
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = GlobaleDatentypen.Spieler_Mensch);



   function GegnerAngreifen
     (EigeneRasseExtern, GegnerischeRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre =>
         (EigeneRasseExtern /= GegnerischeRasseExtern
          and
            GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) /= GlobaleDatentypen.Leer
          and
            GlobaleVariablen.RassenImSpiel (GegnerischeRasseExtern) /= GlobaleDatentypen.Leer);

end Diplomatie;
