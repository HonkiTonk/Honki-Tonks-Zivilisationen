pragma SPARK_Mode (On);

with SystemDatentypen;
with EinheitStadtRecords;
with EinheitStadtDatentypen;
with KartenDatentypen;

package DatenbankRecords is

   -- EinheitenDatenbank
   type PassierbarkeitArray is array (EinheitStadtDatentypen.Passierbarkeit_Vorhanden_Enum'Range) of Boolean;

   type EinheitenListeRecord is record
      
      EinheitenGrafik : Wide_Wide_Character;
      
      EinheitArt : EinheitStadtDatentypen.Einheit_Art_Enum;
      PreisGeld : EinheitStadtDatentypen.KostenLager;
      PreisRessourcen : EinheitStadtDatentypen.KostenLager;
      PermanenteKosten : EinheitStadtRecords.PermanenteKostenArray;
      Anforderungen : EinheitStadtDatentypen.ForschungIDMitNullWert;

      Passierbarkeit : PassierbarkeitArray;
      
      MaximaleLebenspunkte : EinheitStadtDatentypen.MaximaleEinheiten;
      MaximaleBewegungspunkte : EinheitStadtDatentypen.BewegungFloat;
      WirdVerbessertZu : EinheitStadtDatentypen.EinheitenIDMitNullWert;

      Beförderungsgrenze : EinheitStadtDatentypen.MaximaleStädte;
      MaximalerRang : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      Reichweite : EinheitStadtDatentypen.ProduktionFeld;
      Angriff : EinheitStadtDatentypen.ProduktionFeld;
      Verteidigung : EinheitStadtDatentypen.ProduktionFeld;

      KannTransportieren : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      KannTransportiertWerden : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      Transportkapazität : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      
   end record;
   
   type EinheitenListeArray is array (EinheitStadtDatentypen.EinheitenID'Range) of EinheitenListeRecord;
   -- EinheitenDatenbank
   
   

   -- ForschungsDatenbank
   type ForschungListeRecord is record

      PreisForschung : EinheitStadtDatentypen.KostenLager;
      AnforderungForschung : EinheitStadtDatentypen.AnforderungForschungArray;

   end record;
   
   type ForschungListeArray is array (EinheitStadtDatentypen.ForschungID'Range) of ForschungListeRecord;
   -- ForschungsDatenbank


   
   -- GebaeudeDatenbank
   type PermanenterBonusArray is array (KartenDatentypen.Bonus_Werte_Enum'Range) of EinheitStadtDatentypen.ProduktionFeld;
   
   type GebäudeListeRecord is record
      
      GebäudeGrafik : Wide_Wide_Character;
      
      PreisGeld : EinheitStadtDatentypen.KostenLager;
      PreisRessourcen : EinheitStadtDatentypen.KostenLager;
      PermanenteKosten : EinheitStadtRecords.PermanenteKostenArray;
      
      Anforderungen : EinheitStadtDatentypen.ForschungIDMitNullWert;
      
      PermanenterBonus : PermanenterBonusArray;
      
      UmgebungBenötigt : KartenDatentypen.Karten_Grund_Enum;
      GebäudeSpezielleEigenschaft : EinheitStadtDatentypen.Gebäude_Spezielle_Eigenschaften_Enum;

   end record;
   
   type GebäudeListeArray is array (EinheitStadtDatentypen.GebäudeID'Range) of GebäudeListeRecord;
   -- GebaeudeDatenbank



   -- Feldwertung, Nahrung, Produktion, Geld, Wissen, Verteidigung, Angriff
   type GewinnBewertungArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range, KartenDatentypen.Bewertung_Werte_Enum'Range) of EinheitStadtDatentypen.ProduktionElement;
   
   type BewertungArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range) of EinheitStadtDatentypen.ProduktionFeld;
   
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
   -- VerbesserungenDatenbank
   
   
   
   -- RassenDatenbank
   type RassenListeRecord is record
      
      Aggressivität : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      Expansion : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      Wissenschaft : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      Produktion : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      Wirtschaft : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      Bewirtschaftung : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      
      GültigeStaatsformen : SystemDatentypen.StaatsformenArray;
      -- Besondere Eigenschaften hinzufügen, als Enum? oder was Anderes?
      
   end record;
   -- RassenDatenbank
   
end DatenbankRecords;
