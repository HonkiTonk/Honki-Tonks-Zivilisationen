pragma SPARK_Mode (On);

package body LeseGebaeudeDatenbank is

   function GebäudeGrafik
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return Wide_Wide_Character;
      
   function PreisGeld
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return GlobaleDatentypen.KostenLager;      
   function PreisRessourcen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return GlobaleDatentypen.KostenLager;
   function PermanenteKosten
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return GlobaleDatentypen.PermanenteKostenArray;
      
   function Anforderungen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return GlobaleDatentypen.ForschungIDMitNullWert;
      
   function ProduktionBonus
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return GlobaleDatentypen.ProduktionFeld;
   function GeldBonus
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return GlobaleDatentypen.ProduktionFeld;
   function WissenBonus
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return GlobaleDatentypen.ProduktionFeld;
   function VerteidigungBonus
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return GlobaleDatentypen.ProduktionFeld;
   function NahrungBonus
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return GlobaleDatentypen.ProduktionFeld;
   function AngriffBonus
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return GlobaleDatentypen.ProduktionFeld;
      
   function UmgebungBenötigt
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return GlobaleDatentypen.Karten_Grund_Enum;
   function GebäudeSpezielleEigenschaft
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return GlobaleDatentypen.Gebäude_Spezielle_Eigenschaften_Enum;

end LeseGebaeudeDatenbank;
