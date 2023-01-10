with KartenDatentypen;
with ProduktionDatentypen;
with ForschungenDatentypen;
with KartengrundDatentypen;
with KartenverbesserungDatentypen;
with StadtDatentypen;
with KampfDatentypen;
with StadtRecords;
with KartenextraDatentypen;

package GebaeudedatenbankRecord is
   pragma Preelaborate;

   -- Die Bonus, Kosten und Kampfbereiche auf ein Enum anstelle eines Arrays umschreiben? äöü
   -- Dann passt das aber auch nicht mehr einfach in eine Schleife. äöü
   type BonusWirtschaftArray is array (ProduktionDatentypen.Wirtschaft_Enum'Range) of ProduktionDatentypen.Feldproduktion;
   type BonusKampfArray is array (KampfDatentypen.Kampf_Enum'Range) of KampfDatentypen.KampfwerteAllgemein;
   
   -- Um das alles da rein zu basteln müsste man aber die Gebäudeumgebungsprüfung noch einmal deutlich überarbeiten. äöü
   -- Könnte man theoretisch um das vernichtete Feld kürzen, aber ob sich das lohnt? äöü
   -- Wenn ich Leer mit reinnehme könnte ich daran prüfen ob überhaupt eines gebraucht wird und entsprechend die Prüfung verkürzen? Ist das sinnvoll? äöü
   type GrundArray is array (KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Range) of Boolean;
   type FlussArray is array (KartenextraDatentypen.Fluss_Vorhanden_Enum'Range) of Boolean;
   type RessourcenArray is array (KartenextraDatentypen.Ressourcen_Vorhanden_Enum'Range) of Boolean;
   type VerbesserungenArray is array (KartenverbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum'Range) of Boolean;
   
   -- Da müsste man dann immer darauf achten dass das Gebäude sich nicht selbst benötigt, oder Gebäude benötigt die dieses Gebäude zum Bau benötigt. äöü
   type GebäudeArray is array (StadtDatentypen.GebäudeID'Range) of Boolean;
   type EbenenArray is array (KartenDatentypen.EbeneVorhanden'Range) of Boolean;
   
   type GebäudelisteRecord is record
      
      PreisGeld : ProduktionDatentypen.Lagermenge;
      Produktionskosten : ProduktionDatentypen.Lagermenge;
      PermanenteKosten : StadtRecords.PermanenteKostenArray;
      
      Anforderungen : ForschungenDatentypen.ForschungIDNichtMöglich;
      
      BonusWirtschaft : BonusWirtschaftArray;
      BonusKampf : BonusKampfArray;
      
      BasisgrundBenötigt : KartengrundDatentypen.Basisgrund_Enum;
      FlussBenötigt : Boolean;
      RessourceBenötigt : KartenextraDatentypen.Ressourcen_Enum;
      VerbesserungBenötigt : KartenverbesserungDatentypen.Karten_Verbesserung_Enum;
      GebäudeBenötigt : StadtDatentypen.GebäudeIDMitNullwert;
      
      -- Das hier vielleicht noch einmal umbenennen und auch entsprechend die Funktion in der LeseGebäudedatenbank anpassen? äöü
      -- Wäre vielleicht eine sinnvollere Benennung. äöü
      EbeneBenötigt : EbenenArray;
      
      -- Spezielle Eigenschaft durch Koruptionsreduktion ersetzen und spezielle Eigenschaften stattdessen in Speziesspezifische Wunder einbauen? äöü
      SpezielleEigenschaft : StadtDatentypen.Gebäude_Spezielle_Eigenschaften_Enum;

   end record;
   
   type GebäudelisteArray is array (StadtDatentypen.GebäudeID'Range) of GebäudelisteRecord;

end GebaeudedatenbankRecord;
