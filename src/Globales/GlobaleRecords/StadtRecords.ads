with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SpeziesDatentypen;
with StadtDatentypen;
with EinheitenDatentypen;
with ProduktionDatentypen;
with KartenDatentypen;
with KartenRecords;
with KartenverbesserungDatentypen;
with StadtArrays;

with KIDatentypen;

package StadtRecords is
   pragma Preelaborate;

   type SpeziesStadtnummerRecord is record
      
      Spezies : SpeziesDatentypen.Spezies_Enum;
      Nummer : StadtDatentypen.MaximaleStädteMitNullWert;
      
   end record;
   
   
   
   type BauprojektRecord is record
      
      Gebäude : StadtDatentypen.GebäudeIDMitNullwert;
      Einheit : EinheitenDatentypen.EinheitenIDMitNullWert;

   end record;
   
   
   
   -- XXX äöü
   type GebäudeRecord is record
      
      Vorhanden : Boolean;
      InvestierteRessourcen : ProduktionDatentypen.Produktion;
      
   end record;



   -- Warum ist das hier nicht Boolean'Range? äöü
   -- Oder ein eigenes Enum? äöü
   type EinwohnerArbeiterArray is array (1 .. 2) of ProduktionDatentypen.Einwohner;
   
   -- XXX äöü
   -- Wenn ich ein Record für das Array hier anlege, dann könnten darin die bereits erzeugten Ressourcen gespeichert werden und beim Wechsel des Bauprojekts blieben die angefangenen Gebäude erhalten. äöü
   -- Ginge auch bei Einheiten, ist da aber vielleicht nicht so sinnvoll. äöü
   type StadtMeldungenArray is array (StadtDatentypen.Stadt_Meldung_Art_Enum'Range) of StadtDatentypen.Stadt_Meldung_Enum;
   type UmgebungBewirtschaftungArray is array (KartenDatentypen.UmgebungsbereichDrei'Range, KartenDatentypen.UmgebungsbereichDrei'Range) of Boolean;
   type PermanenteKostenArray is array (ProduktionDatentypen.Permanente_Kosten_Verwendet_Enum'Range) of ProduktionDatentypen.Stadtproduktion;
   type WegeverbindungArray is array (StadtDatentypen.MaximaleStädte'Range) of Boolean;

   -- Es gibt noch keine Werte für Verschmutzung, weil das noch relativ neu ist. äöü
   -- Sollte man in Städte nur Verschmutzung haben oder sie wie bei den Waffen/Feldeffekten aufteilen? äöü
   type StadtGebautRecord is record
      
      ID : KartenverbesserungDatentypen.Verbesserung_Stadt_ID_Enum;
      KoordinatenAktuell : KartenRecords.AchsenKartenfeldNaturalRecord;
      EinwohnerArbeiter : EinwohnerArbeiterArray;
      
      Nahrungsmittel : ProduktionDatentypen.Stadtproduktion;
      Nahrungsproduktion : ProduktionDatentypen.Stadtproduktion;
      Material : ProduktionDatentypen.StadtLagermenge;
      Produktionrate : ProduktionDatentypen.Stadtproduktion;
      Geldgewinnung : ProduktionDatentypen.Stadtproduktion;
      PermanenteKostenPosten : PermanenteKostenArray;
      
      Forschungsrate : ProduktionDatentypen.Stadtproduktion;
      Bauprojekt : BauprojektRecord;
      Bauzeit : ProduktionDatentypen.Produktion;

      Korruption : ProduktionDatentypen.Stadtproduktion;
      Zufriedenheit : ProduktionDatentypen.Feldproduktion;
      GebäudeVorhanden : StadtArrays.GebäudeArray;
      Name : Unbounded_Wide_Wide_String;

      UmgebungBewirtschaftung : UmgebungBewirtschaftungArray;
      UmgebungGröße : KartenDatentypen.UmgebungsbereichDrei;
      
      Meldungen : StadtMeldungenArray;
      
      KIBeschäftigung : KIDatentypen.Stadt_Aufgabe_Enum;
      
   end record;

end StadtRecords;
