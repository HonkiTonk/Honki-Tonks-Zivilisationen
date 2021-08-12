pragma SPARK_Mode (On);

with GlobaleDatentypen;

package DatenbankRecords is

   -- EinheitenDatenbank
   type PassierbarkeitArray is array (GlobaleDatentypen.Passierbarkeit_Vorhanden_Enum'Range) of Boolean;

   type EinheitenListeRecord is record
      
      EinheitenGrafik : Wide_Wide_Character;
      
      EinheitArt : GlobaleDatentypen.Einheit_Art_Enum;
      PreisGeld : GlobaleDatentypen.KostenLager;
      PreisRessourcen : GlobaleDatentypen.KostenLager;
      PermanenteKosten : GlobaleDatentypen.PermanenteKostenArray;
      Anforderungen : GlobaleDatentypen.ForschungIDMitNullWert;

      Passierbarkeit : PassierbarkeitArray;
      
      MaximaleLebenspunkte : GlobaleDatentypen.MaximaleEinheiten;
      MaximaleBewegungspunkte : Float;
      WirdVerbessertZu : GlobaleDatentypen.EinheitenIDMitNullWert;

      -- In BenötigteErfahrungspunkte umbenennen?
      Beförderungsgrenze : GlobaleDatentypen.MaximaleStädte;
      MaximalerRang : GlobaleDatentypen.MaximaleStädteMitNullWert;
      Reichweite : GlobaleDatentypen.ProduktionFeld;
      Angriff : GlobaleDatentypen.ProduktionFeld;
      Verteidigung : GlobaleDatentypen.ProduktionFeld;

      KannTransportieren : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
      KannTransportiertWerden : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
      Transportkapazität : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
      
   end record;
   
   type EinheitenListeArray is array (GlobaleDatentypen.EinheitenID'Range) of EinheitenListeRecord;
   -- EinheitenDatenbank
   
   

   -- ForschungsDatenbank
   type ForschungListeRecord is record

      PreisForschung : GlobaleDatentypen.KostenLager;
      AnforderungForschung : GlobaleDatentypen.AnforderungForschungArray;      

   end record;
   
   type ForschungListeArray is array (GlobaleDatentypen.ForschungID'Range) of ForschungListeRecord;
   -- ForschungsDatenbank


   
   -- GebaeudeDatenbank
   type GebäudeListeRecord is record
      
      GebäudeGrafik : Wide_Wide_Character;
      
      PreisGeld : GlobaleDatentypen.KostenLager;      
      PreisRessourcen : GlobaleDatentypen.KostenLager;
      PermanenteKosten : GlobaleDatentypen.PermanenteKostenArray;
      
      Anforderungen : GlobaleDatentypen.ForschungIDMitNullWert;
      
      ProduktionBonus : GlobaleDatentypen.ProduktionFeld;
      GeldBonus : GlobaleDatentypen.ProduktionFeld;
      WissenBonus : GlobaleDatentypen.ProduktionFeld;
      VerteidigungBonus : GlobaleDatentypen.ProduktionFeld;
      NahrungBonus : GlobaleDatentypen.ProduktionFeld;
      
      UmgebungBenötigt : GlobaleDatentypen.Karten_Grund_Enum;
      GebäudeSpezielleEigenschaft : GlobaleDatentypen.Gebäude_Spezielle_Eigenschaften_Enum;

   end record;
   
   type GebäudeListeArray is array (GlobaleDatentypen.GebäudeID'Range) of GebäudeListeRecord;
   -- GebaeudeDatenbank



   -- Feldwertung, Nahrung, Produktion, Geld, Wissen, Verteidigung
   type GewinnBewertungArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range, GlobaleDatentypen.Bewertung_Werte_Enum'Range) of GlobaleDatentypen.ProduktionElement;
   
   type BewertungArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range) of GlobaleDatentypen.ProduktionFeld;
   
   -- KartenDatenbank
   type KartenListeRecord is record

      KartenGrafik : Wide_Wide_Character;
      
      Passierbarkeit : PassierbarkeitArray;      
      FeldWerte : GewinnBewertungArray;
      
   end record;
   -- KartenDatenbank



   -- VerbesserungenDatenbank
   type VerbesserungListeRecord is record

      VerbesserungGrafik : Wide_Wide_Character;
      
      Passierbarkeit : PassierbarkeitArray;      
      VerbesserungWerte : GewinnBewertungArray;
      
   end record;
   -- verbesserungenDatenbank
   
   
   
   -- RassenDatenbank
   type RassenListeRecord is record
      
      Aggressivität : GlobaleDatentypen.MaximaleStädteMitNullWert;
      Expansion : GlobaleDatentypen.MaximaleStädteMitNullWert;
      Wissenschaft : GlobaleDatentypen.MaximaleStädteMitNullWert;
      Produktion : GlobaleDatentypen.MaximaleStädteMitNullWert;
      Wirtschaft : GlobaleDatentypen.MaximaleStädteMitNullWert;
      Bewirtschaftung : GlobaleDatentypen.MaximaleStädteMitNullWert;
      
      GültigeStaatsformen : GlobaleDatentypen.StaatsformenArray;
      -- Besondere Eigenschaften hinzufügen, als Enum? oder was Anderes?
      
   end record;
   -- RassenDatenbank
   
end DatenbankRecords;
