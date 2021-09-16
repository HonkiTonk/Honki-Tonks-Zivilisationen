pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package Handeln is

   function Handelsmenü
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Integer
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer
          and
            GlobaleVariablen.RassenImSpiel (KontaktierteRasseExtern) /= GlobaleDatentypen.Leer);
   
private
   
   AuswahlHandeln : Integer;
   Geldmenge : Integer;
   
   procedure KontakteVerkaufen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);
   
   procedure KontakteKaufen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);
   
   procedure KontakteTauschen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);
   
   procedure GeldVerschenken
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);
   
   procedure GeldVerlangen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);
   
   procedure SichtbarkeitTauschen
     (RasseEinsExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);
   
   procedure SichtbarkeitKaufen
     (RasseEinsExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);
   
   procedure SichtbarkeitVerkaufen
     (RasseEinsExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);
   
   
   
   function Handeln
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Integer;

end Handeln;
