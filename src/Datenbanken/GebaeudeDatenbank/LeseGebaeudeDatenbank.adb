pragma SPARK_Mode (On);

package body LeseGebaeudeDatenbank is

   GebäudeGrafik : Wide_Wide_Character;
      
   PreisGeld : GlobaleDatentypen.KostenLager;      
   PreisRessourcen : GlobaleDatentypen.KostenLager;
   PermanenteKosten : GlobaleDatentypen.PermanenteKostenArray;
      
   Anforderungen : GlobaleDatentypen.ForschungIDMitNullWert;
      
   -- Eventuell auch hier das GewinnBewertungArray nutzen und die Bewertung für die Baupriorität der KI verwenden?
   ProduktionBonus : GlobaleDatentypen.ProduktionFeld;
   GeldBonus : GlobaleDatentypen.ProduktionFeld;
   WissenBonus : GlobaleDatentypen.ProduktionFeld;
   VerteidigungBonus : GlobaleDatentypen.ProduktionFeld;
   NahrungBonus : GlobaleDatentypen.ProduktionFeld;
   AngriffBonus : GlobaleDatentypen.ProduktionFeld;
      
   UmgebungBenötigt : GlobaleDatentypen.Karten_Grund_Enum;
   GebäudeSpezielleEigenschaft : GlobaleDatentypen.Gebäude_Spezielle_Eigenschaften_Enum;

end LeseGebaeudeDatenbank;
