pragma SPARK_Mode (On);

with GebaeudeDatenbank;

package body LeseGebaeudeDatenbank is

   function GebäudeGrafik
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return Wide_Wide_Character
   is begin
      
      return GebaeudeDatenbank.GebäudeListe (RasseExtern, IDExtern).GebäudeGrafik;
      
   end GebäudeGrafik;


      
   function PreisGeld
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return EinheitStadtDatentypen.KostenLager
   is begin
      
      return GebaeudeDatenbank.GebäudeListe (RasseExtern, IDExtern).PreisGeld;
      
   end PreisGeld;


   
   function PreisRessourcen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return EinheitStadtDatentypen.KostenLager
   is begin
      
      return GebaeudeDatenbank.GebäudeListe (RasseExtern, IDExtern).PreisRessourcen;
      
   end PreisRessourcen;


   
   function PermanenteKosten
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.GebäudeID;
      WelcheKostenExtern : in EinheitStadtDatentypen.Permanente_Kosten_Verwendet_Enum)
      return EinheitStadtDatentypen.GesamtePermanenteKosten
   is begin
      
      return GebaeudeDatenbank.GebäudeListe (RasseExtern, IDExtern).PermanenteKosten (WelcheKostenExtern);
      
   end PermanenteKosten;


      
   function Anforderungen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return EinheitStadtDatentypen.ForschungIDNichtMöglich
   is begin
      
      return GebaeudeDatenbank.GebäudeListe (RasseExtern, IDExtern).Anforderungen;
      
   end Anforderungen;
   
   
   
   function WirtschaftBonus
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.GebäudeID;
      WWirtschaftBonusExtern : in KartenDatentypen.Wirtschaft_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      return GebaeudeDatenbank.GebäudeListe (RasseExtern, IDExtern).BonusWirtschaft (WWirtschaftBonusExtern);
      
   end WirtschaftBonus;
   
   
   
   function KampfBonus
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.GebäudeID;
      KampfBonusExtern : in KartenDatentypen.Kampf_Enum)
      return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      return GebaeudeDatenbank.GebäudeListe (RasseExtern, IDExtern).BonusKampf (KampfBonusExtern);
      
   end KampfBonus;


      
   function UmgebungBenötigt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return KartenDatentypen.Karten_Grund_Enum
   is begin
      
      return GebaeudeDatenbank.GebäudeListe (RasseExtern, IDExtern).UmgebungBenötigt;
      
   end UmgebungBenötigt;


   
   function GebäudeSpezielleEigenschaft
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return EinheitStadtDatentypen.Gebäude_Spezielle_Eigenschaften_Enum
   is begin
      
      return GebaeudeDatenbank.GebäudeListe (RasseExtern, IDExtern).GebäudeSpezielleEigenschaft;
      
   end GebäudeSpezielleEigenschaft;



   function GanzerEintrag
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return DatenbankRecords.GebäudeListeRecord
   is begin

      return GebaeudeDatenbank.GebäudeListe (RasseExtern, IDExtern);

   end GanzerEintrag;

end LeseGebaeudeDatenbank;
