pragma SPARK_Mode (On);

with GebaeudeDatenbank;

package body LeseGebaeudeDatenbank is

   function GebäudeGrafik
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return Wide_Wide_Character
   is begin
      
      return GebaeudeDatenbank.GebäudeListe (RasseExtern, IDExtern).GebäudeGrafik;
      
   end GebäudeGrafik;


      
   function PreisGeld
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return GlobaleDatentypen.KostenLager
   is begin
      
      return GebaeudeDatenbank.GebäudeListe (RasseExtern, IDExtern).PreisGeld;
      
   end PreisGeld;


   
   function PreisRessourcen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return GlobaleDatentypen.KostenLager
   is begin
      
      return GebaeudeDatenbank.GebäudeListe (RasseExtern, IDExtern).PreisRessourcen;
      
   end PreisRessourcen;


   
   function PermanenteKosten
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.GebäudeID;
      WelcheKostenExtern : in GlobaleDatentypen.Permanente_Kosten_Verwendet_Enum)
      return GlobaleDatentypen.GesamtePermanenteKosten
   is begin
      
      return GebaeudeDatenbank.GebäudeListe (RasseExtern, IDExtern).PermanenteKosten (WelcheKostenExtern);
      
   end PermanenteKosten;


      
   function Anforderungen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return GlobaleDatentypen.ForschungIDMitNullWert
   is begin
      
      return GebaeudeDatenbank.GebäudeListe (RasseExtern, IDExtern).Anforderungen;
      
   end Anforderungen;


      
   function PermanenterBonus
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.GebäudeID;
      WelcherBonusExtern : in GlobaleDatentypen.Bonus_Werte_Enum)
      return GlobaleDatentypen.ProduktionFeld
   is begin
      
      return GebaeudeDatenbank.GebäudeListe (RasseExtern, IDExtern).PermanenterBonus (WelcherBonusExtern);
      
   end PermanenterBonus;


      
   function UmgebungBenötigt
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return GlobaleDatentypen.Karten_Grund_Enum
   is begin
      
      return GebaeudeDatenbank.GebäudeListe (RasseExtern, IDExtern).UmgebungBenötigt;
      
   end UmgebungBenötigt;


   
   function GebäudeSpezielleEigenschaft
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return GlobaleDatentypen.Gebäude_Spezielle_Eigenschaften_Enum
   is begin
      
      return GebaeudeDatenbank.GebäudeListe (RasseExtern, IDExtern).GebäudeSpezielleEigenschaft;
      
   end GebäudeSpezielleEigenschaft;



   function GanzerEintrag
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return DatenbankRecords.GebäudeListeRecord
   is begin

      return GebaeudeDatenbank.GebäudeListe (RasseExtern, IDExtern);

   end GanzerEintrag;

end LeseGebaeudeDatenbank;
