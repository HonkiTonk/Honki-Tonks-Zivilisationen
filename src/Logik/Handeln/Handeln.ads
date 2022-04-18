pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;

package Handeln is

   function Handelsmenü
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Integer
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer
          and
            SonstigeVariablen.RassenImSpiel (KontaktierteRasseExtern) /= SystemDatentypen.Leer);
   
private
   
   AuswahlHandeln : Integer;
   Geldmenge : Integer;
   
   procedure KontakteVerkaufen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);
   
   procedure KontakteKaufen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);
   
   procedure KontakteTauschen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);
   
   procedure GeldVerschenken
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);
   
   procedure GeldVerlangen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);
   
   procedure SichtbarkeitTauschen
     (RasseEinsExtern : in RueckgabeDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RueckgabeDatentypen.Rassen_Verwendet_Enum);
   
   procedure SichtbarkeitKaufen
     (RasseEinsExtern : in RueckgabeDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RueckgabeDatentypen.Rassen_Verwendet_Enum);
   
   procedure SichtbarkeitVerkaufen
     (RasseEinsExtern : in RueckgabeDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RueckgabeDatentypen.Rassen_Verwendet_Enum);
   
   
   
   function Handeln
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Integer;

end Handeln;
