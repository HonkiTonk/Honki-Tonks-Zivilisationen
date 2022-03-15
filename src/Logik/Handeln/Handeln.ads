pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;

package Handeln is

   function Handelsmenü
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Integer
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer
          and
            GlobaleVariablen.RassenImSpiel (KontaktierteRasseExtern) /= SystemDatentypen.Leer);
   
private
   
   AuswahlHandeln : Integer;
   Geldmenge : Integer;
   
   procedure KontakteVerkaufen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);
   
   procedure KontakteKaufen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);
   
   procedure KontakteTauschen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);
   
   procedure GeldVerschenken
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);
   
   procedure GeldVerlangen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);
   
   procedure SichtbarkeitTauschen
     (RasseEinsExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in SystemDatentypen.Rassen_Verwendet_Enum);
   
   procedure SichtbarkeitKaufen
     (RasseEinsExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in SystemDatentypen.Rassen_Verwendet_Enum);
   
   procedure SichtbarkeitVerkaufen
     (RasseEinsExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in SystemDatentypen.Rassen_Verwendet_Enum);
   
   
   
   function Handeln
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Integer;

end Handeln;
