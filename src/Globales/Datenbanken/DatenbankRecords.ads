pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with StadtDatentypen;
with EinheitenDatentypen;
with KartenDatentypen;
with KartengrundDatentypen;
with RassenDatentypen;
with ForschungenDatentypen;
with ProduktionDatentypen;
with StadtRecords;
with KampfDatentypen;
with KartenverbesserungDatentypen;

package DatenbankRecords is

   -- EinheitenDatenbank
   type PassierbarkeitArray is array (EinheitenDatentypen.Passierbarkeit_Enum'Range) of Boolean;

   type EinheitenlisteRecord is record
      
      Einheitenart : EinheitenDatentypen.Einheitart_Enum;
      PreisGeld : ProduktionDatentypen.Produktion;
      Produktionskosten : ProduktionDatentypen.Lagermenge;
      PermanenteKosten : StadtRecords.PermanenteKostenArray;
      Anforderungen : ForschungenDatentypen.ForschungIDNichtMöglich;

      Passierbarkeit : PassierbarkeitArray;
      
      MaximaleLebenspunkte : EinheitenDatentypen.LebenspunkteVorhanden;
      MaximaleBewegungspunkte : EinheitenDatentypen.VorhandeneBewegungspunkte;
      VerbesserungZu : EinheitenDatentypen.EinheitenIDMitNullWert;

      Beförderungsgrenze : KampfDatentypen.ErfahrungspunkteVorhanden;
      MaximalerRang : KampfDatentypen.RangVorhanden;
      Reichweite : KampfDatentypen.Reichweite;
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

      Kosten : ProduktionDatentypen.Lagermenge;
      Anforderung : ForschungenDatentypen.AnforderungForschungArray;

   end record;
   
   type ForschungslisteArray is array (ForschungenDatentypen.ForschungID'Range) of ForschungslisteRecord;
   -- ForschungenDatenbank


   
   -- GebäudeDatenbank
   -- Die Bonus, Kosten und Kampfbereiche auf ein Enum anstelle eines Arrays umschreiben?
   type BonusWirtschaftArray is array (KartenDatentypen.Wirtschaft_Enum'Range) of ProduktionDatentypen.Feldproduktion;
   type BonusKampfArray is array (KartenDatentypen.Kampf_Enum'Range) of KampfDatentypen.Kampfwerte;
   
   type GebäudelisteRecord is record
      
      PreisGeld : ProduktionDatentypen.Lagermenge;
      Produktionskosten : ProduktionDatentypen.Lagermenge;
      PermanenteKosten : StadtRecords.PermanenteKostenArray;
      
      Anforderungen : ForschungenDatentypen.ForschungIDNichtMöglich;
      
      BonusWirtschaft : BonusWirtschaftArray;
      BonusKampf : BonusKampfArray;
      
      -- Wie könnte man da am besten eine Oder Verknüpfung einbauen? äöü
      -- Aktuell ist von jedem Enum nur eine Auswahl möglich, das später auf mehrere erweitern? äöü
      GrundBenötigt : KartengrundDatentypen.Kartengrund_Enum;
      FlussBenötigt : Boolean;
      RessourceBenötigt : KartengrundDatentypen.Kartenressourcen_Enum;
      VerbesserungBenötigt : KartenverbesserungDatentypen.Karten_Verbesserung_Enum;
      GebäudeBenötigt : StadtDatentypen.GebäudeIDMitNullwert;
      
      SpezielleEigenschaft : StadtDatentypen.Gebäude_Spezielle_Eigenschaften_Enum;

   end record;
   
   type GebäudelisteArray is array (StadtDatentypen.GebäudeID'Range) of GebäudelisteRecord;
   -- GebäudeDatenbank



   type BewertungArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of KartenDatentypen.Einzelbewertung;
   type WirtschaftArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, KartenDatentypen.Wirtschaft_Enum'Range) of ProduktionDatentypen.Einzelproduktion;
   type KampfArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, KartenDatentypen.Kampf_Enum'Range) of KampfDatentypen.KampfwerteAllgemein;
      
   -- KartengrundDatenbank
   -- Zwei seperate Records anstelle von tagged records verwenden? äöü
   type KartenlisteRecord is tagged record
            
      Bewertung : BewertungArray;
      Wirtschaft : WirtschaftArray;
      Kampf : KampfArray;
      
   end record;
   
   type KartengrundlisteRecord is new KartenlisteRecord with record
      
      Passierbarkeit : PassierbarkeitArray;
      
   end record;
   -- KartengrundDatenbank



   -- VerbesserungenWegeDatenbank
   type VerbesserungenWegeListeRecord is new KartenlisteRecord with record
                
      Passierbarkeit : PassierbarkeitArray;
      
   end record;
   -- VerbesserungenWegeDatenbank
   
   
   
   -- RassenDatenbank
   type RassenlisteRecord is record
      
      Aggressivität : StadtDatentypen.MaximaleStädteMitNullWert;
      Expansion : StadtDatentypen.MaximaleStädteMitNullWert;
      Wissenschaft : StadtDatentypen.MaximaleStädteMitNullWert;
      Produktion : StadtDatentypen.MaximaleStädteMitNullWert;
      Wirtschaft : StadtDatentypen.MaximaleStädteMitNullWert;
      Bewirtschaftung : StadtDatentypen.MaximaleStädteMitNullWert;
      
      Staatsformen : RassenDatentypen.StaatsformenArray;
      -- Besondere Eigenschaften hinzufügen, als Enum? oder was Anderes?
      
   end record;
   -- RassenDatenbank
   
end DatenbankRecords;
