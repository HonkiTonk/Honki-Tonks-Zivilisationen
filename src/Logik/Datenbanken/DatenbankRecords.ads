pragma SPARK_Mode (On);

with SystemDatentypen;
with EinheitStadtRecords;
with EinheitStadtDatentypen;
with KartenDatentypen;

package DatenbankRecords is

   -- EinheitenDatenbank
   type PassierbarkeitArray is array (EinheitStadtDatentypen.Passierbarkeit_Vorhanden_Enum'Range) of Boolean;

   type EinheitenListeRecord is record
      
      EinheitArt : EinheitStadtDatentypen.Einheit_Art_Enum;
      PreisGeld : EinheitStadtDatentypen.KostenLager;
      PreisRessourcen : EinheitStadtDatentypen.KostenLager;
      PermanenteKosten : EinheitStadtRecords.PermanenteKostenArray;
      Anforderungen : EinheitStadtDatentypen.ForschungIDNichtMöglich;

      Passierbarkeit : PassierbarkeitArray;
      
      MaximaleLebenspunkte : EinheitStadtDatentypen.LebenspunkteVorhanden;
      MaximaleBewegungspunkte : EinheitStadtDatentypen.VorhandeneBewegungspunkte;
      WirdVerbessertZu : EinheitStadtDatentypen.EinheitenIDMitNullWert;

      Beförderungsgrenze : EinheitStadtDatentypen.Kampfwerte;
      MaximalerRang : EinheitStadtDatentypen.Kampfwerte;
      Reichweite : EinheitStadtDatentypen.Kampfwerte;
      Angriff : EinheitStadtDatentypen.Kampfwerte;
      Verteidigung : EinheitStadtDatentypen.Kampfwerte;

      KannTransportieren : EinheitStadtDatentypen.Transportwerte;
      KannTransportiertWerden : EinheitStadtDatentypen.Transportwerte;
      Transportkapazität : EinheitStadtDatentypen.Transportwerte;
      
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


   
   -- GebäudeDatenbank
   type BonusWirtschaftArray is array (KartenDatentypen.Wirtschaft_Enum'Range) of EinheitStadtDatentypen.ProduktionFeld;
   type BonusKampfArray is array (KartenDatentypen.Kampf_Enum'Range) of EinheitStadtDatentypen.Kampfwerte;
   
   type GebäudeListeRecord is record
      
      PreisGeld : EinheitStadtDatentypen.KostenLager;
      PreisRessourcen : EinheitStadtDatentypen.KostenLager;
      PermanenteKosten : EinheitStadtRecords.PermanenteKostenArray;
      
      Anforderungen : EinheitStadtDatentypen.ForschungIDNichtMöglich;
      
      BonusWirtschaft : BonusWirtschaftArray;
      BonusKampf : BonusKampfArray;
      
      UmgebungBenötigt : KartenDatentypen.Karten_Grund_Enum;
      GebäudeSpezielleEigenschaft : EinheitStadtDatentypen.Gebäude_Spezielle_Eigenschaften_Enum;

   end record;
   
   type GebäudeListeArray is array (EinheitStadtDatentypen.GebäudeID'Range) of GebäudeListeRecord;
   -- GebäudeDatenbank



   type BewertungArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range) of KartenDatentypen.BewertungFeld;
   type WirtschaftArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range, KartenDatentypen.Wirtschaft_Enum'Range) of EinheitStadtDatentypen.ProduktionElement;
   type KampfArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range, KartenDatentypen.Kampf_Enum'Range) of EinheitStadtDatentypen.KampfwerteAllgemein;
      
   -- KartenDatenbank
   type KartenListeRecord is record
      
      Passierbarkeit : PassierbarkeitArray;
      
      Bewertung : BewertungArray;
      Wirtschaft : WirtschaftArray;
      Kampf : KampfArray;
      
   end record;
   -- KartenDatenbank



   -- VerbesserungenDatenbank
   type VerbesserungListeRecord is record
      
      Passierbarkeit : PassierbarkeitArray;
      
      Bewertung : BewertungArray;
      Wirtschaft : WirtschaftArray;
      Kampf : KampfArray;
      
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
