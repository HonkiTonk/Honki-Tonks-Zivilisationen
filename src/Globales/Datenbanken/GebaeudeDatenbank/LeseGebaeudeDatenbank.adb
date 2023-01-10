with GebaeudeDatenbank;
with StadtKonstanten;
with ProduktionKonstanten;
with ForschungKonstanten;
with KampfKonstanten;

package body LeseGebaeudeDatenbank is

   function PreisGeld
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDMitNullwert)
      return ProduktionDatentypen.Produktion
   is begin
      
      case
        IDExtern
      is
         when StadtKonstanten.LeerGebäudeID =>
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return GebaeudeDatenbank.Gebäudeliste (SpeziesExtern, IDExtern).PreisGeld;
      end case;
      
   end PreisGeld;


   
   function Produktionskosten
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDMitNullwert)
      return ProduktionDatentypen.Produktion
   is begin
      
      case
        IDExtern
      is
         when StadtKonstanten.LeerGebäudeID =>
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return GebaeudeDatenbank.Gebäudeliste (SpeziesExtern, IDExtern).Produktionskosten;
      end case;
      
   end Produktionskosten;


   
   function PermanenteKosten
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
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
            return GebaeudeDatenbank.Gebäudeliste (SpeziesExtern, IDExtern).PermanenteKosten (WelcheKostenExtern);
      end case;
      
   end PermanenteKosten;


      
   function Anforderungen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDMitNullwert)
      return ForschungenDatentypen.ForschungIDNichtMöglich
   is begin
      
      case
        IDExtern
      is
         when StadtKonstanten.LeerGebäudeID =>
            return ForschungKonstanten.ForschungUnmöglich;
            
         when others =>
            return GebaeudeDatenbank.Gebäudeliste (SpeziesExtern, IDExtern).Anforderungen;
      end case;
      
   end Anforderungen;
   
   
   
   function WirtschaftBonus
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
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
            return GebaeudeDatenbank.Gebäudeliste (SpeziesExtern, IDExtern).BonusWirtschaft (WirtschaftBonusExtern);
      end case;
      
   end WirtschaftBonus;
   
   
   
   function KampfBonus
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
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
            return GebaeudeDatenbank.Gebäudeliste (SpeziesExtern, IDExtern).BonusKampf (KampfBonusExtern);
      end case;
      
   end KampfBonus;


      
   function BasisgrundBenötigt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDMitNullwert)
      return KartengrundDatentypen.Basisgrund_Enum
   is begin
      
      case
        IDExtern
      is
         when StadtKonstanten.LeerGebäudeID =>
            return KartengrundDatentypen.Leer_Basisgrund_Enum;
            
         when others =>
            return GebaeudeDatenbank.Gebäudeliste (SpeziesExtern, IDExtern).BasisgrundBenötigt;
      end case;
      
   end BasisgrundBenötigt;



   function FlussBenötigt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDMitNullwert)
      return Boolean
   is begin
      
      case
        IDExtern
      is
         when StadtKonstanten.LeerGebäudeID =>
            return False;
            
         when others =>
            return GebaeudeDatenbank.Gebäudeliste (SpeziesExtern, IDExtern).FlussBenötigt;
      end case;
      
   end FlussBenötigt;


      
   function RessourceBenötigt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDMitNullwert)
      return KartenextraDatentypen.Ressourcen_Enum
   is begin
      
      case
        IDExtern
      is
         when StadtKonstanten.LeerGebäudeID =>
            return KartenextraDatentypen.Leer_Ressource_Enum;
            
         when others =>
            return GebaeudeDatenbank.Gebäudeliste (SpeziesExtern, IDExtern).RessourceBenötigt;
      end case;
      
   end RessourceBenötigt;
   
   
   
   function VerbesserungBenötigt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDMitNullwert)
      return KartenverbesserungDatentypen.Karten_Verbesserung_Enum
   is begin
      
      case
        IDExtern
      is
         when StadtKonstanten.LeerGebäudeID =>
            return KartenverbesserungDatentypen.Leer_Verbesserung_Enum;
            
         when others =>
            return GebaeudeDatenbank.Gebäudeliste (SpeziesExtern, IDExtern).VerbesserungBenötigt;
      end case;
     
   end VerbesserungBenötigt;
     
     
     
   function GebäudeBenötigt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDMitNullwert)
      return StadtDatentypen.GebäudeIDMitNullwert
   is begin
      
      case
        IDExtern
      is
         when StadtKonstanten.LeerGebäudeID =>
            return StadtKonstanten.LeerGebäudeID;
            
         when others =>
            return GebaeudeDatenbank.Gebäudeliste (SpeziesExtern, IDExtern).GebäudeBenötigt;
      end case;
      
   end GebäudeBenötigt;
   
   
   
   function FalscheEbene
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
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
            return GebaeudeDatenbank.Gebäudeliste (SpeziesExtern, IDExtern).EbeneBenötigt (EbeneExtern);
      end case;
      
   end FalscheEbene;


   
   function GebäudeSpezielleEigenschaft
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDMitNullwert)
      return StadtDatentypen.Gebäude_Spezielle_Eigenschaften_Enum
   is begin
      
      case
        IDExtern
      is
         when StadtKonstanten.LeerGebäudeID =>
            return StadtDatentypen.Leer_Gebäude_Spezielle_Egienschaft_Enum;
            
         when others =>
            return GebaeudeDatenbank.Gebäudeliste (SpeziesExtern, IDExtern).SpezielleEigenschaft;
      end case;
      
   end GebäudeSpezielleEigenschaft;

end LeseGebaeudeDatenbank;
