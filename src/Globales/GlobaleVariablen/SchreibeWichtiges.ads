pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with EinheitStadtDatentypen;

package SchreibeWichtiges is

   procedure Geldmenge
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      GeldZugewinnExtern : in Integer;
      RechnenSetzenExtern : in Boolean)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);
   
   procedure GeldZugewinnProRunde
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      GeldZugewinnExtern : in EinheitStadtDatentypen.GesamtproduktionStadt;
      RechnenSetzenExtern : in Boolean)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);
   
   procedure GesamteForschungsrate
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      ForschungsrateZugewinnExtern : in EinheitStadtDatentypen.GesamtproduktionStadt;
      RechnenSetzenExtern : in Boolean)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);
   
   procedure Forschungsmenge
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      ForschungZugewinnExtern : in EinheitStadtDatentypen.KostenLager;
      RechnenSetzenExtern : in Boolean)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);
   
   procedure VerbleibendeForschungszeit
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);
   
   procedure Forschungsprojekt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      ForschungIDExtern : in EinheitStadtDatentypen.ForschungIDMitNullWert)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);

   procedure Erforscht
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);
   
   procedure AnzahlStädte
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      PlusMinusExtern : in Boolean)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);
     
   procedure AnzahlArbeiter
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      PlusMinusExtern : in Boolean)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);
     
   procedure AnzahlKämpfer
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      PlusMinusExtern : in Boolean)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);
     
   procedure AnzahlSonstiges
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      PlusMinusExtern : in Boolean)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);

end SchreibeWichtiges;
