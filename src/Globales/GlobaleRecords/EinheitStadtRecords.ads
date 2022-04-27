pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with KartenRecords;
with EinheitStadtDatentypen;
with KartenDatentypen;
with KartenVerbesserungDatentypen;
with AufgabenDatentypen;
with RassenDatentypen;

with KIDatentypen;

package EinheitStadtRecords is

   type RassePlatznummerRecord is tagged record
      
      Rasse : RassenDatentypen.Rassen_Enum;
      Platznummer : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
      
   end record;
   
   
   
   type KIBewegungPlanArray is array (KartenDatentypen.Stadtfeld'Range) of KartenRecords.AchsenKartenfeldPositivRecord;
   type TransporterArray is array (EinheitStadtDatentypen.TransportplätzeVorhanden'Range) of EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
   type EinheitMeldungenArray is array (EinheitStadtDatentypen.Einheit_Meldung_Art_Enum'Range) of EinheitStadtDatentypen.Einheit_Meldung_Enum;

   type EinheitenGebautRecord is record
      
      ID : EinheitStadtDatentypen.EinheitenIDMitNullWert;
      KoordinatenAktuell : KartenRecords.AchsenKartenfeldPositivRecord;
      Heimatstadt : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      
      Lebenspunkte : EinheitStadtDatentypen.Lebenspunkte;
      Bewegungspunkte : EinheitStadtDatentypen.VorhandeneBewegungspunkte;
      Erfahrungspunkte : EinheitStadtDatentypen.Kampfwerte;
      Rang : EinheitStadtDatentypen.Kampfwerte;
      
      Beschäftigung : AufgabenDatentypen.Einheiten_Aufgaben_Enum;
      BeschäftigungNachfolger : AufgabenDatentypen.Einheiten_Aufgaben_Enum;
      
      -- Besseren Datentypen für die Beschäftigungszeit einbauen? Z. B. für Arbeiten die niemals fertig werden?
      Beschäftigungszeit : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      BeschäftigungszeitNachfolger : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      
      KIZielKoordinaten : KartenRecords.AchsenKartenfeldPositivRecord;
      KIBeschäftigt : KIDatentypen.Einheit_Aufgabe_Enum;
      KIBewegungPlan : KIBewegungPlanArray;
      
      Transportiert : TransporterArray;
      WirdTransportiert : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
      
      Meldungen : EinheitMeldungenArray;
      
   end record;
   
   
   
   type KampfwerteRecord is record
      
      Angriff : EinheitStadtDatentypen.Kampfwerte;
      Verteidigung : EinheitStadtDatentypen.Kampfwerte;
      
   end record;
   
   
   
   type BauprojektRecord is record

      GebäudeEinheit : Boolean;
      Nummer : EinheitStadtDatentypen.MinimimMaximumID;

   end record;
   
   
   
   type GebäudeRecord is record -- XXX
      
      Vorhanden : Boolean;
      InvestierteRessourcen : EinheitStadtDatentypen.KostenLager;
      
   end record;



   type EinwohnerArbeiterArray is array (1 .. 2) of EinheitStadtDatentypen.ProduktionFeld;
   
   -- Wenn ich ein Record für das Array hier anlege, dann könnten darin die bereits erzeugten Ressourcen gespeichert werden und beim Wechsel des Bauprojekts blieben die angefangenen Gebäude erhalten. XXX
   -- Ginge auch bei Einheiten, ist da aber vielleicht nicht so sinnvoll.
   type GebäudeVorhandenArray is array (EinheitStadtDatentypen.GebäudeID'Range) of Boolean;
   type StadtMeldungenArray is array (EinheitStadtDatentypen.Stadt_Meldung_Art_Enum'Range) of EinheitStadtDatentypen.Stadt_Meldung_Enum;
   type UmgebungBewirtschaftungArray is array (KartenDatentypen.UmgebungsbereichDrei'Range, KartenDatentypen.UmgebungsbereichDrei'Range) of Boolean;
   type PermanenteKostenArray is array (EinheitStadtDatentypen.Permanente_Kosten_Verwendet_Enum'Range) of EinheitStadtDatentypen.GesamtePermanenteKosten;

   type StadtGebautRecord is record
      
      ID : KartenVerbesserungDatentypen.Karten_Verbesserung_Stadt_ID_Enum;
      KoordinatenAktuell : KartenRecords.AchsenKartenfeldPositivRecord;
      EinwohnerArbeiter : EinwohnerArbeiterArray;
      
      Nahrungsmittel : EinheitStadtDatentypen.GesamtproduktionStadt;
      Nahrungsproduktion : EinheitStadtDatentypen.GesamtproduktionStadt;
      Ressourcen : EinheitStadtDatentypen.KostenLager;
      Produktionrate : EinheitStadtDatentypen.GesamtproduktionStadt;
      Geldgewinnung : EinheitStadtDatentypen.GesamtproduktionStadt;
      PermanenteKostenPosten : PermanenteKostenArray;
      
      Forschungsrate : EinheitStadtDatentypen.GesamtproduktionStadt;
      Bauprojekt : BauprojektRecord;
      Bauzeit : EinheitStadtDatentypen.KostenLager;

      Korruption : EinheitStadtDatentypen.GesamtproduktionStadt;
      Zufriedenheit : EinheitStadtDatentypen.ProduktionFeld;
      GebäudeVorhanden : GebäudeVorhandenArray;
      Name : Unbounded_Wide_Wide_String;

      UmgebungBewirtschaftung : UmgebungBewirtschaftungArray;
      UmgebungGröße : KartenDatentypen.UmgebungsbereichDrei;
      
      Meldungen : StadtMeldungenArray;
      
      KIBeschäftigung : KIDatentypen.Stadt_Aufgabe_Enum;
      
   end record;

end EinheitStadtRecords;
