pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleDatentypen;
  
with KIDatentypen;

package GlobaleRecords is
   
   type AchsenStadtfeldRecord is record
      
      YAchse : GlobaleDatentypen.Stadtfeld;
      XAchse : GlobaleDatentypen.Stadtfeld;
      
   end record;
   
   
   
   type AchsenKartenfeldPositivRecord is tagged record
      
      EAchse : GlobaleDatentypen.EbeneVorhanden;
      YAchse : GlobaleDatentypen.KartenfeldPositivMitNullwert;
      XAchse : GlobaleDatentypen.KartenfeldPositivMitNullwert;
      
   end record;
   
   

   type AchsenKartenfeldRecord is record
      
      EAchse : GlobaleDatentypen.Ebene;
      YAchse : GlobaleDatentypen.Kartenfeld;
      XAchse : GlobaleDatentypen.Kartenfeld;
      
   end record;
   
   

   type RassePlatznummerRecord is tagged record
      
      Rasse : GlobaleDatentypen.Rassen_Enum;
      Platznummer : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
      
   end record;
   

   
   type CursorRecord is record
      
      CursorGrafik : Wide_Wide_Character;
      Position : AchsenKartenfeldPositivRecord;
      PositionAlt : AchsenKartenfeldPositivRecord;
      PositionStadt : AchsenStadtfeldRecord;
      
   end record;
   
   
   
   type GrenzenRecord is record
      
      Städtegrenze : GlobaleDatentypen.MaximaleStädte;
      Einheitengrenze : GlobaleDatentypen.MaximaleEinheiten;
      Geldgrenze : Integer;
      Forschungsgrenze : GlobaleDatentypen.KostenLager;
      Geldgewinngrenze : GlobaleDatentypen.KostenLager;
      ForschungGewinngrenze : GlobaleDatentypen.KostenLager;
      RassenRundengrenze : Natural;
      
   end record;



   type KIBewegungPlanArray is array (GlobaleDatentypen.Stadtfeld'Range) of GlobaleRecords.AchsenKartenfeldPositivRecord;
   type TransporterArray is array (GlobaleDatentypen.MaximaleEinheiten'First .. 5) of GlobaleDatentypen.MaximaleEinheitenMitNullWert;
   type EinheitMeldungenArray is array (GlobaleDatentypen.Einheit_Meldung_Art_Enum'Range) of GlobaleDatentypen.Einheit_Meldung_Enum;

   type EinheitenGebautRecord is record
      
      ID : GlobaleDatentypen.EinheitenIDMitNullWert;
      Position : AchsenKartenfeldPositivRecord;
      Heimatstadt : GlobaleDatentypen.MaximaleStädteMitNullWert;
      
      Lebenspunkte : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
      Bewegungspunkte : Float;
      Erfahrungspunkte : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
      Rang : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
      
      Beschäftigung : GlobaleDatentypen.Tastenbelegung_Enum;
      BeschäftigungNachfolger : GlobaleDatentypen.Tastenbelegung_Enum;
      
      Beschäftigungszeit : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
      BeschäftigungszeitNachfolger : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
      
      KIZielKoordinaten : AchsenKartenfeldPositivRecord;
      KIBeschäftigt : KIDatentypen.Einheit_Aufgabe_Enum;
      KIBewegungPlan : KIBewegungPlanArray;
      
      Transportiert : TransporterArray;
      WirdTransportiert : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
      
      Meldungen : EinheitMeldungenArray;
      
   end record;
   
   type KampfwerteRecord is record
      
      Angriff : GlobaleDatentypen.ProduktionFeld;
      Verteidigung : GlobaleDatentypen.ProduktionFeld;
      
   end record;



   type EinwohnerArbeiterArray is array (1 .. 2) of GlobaleDatentypen.ProduktionFeld;
   type GebäudeVorhandenArray is array (GlobaleDatentypen.GebäudeID'Range) of Boolean;
   type StadtMeldungenArray is array (GlobaleDatentypen.Stadt_Meldung_Art_Enum'Range) of GlobaleDatentypen.Stadt_Meldung_Enum;

   type StadtGebautRecord is record
      
      ID : GlobaleDatentypen.Karten_Verbesserung_Stadt_ID_Enum;
      Position : AchsenKartenfeldPositivRecord;
      EinwohnerArbeiter : EinwohnerArbeiterArray;
      
      Nahrungsmittel : GlobaleDatentypen.GesamtproduktionStadt;
      Nahrungsproduktion : GlobaleDatentypen.GesamtproduktionStadt;
      Ressourcen : GlobaleDatentypen.KostenLager;
      Produktionrate : GlobaleDatentypen.GesamtproduktionStadt;
      Geldgewinnung : GlobaleDatentypen.GesamtproduktionStadt;
      PermanenteKostenPosten : GlobaleDatentypen.PermanenteKostenArray;
      
      Forschungsrate : GlobaleDatentypen.GesamtproduktionStadt;
      Bauprojekt : Natural;
      Bauzeit : GlobaleDatentypen.KostenLager;

      Korruption : GlobaleDatentypen.GesamtproduktionStadt;
      GebäudeVorhanden : GebäudeVorhandenArray;
      Name : Unbounded_Wide_Wide_String;

      UmgebungBewirtschaftung : GlobaleDatentypen.UmgebungBewirtschaftungArray;
      UmgebungGröße : GlobaleDatentypen.LoopRangeMinusDreiZuDrei;
      
      Meldungen : StadtMeldungenArray;
      
      KIBeschäftigung : KIDatentypen.Stadt_Aufgabe_Enum;
      
   end record;



   type WichtigesRecord is record
      
      Geldmenge : Integer;
      GeldZugewinnProRunde : GlobaleDatentypen.KostenLager;

      GesamteForschungsrate : GlobaleDatentypen.KostenLager;
      Forschungsmenge : GlobaleDatentypen.KostenLager;
      VerbleibendeForschungszeit : GlobaleDatentypen.KostenLager;
      Forschungsprojekt : GlobaleDatentypen.ForschungIDMitNullWert;

      Erforscht : GlobaleDatentypen.ErforschtArray;
      
   end record;
   
   
   
   type DiplomatieRecord is record
      
      AktuellerZustand : GlobaleDatentypen.Status_Untereinander_Enum;
      AktuelleSympathieBewertung : GlobaleDatentypen.ProduktionFeld;
      ZeitSeitLetzterÄnderung : Natural;
      
   end record;
   
   
   
   type FelderwertungArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range) of GlobaleDatentypen.GesamtproduktionStadt;
   
   type KartenRecord is record

      Grund : GlobaleDatentypen.Karten_Grund_Enum;
      Hügel : Boolean;
      Sichtbar : GlobaleDatentypen.SichtbarkeitArray;
      
      Fluss : GlobaleDatentypen.Karten_Grund_Enum;
      VerbesserungWeg : GlobaleDatentypen.Karten_Verbesserung_Enum;
      VerbesserungGebiet : GlobaleDatentypen.Karten_Verbesserung_Enum;
      Ressource : GlobaleDatentypen.Karten_Grund_Enum;
      
      DurchStadtBelegterGrund : GlobaleDatentypen.BelegterGrund;
      Felderwertung : FelderwertungArray;

   end record;
   
   
   
   type NutzerEinstellungenRecord is record
      
      Sprache : Unbounded_Wide_Wide_String;
      AnzahlAutosave : Natural;
      RundenBisAutosave : Positive;
      
   end record;

end GlobaleRecords;
