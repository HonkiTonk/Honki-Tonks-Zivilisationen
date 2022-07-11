pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with RassenDatentypen;
with StadtDatentypen;
with EinheitenDatentypen;
with ProduktionDatentypen;
with KartenDatentypen;
with KartenRecords;
with KartenVerbesserungDatentypen;

with KIDatentypen;

package StadtRecords is

   type RasseStadtnummerRecord is record
      
      Rasse : RassenDatentypen.Rassen_Enum;
      Nummer : StadtDatentypen.MaximaleStädteMitNullWert;
      
   end record;
   
   
   
   type BauprojektRecord is record
      
      Gebäude : StadtDatentypen.GebäudeIDMitNullwert;
      Einheit : EinheitenDatentypen.EinheitenIDMitNullWert;

   end record;
   
   
   
   ------------------------ XXX
   type GebäudeRecord is record
      
      Vorhanden : Boolean;
      InvestierteRessourcen : ProduktionDatentypen.Produktion;
      
   end record;



   type EinwohnerArbeiterArray is array (1 .. 2) of ProduktionDatentypen.Einwohner;
   
   ------------------------ XXX
   ------------------------ Wenn ich ein Record für das Array hier anlege, dann könnten darin die bereits erzeugten Ressourcen gespeichert werden und beim Wechsel des Bauprojekts blieben die angefangenen Gebäude erhalten.
   ------------------------ Ginge auch bei Einheiten, ist da aber vielleicht nicht so sinnvoll.
   type GebäudeVorhandenArray is array (StadtDatentypen.GebäudeID'Range) of Boolean;
   type StadtMeldungenArray is array (StadtDatentypen.Stadt_Meldung_Art_Enum'Range) of StadtDatentypen.Stadt_Meldung_Enum;
   type UmgebungBewirtschaftungArray is array (KartenDatentypen.UmgebungsbereichDrei'Range, KartenDatentypen.UmgebungsbereichDrei'Range) of Boolean;
   type PermanenteKostenArray is array (ProduktionDatentypen.Permanente_Kosten_Verwendet_Enum'Range) of ProduktionDatentypen.Stadtproduktion;

   type StadtGebautRecord is record
      
      ID : KartenVerbesserungDatentypen.Karten_Verbesserung_Stadt_ID_Enum;
      KoordinatenAktuell : KartenRecords.AchsenKartenfeldNaturalRecord;
      EinwohnerArbeiter : EinwohnerArbeiterArray;
      
      Nahrungsmittel : ProduktionDatentypen.StadtLagermenge;
      Nahrungsproduktion : ProduktionDatentypen.Stadtproduktion;
      Ressourcen : ProduktionDatentypen.StadtLagermenge;
      Produktionrate : ProduktionDatentypen.Stadtproduktion;
      Geldgewinnung : ProduktionDatentypen.Stadtproduktion;
      PermanenteKostenPosten : PermanenteKostenArray;
      
      Forschungsrate : ProduktionDatentypen.Stadtproduktion;
      Bauprojekt : BauprojektRecord;
      Bauzeit : ProduktionDatentypen.Produktion;

      Korruption : ProduktionDatentypen.Stadtproduktion;
      Zufriedenheit : ProduktionDatentypen.Feldproduktion;
      GebäudeVorhanden : GebäudeVorhandenArray;
      Name : Unbounded_Wide_Wide_String;

      UmgebungBewirtschaftung : UmgebungBewirtschaftungArray;
      UmgebungGröße : KartenDatentypen.UmgebungsbereichDrei;
      
      Meldungen : StadtMeldungenArray;
      
      KIBeschäftigung : KIDatentypen.Stadt_Aufgabe_Enum;
      
   end record;

end StadtRecords;
