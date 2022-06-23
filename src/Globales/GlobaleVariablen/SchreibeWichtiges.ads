pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with ZahlenDatentypen;
with SonstigeVariablen;
with ForschungenDatentypen;
with ProduktionDatentypen;

package SchreibeWichtiges is

   procedure Geldmenge
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      GeldZugewinnExtern : in ZahlenDatentypen.EigenerInteger;
      RechnenSetzenExtern : in Boolean)
     with
       Pre => (
                 SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure GeldZugewinnProRunde
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      GeldZugewinnExtern : in ProduktionDatentypen.Stadtproduktion;
      RechnenSetzenExtern : in Boolean)
     with
       Pre => (
                 SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure GesamteForschungsrate
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ForschungsrateZugewinnExtern : in ProduktionDatentypen.Stadtproduktion;
      RechnenSetzenExtern : in Boolean)
     with
       Pre => (
                 SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure Forschungsmenge
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ForschungZugewinnExtern : in ProduktionDatentypen.Produktion;
      RechnenSetzenExtern : in Boolean)
     with
       Pre => (
                 SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure VerbleibendeForschungszeit
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure Forschungsprojekt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ForschungIDExtern : in ForschungenDatentypen.ForschungIDMitNullWert)
     with
       Pre => (
                 SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

   procedure Erforscht
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure AnzahlStädte
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      PlusMinusExtern : in Boolean)
     with
       Pre => (
                 SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
     
   procedure AnzahlArbeiter
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      PlusMinusExtern : in Boolean)
     with
       Pre => (
                 SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
     
   procedure AnzahlKämpfer
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      PlusMinusExtern : in Boolean)
     with
       Pre => (
                 SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
     
   procedure AnzahlSonstiges
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      PlusMinusExtern : in Boolean)
     with
       Pre => (
                 SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

end SchreibeWichtiges;
