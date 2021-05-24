pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleDatentypen, KIDatentypen;

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

   type AchsenKartenfeldPositivErfolgreichRecord is new AchsenKartenfeldPositivRecord with record
      
      Erfolgreich : Boolean;
      
   end record;
   
   

   type AchsenKartenfeldRecord is record
      
      EAchse : GlobaleDatentypen.Ebene;
      YAchse : GlobaleDatentypen.Kartenfeld;
      XAchse : GlobaleDatentypen.Kartenfeld;
      
   end record;
   
   

   type RassePlatznummerRecord is tagged record
      
      Rasse : GlobaleDatentypen.RassenMitNullwert;
      Platznummer : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
      
   end record;

   type RassePlatznummerIDRecord is new RassePlatznummerRecord with record
      
      ID : GlobaleDatentypen.EinheitenIDMitNullWert;

   end record;
   

   
   type CursorRecord is record
      
      CursorGrafik : Wide_Wide_Character;
      AchsenPosition : AchsenKartenfeldPositivRecord;
      AchsenPositionAlt : AchsenKartenfeldPositivRecord;
      AchsenPositionStadt : AchsenStadtfeldRecord;
      
   end record;



   type TransporterArray is array (1 .. 5) of GlobaleDatentypen.MaximaleEinheitenMitNullWert;
   type KIBewegungPlanArray is array (0 .. 10) of GlobaleRecords.AchsenKartenfeldPositivRecord;

   type EinheitenGebautRecord is record
      
      ID : GlobaleDatentypen.EinheitenIDMitNullWert;
      AchsenPosition : AchsenKartenfeldPositivRecord;
      
      AktuelleLebenspunkte : Integer;
      AktuelleBewegungspunkte : Float;
      AktuelleErfahrungspunkte : Natural;
      AktuellerRang : Natural;
      
      -- Befehle_Enum siehe GlobaleDatentypen
      AktuelleBeschäftigung : GlobaleDatentypen.Befehle_Enum;
      AktuelleBeschäftigungNachfolger : GlobaleDatentypen.Befehle_Enum;
      
      AktuelleBeschäftigungszeit : Natural;
      AktuelleBeschäftigungszeitNachfolger : Natural;

      KIZielKoordinaten : AchsenKartenfeldPositivRecord;
      KIBeschäftigt : KIDatentypen.Einheit_Aufgabe_Enum;
      KIBewegungPlan : KIBewegungPlanArray;
      
      Transportiert : TransporterArray;
      WirdTransportiert : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
      
   end record;



   type GebäudeVorhandenArray is array (GlobaleDatentypen.GebäudeID'Range) of Boolean;

   type StadtGebautRecord is record
      
      ID : GlobaleDatentypen.StadtID;
      AchsenPosition : AchsenKartenfeldPositivRecord;
      AmWasser : Boolean;
      Einwohner : GlobaleDatentypen.GrundwerteNRGWVA;
      
      AktuelleNahrungsmittel : GlobaleDatentypen.GesamtproduktionStadt;
      AktuelleNahrungsproduktion : GlobaleDatentypen.GesamtproduktionStadt;
      AktuelleRessourcen : GlobaleDatentypen.KostenLager;
      AktuelleProduktionrate : GlobaleDatentypen.GesamtproduktionStadt;

      AktuelleGeldgewinnung : GlobaleDatentypen.GesamtproduktionStadt;
      AktuelleForschungsrate : GlobaleDatentypen.GesamtproduktionStadt;
      AktuellesBauprojekt : Natural;
      VerbleibendeBauzeit : GlobaleDatentypen.KostenLager;

      Korruption : GlobaleDatentypen.GesamtproduktionStadt;      
      -- Eine Liste anlegen welche Nummer welches Gebäude ist.
      GebäudeVorhanden : GebäudeVorhandenArray;
      Name : Unbounded_Wide_Wide_String;

      UmgebungBewirtschaftung : GlobaleDatentypen.UmgebungBewirtschaftungArray;
      ArbeitendeEinwohner : GlobaleDatentypen.GrundwerteNRGWVA;
      StadtUmgebungGröße : GlobaleDatentypen.LoopRangeMinusDreiZuDrei;
      
      -- 0 = Sie hat nichts zu tun, > 0 = Sie hat eine festgelegte Aufgabe (z. B. Gebäude bauen), -10 = Die KI hat irgendwas gemacht und es soll nicht geändert werden, < 0 = KI Einheit die irgendetwas erledigt hat
      KIAktuelleBeschäftigung : KIDatentypen.Stadt_Aufgabe_Enum;
      
   end record;



   type WichtigesRecord is record
      
      AktuelleGeldmenge : Integer;
      GeldZugewinnProRunde : GlobaleDatentypen.KostenLager;

      AktuelleForschungsrate : GlobaleDatentypen.KostenLager;
      AktuelleForschungsmenge : GlobaleDatentypen.KostenLager;
      VerbleibendeForschungszeit : GlobaleDatentypen.KostenLager;
      AktuellesForschungsprojekt : GlobaleDatentypen.ForschungIDMitNullWert;

      Erforscht : GlobaleDatentypen.ErforschtArray;
      
   end record;
   
   
   
   type KartenRecord is record

      Grund : GlobaleDatentypen.KartenGrund;
      Hügel : Boolean;
      Sichtbar : GlobaleDatentypen.SichtbarkeitArray;
      
      Fluss : GlobaleDatentypen.KartenGrund;
      VerbesserungStraße : GlobaleDatentypen.KartenVerbesserung;
      VerbesserungGebiet : GlobaleDatentypen.KartenVerbesserung;
      Ressource : GlobaleDatentypen.KartenGrund;
      
      DurchStadtBelegterGrund : GlobaleDatentypen.BelegterGrund;
      Felderwertung : GlobaleDatentypen.GesamtproduktionStadt;

   end record;

end GlobaleRecords;