pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GebaeudeDatenbank;

package body LeseGebaeudeDatenbank is

   function PreisGeld
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return EinheitStadtDatentypen.KostenLager
   is begin
      
      return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).PreisGeld;
      
   end PreisGeld;


   
   function PreisRessourcen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return EinheitStadtDatentypen.KostenLager
   is begin
      
      return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).PreisRessourcen;
      
   end PreisRessourcen;


   
   function PermanenteKosten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.GebäudeID;
      WelcheKostenExtern : in EinheitStadtDatentypen.Permanente_Kosten_Verwendet_Enum)
      return EinheitStadtDatentypen.GesamtePermanenteKosten
   is begin
      
      return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).PermanenteKosten (WelcheKostenExtern);
      
   end PermanenteKosten;


      
   function Anforderungen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return EinheitStadtDatentypen.ForschungIDNichtMöglich
   is begin
      
      return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).Anforderungen;
      
   end Anforderungen;
   
   
   
   function WirtschaftBonus
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.GebäudeID;
      WWirtschaftBonusExtern : in KartenDatentypen.Wirtschaft_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).BonusWirtschaft (WWirtschaftBonusExtern);
      
   end WirtschaftBonus;
   
   
   
   function KampfBonus
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.GebäudeID;
      KampfBonusExtern : in KartenDatentypen.Kampf_Enum)
      return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).BonusKampf (KampfBonusExtern);
      
   end KampfBonus;


      
   function GrundBenötigt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return KartengrundDatentypen.Kartengrund_Enum
   is begin
      
      return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).GrundBenötigt;
      
   end GrundBenötigt;



   function FlussBenötigt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return Boolean
   is begin
      
      return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).FlussBenötigt;
      
   end FlussBenötigt;


      
   function RessourceBenötigt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return KartengrundDatentypen.Karten_Ressourcen_Enum
   is begin
      
      return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).RessourceBenötigt;
      
   end RessourceBenötigt;


   
   function GebäudeSpezielleEigenschaft
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return EinheitStadtDatentypen.Gebäude_Spezielle_Eigenschaften_Enum
   is begin
      
      return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern).GebäudeSpezielleEigenschaft;
      
   end GebäudeSpezielleEigenschaft;



   function GanzerEintrag
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return DatenbankRecords.GebäudelisteRecord
   is begin

      return GebaeudeDatenbank.Gebäudeliste (RasseExtern, IDExtern);

   end GanzerEintrag;

end LeseGebaeudeDatenbank;
