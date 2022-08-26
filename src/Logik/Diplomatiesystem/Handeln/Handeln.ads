pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;

package Handeln is
   
   procedure SichtbarkeitTauschen
     (RasseEinsExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseEinsExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SpielVariablen.RassenImSpiel (RasseZweiExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   

   function Handelsmenü
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Integer
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SpielVariablen.RassenImSpiel (KontaktierteRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
private
   
   AuswahlHandeln : Integer;
   Geldmenge : Integer;
   
   procedure KontakteVerkaufen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SpielVariablen.RassenImSpiel (KontaktierteRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure KontakteKaufen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SpielVariablen.RassenImSpiel (KontaktierteRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure KontakteTauschen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SpielVariablen.RassenImSpiel (KontaktierteRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure GeldVerschenken
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SpielVariablen.RassenImSpiel (KontaktierteRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure GeldVerlangen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SpielVariablen.RassenImSpiel (KontaktierteRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
      
   procedure SichtbarkeitKaufen
     (RasseEinsExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseEinsExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SpielVariablen.RassenImSpiel (RasseZweiExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure SichtbarkeitVerkaufen
     (RasseEinsExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseEinsExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SpielVariablen.RassenImSpiel (RasseZweiExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   
   
   function Handeln
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Integer
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SpielVariablen.RassenImSpiel (KontaktierteRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

end Handeln;
