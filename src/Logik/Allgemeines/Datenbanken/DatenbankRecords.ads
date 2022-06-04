pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;
with StadtDatentypen;
with EinheitenDatentypen;
with KartenDatentypen;
with KartengrundDatentypen;
with RassenDatentypen;
with ForschungenDatentypen;
with ProduktionDatentypen;
with StadtRecords;
with KampfDatentypen;

package DatenbankRecords is

   -- EinheitenDatenbank
   type PassierbarkeitArray is array (EinheitenDatentypen.Passierbarkeit_Vorhanden_Enum'Range) of Boolean;

   type EinheitenlisteRecord is record
      
      ----------------------- Solche Benennungen auch mal anpassen.
      EinheitArt : EinheitenDatentypen.Einheit_Art_Enum;
      PreisGeld : ProduktionDatentypen.KostenLager;
      PreisRessourcen : ProduktionDatentypen.KostenLager;
      PermanenteKosten : StadtRecords.PermanenteKostenArray;
      Anforderungen : ForschungenDatentypen.ForschungIDNichtMöglich;

      Passierbarkeit : PassierbarkeitArray;
      
      MaximaleLebenspunkte : EinheitenDatentypen.LebenspunkteVorhanden;
      MaximaleBewegungspunkte : EinheitenDatentypen.VorhandeneBewegungspunkte;
      WirdVerbessertZu : EinheitenDatentypen.EinheitenIDMitNullWert;

      Beförderungsgrenze : KampfDatentypen.Kampfwerte;
      MaximalerRang : KampfDatentypen.Kampfwerte;
      Reichweite : KampfDatentypen.Kampfwerte;
      Angriff : KampfDatentypen.Kampfwerte;
      Verteidigung : KampfDatentypen.Kampfwerte;

      KannTransportieren : EinheitenDatentypen.Transport_Enum;
      KannTransportiertWerden : EinheitenDatentypen.Transport_Enum;
      Transportkapazität : EinheitenDatentypen.Transportplätze;
      
   end record;
   
   type EinheitenlisteArray is array (EinheitenDatentypen.EinheitenID'Range) of EinheitenlisteRecord;
   -- EinheitenDatenbank
   
   

   -- ForschungenDatenbank
   type ForschungslisteRecord is record

      PreisForschung : ProduktionDatentypen.KostenLager;
      AnforderungForschung : ForschungenDatentypen.AnforderungForschungArray;

   end record;
   
   type ForschungslisteArray is array (ForschungenDatentypen.ForschungID'Range) of ForschungslisteRecord;
   -- ForschungenDatenbank


   
   -- GebäudeDatenbank
   type BonusWirtschaftArray is array (KartenDatentypen.Wirtschaft_Enum'Range) of ProduktionDatentypen.ProduktionFeld;
   type BonusKampfArray is array (KartenDatentypen.Kampf_Enum'Range) of KampfDatentypen.Kampfwerte;
   
   type GebäudelisteRecord is record
      
      PreisGeld : ProduktionDatentypen.KostenLager;
      PreisRessourcen : ProduktionDatentypen.KostenLager;
      PermanenteKosten : StadtRecords.PermanenteKostenArray;
      
      Anforderungen : ForschungenDatentypen.ForschungIDNichtMöglich;
      
      BonusWirtschaft : BonusWirtschaftArray;
      BonusKampf : BonusKampfArray;
      
      GrundBenötigt : KartengrundDatentypen.Kartengrund_Enum;
      FlussBenötigt : Boolean;
      RessourceBenötigt : KartengrundDatentypen.Kartenressourcen_Enum;
      --------------------- UndOderGrundFlussBenötigt : Boolean; -- In ein Enum einbauen?
      --------------------- Auch noch Abhängigkeit von anderen Gebäuden einbauen.
      
      GebäudeSpezielleEigenschaft : StadtDatentypen.Gebäude_Spezielle_Eigenschaften_Enum;

   end record;
   
   type GebäudelisteArray is array (StadtDatentypen.GebäudeID'Range) of GebäudelisteRecord;
   -- GebäudeDatenbank



   type BewertungArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of KartenDatentypen.BewertungFeld;
   type WirtschaftArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, KartenDatentypen.Wirtschaft_Enum'Range) of ProduktionDatentypen.ProduktionElement;
   type KampfArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, KartenDatentypen.Kampf_Enum'Range) of KampfDatentypen.KampfwerteAllgemein;
      
   -- KartengrundDatenbank
   type KartenlisteRecord is tagged record
            
      Bewertung : BewertungArray;
      Wirtschaft : WirtschaftArray;
      Kampf : KampfArray;
      
   end record;
   
   type KartengrundlisteRecord is new KartenlisteRecord with record
      
      Passierbarkeit : PassierbarkeitArray;
      
   end record;
   -- KartengrundDatenbank



   -- VerbesserungenDatenbank
   type VerbesserungenWegeListeRecord is new KartenlisteRecord with record
      
     -- Bewertung : BewertungArray;
     -- Wirtschaft : WirtschaftArray;
     -- Kampf : KampfArray;
      
      Passierbarkeit : PassierbarkeitArray;
      
   end record;
   
   -- type VerbesserungenListeRecord is new WegeListeRecord with record
                 
   --    Passierbarkeit : PassierbarkeitArray;
      
   -- end record;
   -- VerbesserungenDatenbank
   
   
   
   -- RassenDatenbank
   type RassenListeRecord is record
      
      Aggressivität : StadtDatentypen.MaximaleStädteMitNullWert;
      Expansion : StadtDatentypen.MaximaleStädteMitNullWert;
      Wissenschaft : StadtDatentypen.MaximaleStädteMitNullWert;
      Produktion : StadtDatentypen.MaximaleStädteMitNullWert;
      Wirtschaft : StadtDatentypen.MaximaleStädteMitNullWert;
      Bewirtschaftung : StadtDatentypen.MaximaleStädteMitNullWert;
      
      GültigeStaatsformen : SystemDatentypen.StaatsformenArray;
      -- Besondere Eigenschaften hinzufügen, als Enum? oder was Anderes?
      
   end record;
   -- RassenDatenbank
   
end DatenbankRecords;
