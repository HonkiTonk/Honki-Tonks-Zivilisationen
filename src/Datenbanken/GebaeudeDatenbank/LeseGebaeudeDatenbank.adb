pragma SPARK_Mode (On);

with GebaeudeDatenbank;

package body LeseGebaeudeDatenbank is

   function GebäudeGrafik
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return Wide_Wide_Character
   is begin
      
      return GebaeudeDatenbank.GebäudeListe (RasseExtern, IDExtern).GebäudeGrafik;
      
   end GebäudeGrafik;


      
   function PreisGeld
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return EinheitStadtDatentypen.KostenLager
   is begin
      
      return GebaeudeDatenbank.GebäudeListe (RasseExtern, IDExtern).PreisGeld;
      
   end PreisGeld;


   
   function PreisRessourcen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return EinheitStadtDatentypen.KostenLager
   is begin
      
      return GebaeudeDatenbank.GebäudeListe (RasseExtern, IDExtern).PreisRessourcen;
      
   end PreisRessourcen;


   
   function PermanenteKosten
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.GebäudeID;
      WelcheKostenExtern : in EinheitStadtDatentypen.Permanente_Kosten_Verwendet_Enum)
      return EinheitStadtDatentypen.GesamtePermanenteKosten
   is begin
      
      return GebaeudeDatenbank.GebäudeListe (RasseExtern, IDExtern).PermanenteKosten (WelcheKostenExtern);
      
   end PermanenteKosten;


      
   function Anforderungen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return EinheitStadtDatentypen.ForschungIDMitNullWert
   is begin
      
      return GebaeudeDatenbank.GebäudeListe (RasseExtern, IDExtern).Anforderungen;
      
   end Anforderungen;


      
   function PermanenterBonus
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.GebäudeID;
      WelcherBonusExtern : in KartenDatentypen.Bonus_Werte_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      return GebaeudeDatenbank.GebäudeListe (RasseExtern, IDExtern).PermanenterBonus (WelcherBonusExtern);
      
   end PermanenterBonus;


      
   function UmgebungBenötigt
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return KartenDatentypen.Karten_Grund_Enum
   is begin
      
      return GebaeudeDatenbank.GebäudeListe (RasseExtern, IDExtern).UmgebungBenötigt;
      
   end UmgebungBenötigt;


   
   function GebäudeSpezielleEigenschaft
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return EinheitStadtDatentypen.Gebäude_Spezielle_Eigenschaften_Enum
   is begin
      
      return GebaeudeDatenbank.GebäudeListe (RasseExtern, IDExtern).GebäudeSpezielleEigenschaft;
      
   end GebäudeSpezielleEigenschaft;



   function GanzerEintrag
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return DatenbankRecords.GebäudeListeRecord
   is begin

      return GebaeudeDatenbank.GebäudeListe (RasseExtern, IDExtern);

   end GanzerEintrag;

end LeseGebaeudeDatenbank;
