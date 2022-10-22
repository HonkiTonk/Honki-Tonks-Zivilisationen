pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GebaeudeDatenbank;

package body LeseGebaeudeDatenbank is

   function PreisGeld
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeID)
      return ProduktionDatentypen.Produktion
   is begin
      
      return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).PreisGeld;
      
   end PreisGeld;


   
   function Produktionskosten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeID)
      return ProduktionDatentypen.Produktion
   is begin
      
      return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).Produktionskosten;
      
   end Produktionskosten;


   
   function PermanenteKosten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeID;
      WelcheKostenExtern : in ProduktionDatentypen.Permanente_Kosten_Verwendet_Enum)
      return ProduktionDatentypen.Stadtproduktion
   is begin
      
      return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).PermanenteKosten (WelcheKostenExtern);
      
   end PermanenteKosten;


      
   function Anforderungen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeID)
      return ForschungenDatentypen.ForschungIDNichtMöglich
   is begin
      
      return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).Anforderungen;
      
   end Anforderungen;
   
   
   
   function WirtschaftBonus
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeID;
      WWirtschaftBonusExtern : in ProduktionDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Feldproduktion
   is begin
      
      return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).BonusWirtschaft (WWirtschaftBonusExtern);
      
   end WirtschaftBonus;
   
   
   
   function KampfBonus
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeID;
      KampfBonusExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.Kampfwerte
   is begin
      
      return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).BonusKampf (KampfBonusExtern);
      
   end KampfBonus;


      
   function GrundBenötigt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeID)
      return KartengrundDatentypen.Kartengrund_Enum
   is begin
      
      return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).GrundBenötigt;
      
   end GrundBenötigt;



   function FlussBenötigt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeID)
      return Boolean
   is begin
      
      return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).FlussBenötigt;
      
   end FlussBenötigt;


      
   function RessourceBenötigt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeID)
      return KartengrundDatentypen.Kartenressourcen_Enum
   is begin
      
      return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).RessourceBenötigt;
      
   end RessourceBenötigt;
   
   
   
   function VerbesserungBenötigt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeID)
      return KartenverbesserungDatentypen.Karten_Verbesserung_Enum
   is begin
     
      return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).VerbesserungBenötigt;
     
   end VerbesserungBenötigt;
     
     
     
   function GebäudeBenötigt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeID)
      return StadtDatentypen.GebäudeIDMitNullwert
   is begin
      
      return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).GebäudeBenötigt;
      
   end GebäudeBenötigt;
   
   
   
   function FalscheEbene
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeID;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden)
      return Boolean
   is begin
      
      return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).EbeneBenötigt (EbeneExtern);
      
   end FalscheEbene;


   
   function GebäudeSpezielleEigenschaft
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeID)
      return StadtDatentypen.Gebäude_Spezielle_Eigenschaften_Enum
   is begin
      
      return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).SpezielleEigenschaft;
      
   end GebäudeSpezielleEigenschaft;

end LeseGebaeudeDatenbank;
