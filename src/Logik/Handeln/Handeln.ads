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
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer
               and
                 SpielVariablen.RassenImSpiel (KontaktierteRasseExtern) /= SystemDatentypen.Leer
              );
   
private
   
   AuswahlHandeln : Integer;
   Geldmenge : Integer;
   
   procedure KontakteVerkaufen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer
               and
                 SpielVariablen.RassenImSpiel (KontaktierteRasseExtern) /= SystemDatentypen.Leer
              );
   
   procedure KontakteKaufen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer
               and
                 SpielVariablen.RassenImSpiel (KontaktierteRasseExtern) /= SystemDatentypen.Leer
              );
   
   procedure KontakteTauschen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer
               and
                 SpielVariablen.RassenImSpiel (KontaktierteRasseExtern) /= SystemDatentypen.Leer
              );
   
   procedure GeldVerschenken
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer
               and
                 SpielVariablen.RassenImSpiel (KontaktierteRasseExtern) /= SystemDatentypen.Leer
              );
   
   procedure GeldVerlangen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer
               and
                 SpielVariablen.RassenImSpiel (KontaktierteRasseExtern) /= SystemDatentypen.Leer
              );
   
   procedure SichtbarkeitTauschen
     (RasseEinsExtern : in RueckgabeDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RueckgabeDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseEinsExtern) /= SystemDatentypen.Leer
               and
                 SpielVariablen.RassenImSpiel (RasseZweiExtern) /= SystemDatentypen.Leer
              );
   
   procedure SichtbarkeitKaufen
     (RasseEinsExtern : in RueckgabeDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RueckgabeDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseEinsExtern) /= SystemDatentypen.Leer
               and
                 SpielVariablen.RassenImSpiel (RasseZweiExtern) /= SystemDatentypen.Leer
              );
   
   procedure SichtbarkeitVerkaufen
     (RasseEinsExtern : in RueckgabeDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RueckgabeDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseEinsExtern) /= SystemDatentypen.Leer
               and
                 SpielVariablen.RassenImSpiel (RasseZweiExtern) /= SystemDatentypen.Leer
              );
   
   
   
   function Handeln
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Integer
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer
               and
                 SpielVariablen.RassenImSpiel (KontaktierteRasseExtern) /= SystemDatentypen.Leer
              );

end Handeln;
