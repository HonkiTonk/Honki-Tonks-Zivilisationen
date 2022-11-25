with GebaeudeDatenbank;
with StadtKonstanten;
with ProduktionKonstanten;
with ForschungKonstanten;
with KampfKonstanten;

package body LeseGebaeudeDatenbank is

   function PreisGeld
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDMitNullwert)
      return ProduktionDatentypen.Produktion
   is begin
      
      case
        IDExtern
      is
         when StadtKonstanten.LeerGebäudeID =>
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).PreisGeld;
      end case;
      
   end PreisGeld;


   
   function Produktionskosten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDMitNullwert)
      return ProduktionDatentypen.Produktion
   is begin
      
      case
        IDExtern
      is
         when StadtKonstanten.LeerGebäudeID =>
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).Produktionskosten;
      end case;
      
   end Produktionskosten;


   
   function PermanenteKosten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      WelcheKostenExtern : in ProduktionDatentypen.Permanente_Kosten_Verwendet_Enum)
      return ProduktionDatentypen.Stadtproduktion
   is begin
      
      case
        IDExtern
      is
         when StadtKonstanten.LeerGebäudeID =>
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).PermanenteKosten (WelcheKostenExtern);
      end case;
      
   end PermanenteKosten;


      
   function Anforderungen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDMitNullwert)
      return ForschungenDatentypen.ForschungIDNichtMöglich
   is begin
      
      case
        IDExtern
      is
         when StadtKonstanten.LeerGebäudeID =>
            return ForschungKonstanten.ForschungUnmöglich;
            
         when others =>
            return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).Anforderungen;
      end case;
      
   end Anforderungen;
   
   
   
   function WirtschaftBonus
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      WirtschaftBonusExtern : in ProduktionDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Feldproduktion
   is begin
      
      case
        IDExtern
      is
         when StadtKonstanten.LeerGebäudeID =>
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).BonusWirtschaft (WirtschaftBonusExtern);
      end case;
      
   end WirtschaftBonus;
   
   
   
   function KampfBonus
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      KampfBonusExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteEinheiten
   is begin
      
      case
        IDExtern
      is
         when StadtKonstanten.LeerGebäudeID =>
            return KampfKonstanten.LeerKampfwert;
            
         when others =>
            return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).BonusKampf (KampfBonusExtern);
      end case;
      
   end KampfBonus;


      
   function BasisgrundBenötigt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDMitNullwert)
      return KartengrundDatentypen.Basisgrund_Enum
   is begin
      
      case
        IDExtern
      is
         when StadtKonstanten.LeerGebäudeID =>
            return KartengrundDatentypen.Leer_Basisgrund_Enum;
            
         when others =>
            return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).BasisgrundBenötigt;
      end case;
      
   end BasisgrundBenötigt;



   function FlussBenötigt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDMitNullwert)
      return Boolean
   is begin
      
      case
        IDExtern
      is
         when StadtKonstanten.LeerGebäudeID =>
            return False;
            
         when others =>
            return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).FlussBenötigt;
      end case;
      
   end FlussBenötigt;


      
   function RessourceBenötigt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDMitNullwert)
      return KartenextraDatentypen.Ressourcen_Enum
   is begin
      
      case
        IDExtern
      is
         when StadtKonstanten.LeerGebäudeID =>
            return KartenextraDatentypen.Leer_Ressource_Enum;
            
         when others =>
            return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).RessourceBenötigt;
      end case;
      
   end RessourceBenötigt;
   
   
   
   function VerbesserungBenötigt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDMitNullwert)
      return KartenverbesserungDatentypen.Karten_Verbesserung_Enum
   is begin
      
      case
        IDExtern
      is
         when StadtKonstanten.LeerGebäudeID =>
            return KartenverbesserungDatentypen.Leer_Verbesserung_Enum;
            
         when others =>
            return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).VerbesserungBenötigt;
      end case;
     
   end VerbesserungBenötigt;
     
     
     
   function GebäudeBenötigt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDMitNullwert)
      return StadtDatentypen.GebäudeIDMitNullwert
   is begin
      
      case
        IDExtern
      is
         when StadtKonstanten.LeerGebäudeID =>
            return StadtKonstanten.LeerGebäudeID;
            
         when others =>
            return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).GebäudeBenötigt;
      end case;
      
   end GebäudeBenötigt;
   
   
   
   function FalscheEbene
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden)
      return Boolean
   is begin
      
      case
        IDExtern
      is
         when StadtKonstanten.LeerGebäudeID =>
            return False;
            
         when others =>
            return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).EbeneBenötigt (EbeneExtern);
      end case;
      
   end FalscheEbene;


   
   function GebäudeSpezielleEigenschaft
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDMitNullwert)
      return StadtDatentypen.Gebäude_Spezielle_Eigenschaften_Enum
   is begin
      
      case
        IDExtern
      is
         when StadtKonstanten.LeerGebäudeID =>
            return StadtDatentypen.Leer_Gebäude_Spezielle_Egienschaft_Enum;
            
         when others =>
            return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).SpezielleEigenschaft;
      end case;
      
   end GebäudeSpezielleEigenschaft;

end LeseGebaeudeDatenbank;
