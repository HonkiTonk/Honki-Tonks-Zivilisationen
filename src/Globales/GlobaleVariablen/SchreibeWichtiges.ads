pragma SPARK_Mode (On);

with GlobaleVariablen, SonstigeDatentypen, EinheitStadtDatentypen;
use SonstigeDatentypen;

package SchreibeWichtiges is

   procedure Geldmenge
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      GeldZugewinnExtern : in Integer;
      RechnenSetzenExtern : in Boolean)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer);
   
   procedure GeldZugewinnProRunde
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      GeldZugewinnExtern : in EinheitStadtDatentypen.GesamtproduktionStadt;
      RechnenSetzenExtern : in Boolean)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer);
   
   procedure GesamteForschungsrate
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      ForschungsrateZugewinnExtern : in EinheitStadtDatentypen.GesamtproduktionStadt;
      RechnenSetzenExtern : in Boolean)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer);
   
   procedure Forschungsmenge
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      ForschungZugewinnExtern : in EinheitStadtDatentypen.KostenLager;
      RechnenSetzenExtern : in Boolean)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer);
   
   procedure VerbleibendeForschungszeit
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer);
   
   procedure Forschungsprojekt
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      ForschungIDExtern : in EinheitStadtDatentypen.ForschungIDMitNullWert)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer);

   procedure Erforscht
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer);
   
   procedure AnzahlStädte
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      PlusMinusExtern : in Boolean)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer);
     
   procedure AnzahlArbeiter
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      PlusMinusExtern : in Boolean)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer);
     
   procedure AnzahlKämpfer
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      PlusMinusExtern : in Boolean)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer);
     
   procedure AnzahlSonstiges
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      PlusMinusExtern : in Boolean)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer);

end SchreibeWichtiges;
