pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GebaeudeDatenbank;

package body LeseGebaeudeDatenbank is

   function PreisGeld
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeID)
      return ProduktionDatentypen.KostenLager
   is begin
      
      return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).PreisGeld;
      
   end PreisGeld;


   
   function PreisRessourcen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeID)
      return ProduktionDatentypen.KostenLager
   is begin
      
      return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).PreisRessourcen;
      
   end PreisRessourcen;


   
   function PermanenteKosten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeID;
      WelcheKostenExtern : in ProduktionDatentypen.Permanente_Kosten_Verwendet_Enum)
      return ProduktionDatentypen.GesamtePermanenteKosten
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
      WWirtschaftBonusExtern : in KartenDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Feldproduktion
   is begin
      
      return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).BonusWirtschaft (WWirtschaftBonusExtern);
      
   end WirtschaftBonus;
   
   
   
   function KampfBonus
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeID;
      KampfBonusExtern : in KartenDatentypen.Kampf_Enum)
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


   
   function GebäudeSpezielleEigenschaft
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeID)
      return StadtDatentypen.Gebäude_Spezielle_Eigenschaften_Enum
   is begin
      
      return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).GebäudeSpezielleEigenschaft;
      
   end GebäudeSpezielleEigenschaft;

end LeseGebaeudeDatenbank;
