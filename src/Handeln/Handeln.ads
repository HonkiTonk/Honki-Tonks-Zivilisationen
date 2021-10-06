pragma SPARK_Mode (On);

with SonstigeDatentypen; use SonstigeDatentypen;
with GlobaleVariablen;

package Handeln is

   function Handelsmenü
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return Integer
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer
          and
            GlobaleVariablen.RassenImSpiel (KontaktierteRasseExtern) /= SonstigeDatentypen.Leer);
   
private
   
   AuswahlHandeln : Integer;
   Geldmenge : Integer;
   
   procedure KontakteVerkaufen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);
   
   procedure KontakteKaufen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);
   
   procedure KontakteTauschen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);
   
   procedure GeldVerschenken
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);
   
   procedure GeldVerlangen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);
   
   procedure SichtbarkeitTauschen
     (RasseEinsExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);
   
   procedure SichtbarkeitKaufen
     (RasseEinsExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);
   
   procedure SichtbarkeitVerkaufen
     (RasseEinsExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);
   
   
   
   function Handeln
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return Integer;

end Handeln;
