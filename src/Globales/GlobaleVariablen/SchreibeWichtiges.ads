pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with EinheitStadtDatentypen;
with SystemKonstanten;

package SchreibeWichtiges is

   procedure Geldmenge
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      GeldZugewinnExtern : in Integer;
      RechnenSetzenExtern : in Boolean)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante);
   
   procedure GeldZugewinnProRunde
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      GeldZugewinnExtern : in EinheitStadtDatentypen.GesamtproduktionStadt;
      RechnenSetzenExtern : in Boolean)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante);
   
   procedure GesamteForschungsrate
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      ForschungsrateZugewinnExtern : in EinheitStadtDatentypen.GesamtproduktionStadt;
      RechnenSetzenExtern : in Boolean)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante);
   
   procedure Forschungsmenge
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      ForschungZugewinnExtern : in EinheitStadtDatentypen.KostenLager;
      RechnenSetzenExtern : in Boolean)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante);
   
   procedure VerbleibendeForschungszeit
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante);
   
   procedure Forschungsprojekt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      ForschungIDExtern : in EinheitStadtDatentypen.ForschungIDMitNullWert)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante);

   procedure Erforscht
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante);
   
   procedure AnzahlStädte
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      PlusMinusExtern : in Boolean)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante);
     
   procedure AnzahlArbeiter
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      PlusMinusExtern : in Boolean)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante);
     
   procedure AnzahlKämpfer
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      PlusMinusExtern : in Boolean)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante);
     
   procedure AnzahlSonstiges
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      PlusMinusExtern : in Boolean)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante);

end SchreibeWichtiges;
