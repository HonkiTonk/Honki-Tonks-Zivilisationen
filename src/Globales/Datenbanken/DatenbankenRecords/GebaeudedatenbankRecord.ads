with KartenDatentypen;
with ProduktionDatentypen;
with ForschungenDatentypen;
with KartengrundDatentypen;
with KartenverbesserungDatentypen;
with StadtDatentypen;
with KampfDatentypen;
with StadtRecords;
with KartenextraDatentypen;
with StadtArrays;

-- Wenn ich die Array als Record mit zwei Booleans gestalte,
-- dann könnte ich einen Boolean verwenden um zu Prüfen ob das jeweilige Objekt zum Bau benötigt wird und den zweite Boolean ob es sich um ein UND oder ein ODER handelt. äöü
-- Alle Objekte mit UND müssen dann vorhanden sein und alle mit ODER müssen nur eines davon da sein. äöü
package GebaeudedatenbankRecord is
   pragma Preelaborate;
   
   type NotwendigkeitRecord is record
      
      Notwendig : Boolean;
      UndOder : Boolean;
      
   end record;

   -- Die Bonus, Kosten und Kampfbereiche auf ein Enum anstelle eines Arrays umschreiben? äöü
   -- Dann passt das aber auch nicht mehr einfach in eine Schleife. äöü
   type BonusWirtschaftArray is array (ProduktionDatentypen.Wirtschaft_Enum'Range) of ProduktionDatentypen.Feldproduktion;
   type BonusKampfArray is array (KampfDatentypen.Kampf_Enum'Range) of KampfDatentypen.KampfwerteAllgemein;
   
   -- Was ist überhaupt mit Zusatzgrund? äöü
   -- Um das alles da rein zu basteln müsste man aber die Gebäudeumgebungsprüfung noch einmal deutlich überarbeiten. äöü
   -- Könnte man theoretisch um das vernichtete Feld kürzen, aber ob sich das lohnt? äöü
   -- Wenn ich Leer mit reinnehme könnte ich daran prüfen ob überhaupt eines gebraucht wird und entsprechend die Prüfung verkürzen? Ist das sinnvoll? äöü
   type BasisgrundArray is array (KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Range) of Boolean;
   type ZusatzgrundArray is array (KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Range) of Boolean;
   
   -- Das erlaubt eine Beschränung auf eine Flussart, aber nicht eine Notwendigkeit für mehrere Flussstück, später mal überarbeiten. äöü
   type FlussArray is array (KartenextraDatentypen.Fluss_Vorhanden_Enum'Range) of Boolean;
   type RessourcenArray is array (KartenextraDatentypen.Ressourcen_Vorhanden_Enum'Range) of Boolean;
   type VerbesserungenArray is array (KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum'Range) of Boolean;
   type WegeArray is array (KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Range) of Boolean;
   
   
   -- Bei der Ebene reicht immer ein ODER, da eine Stadt sich ja niemals auf zwei Ebenen gleichzeitig befinden kann!
   type EbenenArray is array (KartenDatentypen.EbeneVorhanden'Range) of Boolean;
   
   -- Es gibt auch noch keine Änderungen für Korruption, Zufriedenheit, Verschmutzung, usw.. äöü
   -- Städte haben generell noch keine Verschmutzungswerte weil Verschmutzung erst relativ neu ist. äöü
   type GebäudelisteRecord is record
      
      PreisGeld : ProduktionDatentypen.Lagermenge;
      Produktionskosten : ProduktionDatentypen.Lagermenge;
      PermanenteKosten : StadtRecords.PermanenteKostenArray;
      
      Anforderungen : ForschungenDatentypen.ForschungIDNichtMöglich;
      
      BonusWirtschaft : BonusWirtschaftArray;
      BonusKampf : BonusKampfArray;
      
      GebäudeBenötigt : StadtArrays.GebäudeArray;
      
      EbeneBenötigt : EbenenArray;
      BasisgrundBenötigt : BasisgrundArray;
      ZusatzgrundBenötigt : ZusatzgrundArray;
      
      FlussBenötigt : FlussArray;
      RessourceBenötigt : RessourcenArray;
      VerbesserungBenötigt : VerbesserungenArray;
      WegBenötigt : WegeArray;
      
      -- Spezielle Eigenschaft durch Koruptionsreduktion ersetzen und spezielle Eigenschaften stattdessen in Speziesspezifische Wunder einbauen? äöü
      SpezielleEigenschaft : StadtDatentypen.Gebäude_Spezielle_Eigenschaften_Enum;

   end record;
   
   type GebäudelisteArray is array (StadtDatentypen.GebäudeID'Range) of GebäudelisteRecord;

end GebaeudedatenbankRecord;
