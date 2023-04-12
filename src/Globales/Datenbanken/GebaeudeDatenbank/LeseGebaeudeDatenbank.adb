with GebaeudeDatenbank;
with StadtKonstanten;
with ProduktionKonstanten;
with ForschungKonstanten;
with KampfKonstanten;

-- Aufgrund der Änderungen in der gebäudedatenbank hier eventuell noch einmal die leeren Rückgabewerte überprüfen. äöü
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
      IDExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum)
      return Boolean
   is begin
      
      case
        IDExtern
      is
         when StadtKonstanten.LeerGebäudeID =>
            return False;
            
         when others =>
            return GebaeudeDatenbank.Gebäudeliste (SpeziesExtern, IDExtern).BasisgrundBenötigt (GrundExtern);
      end case;
      
   end BasisgrundBenötigt;
   
   
   
   function ZusatzgrundBenötigt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      GrundExtern : in KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum)
      return Boolean
   is begin
      
      case
        IDExtern
      is
         when StadtKonstanten.LeerGebäudeID =>
            return False;
            
         when others =>
            return GebaeudeDatenbank.Gebäudeliste (SpeziesExtern, IDExtern).ZusatzgrundBenötigt (GrundExtern);
      end case;
      
   end ZusatzgrundBenötigt;



   function FlussBenötigt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      FlussartExtern : in KartenextraDatentypen.Fluss_Vorhanden_Enum)
      return Boolean
   is begin
      
      case
        IDExtern
      is
         when StadtKonstanten.LeerGebäudeID =>
            return False;
            
         when others =>
            return GebaeudeDatenbank.Gebäudeliste (SpeziesExtern, IDExtern).FlussBenötigt (FlussartExtern);
      end case;
      
   end FlussBenötigt;


      
   function RessourceBenötigt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Vorhanden_Enum)
      return Boolean
   is begin
      
      case
        IDExtern
      is
         when StadtKonstanten.LeerGebäudeID =>
            return False;
            
         when others =>
            return GebaeudeDatenbank.Gebäudeliste (SpeziesExtern, IDExtern).RessourceBenötigt (RessourceExtern);
      end case;
      
   end RessourceBenötigt;
   
   
   
   function VerbesserungBenötigt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum)
      return Boolean
   is begin
      
      case
        IDExtern
      is
         when StadtKonstanten.LeerGebäudeID =>
            return False;
            
         when others =>
            return GebaeudeDatenbank.Gebäudeliste (SpeziesExtern, IDExtern).VerbesserungBenötigt (VerbesserungExtern);
      end case;
     
   end VerbesserungBenötigt;
   
   
   
   function WegBenötigt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      WegExtern : in KartenverbesserungDatentypen.Weg_Vorhanden_Enum)
      return Boolean
   is begin
      
      case
        IDExtern
      is
         when StadtKonstanten.LeerGebäudeID =>
            return False;
            
         when others =>
            return GebaeudeDatenbank.Gebäudeliste (SpeziesExtern, IDExtern).WegBenötigt (WegExtern);
      end case;
      
   end WegBenötigt;
     
     
     
   function GebäudeBenötigt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      WelchesGebäudeExtern : in StadtDatentypen.GebäudeID)
      return Boolean
   is begin
      
      case
        IDExtern
      is
         when StadtKonstanten.LeerGebäudeID =>
            return False;
            
         when others =>
            return GebaeudeDatenbank.Gebäudeliste (SpeziesExtern, IDExtern).GebäudeBenötigt (WelchesGebäudeExtern);
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
