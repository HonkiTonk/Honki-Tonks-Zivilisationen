pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with VerbesserungenDatenbank;

package body LeseVerbesserungenDatenbank is
      
   function PassierbarkeitWeg
     (WegExtern : in KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum;
      WelcheUmgebungExtern : in EinheitenDatentypen.Passierbarkeit_Vorhanden_Enum)
      return Boolean
   is begin
      
      return VerbesserungenDatenbank.Wegeliste (WegExtern).Passierbarkeit (WelcheUmgebungExtern);
      
   end PassierbarkeitWeg;
   
   
   
   function BewertungVerbesserung
     (VerbesserungExtern : in KartenverbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.Einzelbewertung
   is begin
      
      return VerbesserungenDatenbank.Verbesserungenliste (VerbesserungExtern).Bewertung (RasseExtern);
      
   end BewertungVerbesserung;
   
   
   
   function BewertungWeg
     (WegExtern : in KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.Einzelbewertung
   is begin
      
      return VerbesserungenDatenbank.Wegeliste (WegExtern).Bewertung (RasseExtern);
      
   end BewertungWeg;
   
      
   
   function WirtschaftVerbesserung
     (VerbesserungExtern : in KartenverbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in KartenDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      return VerbesserungenDatenbank.Verbesserungenliste (VerbesserungExtern).Wirtschaft (RasseExtern, WelcherWertExtern);
      
   end WirtschaftVerbesserung;
   
      
   
   function WirtschaftWeg
     (WegExtern : in KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in KartenDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      return VerbesserungenDatenbank.Wegeliste (WegExtern).Wirtschaft (RasseExtern, WelcherWertExtern);
      
   end WirtschaftWeg;
   
      
   
   function KampfVerbesserung
     (VerbesserungExtern : in KartenverbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in KartenDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteAllgemein
   is begin
      
      return VerbesserungenDatenbank.Verbesserungenliste (VerbesserungExtern).Kampf (RasseExtern, WelcherWertExtern);
      
   end KampfVerbesserung;
   
      
   
   function KampfWeg
     (WegExtern : in KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in KartenDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteAllgemein
   is begin
      
      return VerbesserungenDatenbank.Wegeliste (WegExtern).Kampf (RasseExtern, WelcherWertExtern);
      
   end KampfWeg;

end LeseVerbesserungenDatenbank;
