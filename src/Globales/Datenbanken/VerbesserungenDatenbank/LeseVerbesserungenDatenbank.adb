with VerbesserungenDatenbank;

package body LeseVerbesserungenDatenbank is
      
   function PassierbarkeitWeg
     (WegExtern : in KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum;
      WelcheUmgebungExtern : in EinheitenDatentypen.Passierbarkeit_Enum)
      return Boolean
   is begin
      
      return VerbesserungenDatenbank.Wegeliste (WegExtern).Passierbarkeit (WelcheUmgebungExtern);
      
   end PassierbarkeitWeg;
   
      
   
   function WirtschaftVerbesserung
     (VerbesserungExtern : in KartenverbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in ProduktionDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      return VerbesserungenDatenbank.Verbesserungenliste (VerbesserungExtern).Wirtschaft (RasseExtern, WelcherWertExtern);
      
   end WirtschaftVerbesserung;
   
      
   
   function WirtschaftWeg
     (WegExtern : in KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in ProduktionDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      return VerbesserungenDatenbank.Wegeliste (WegExtern).Wirtschaft (RasseExtern, WelcherWertExtern);
      
   end WirtschaftWeg;
   
      
   
   function KampfVerbesserung
     (VerbesserungExtern : in KartenverbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteAllgemein
   is begin
      
      return VerbesserungenDatenbank.Verbesserungenliste (VerbesserungExtern).Kampf (RasseExtern, WelcherWertExtern);
      
   end KampfVerbesserung;
   
      
   
   function KampfWeg
     (WegExtern : in KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteAllgemein
   is begin
      
      return VerbesserungenDatenbank.Wegeliste (WegExtern).Kampf (RasseExtern, WelcherWertExtern);
      
   end KampfWeg;

end LeseVerbesserungenDatenbank;
