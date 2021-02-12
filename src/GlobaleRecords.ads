pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleDatentypen;

package GlobaleRecords is
   
   type AchsenAusStadtfeldRecord is record
      
      YAchse : GlobaleDatentypen.Stadtfeld;
      XAchse : GlobaleDatentypen.Stadtfeld;
      
   end record;
   
   
   
   type AchsenAusKartenfeldPositivRecord is record
      
      EAchse : GlobaleDatentypen.EbeneVorhanden;
      YAchse : GlobaleDatentypen.KartenfeldPositiv;
      XAchse : GlobaleDatentypen.KartenfeldPositiv;
      
   end record;
   
   

   type AchsenAusKartenfeldRecord is record
      
      EAchse : GlobaleDatentypen.Ebene;
      YAchse : GlobaleDatentypen.Kartenfeld;
      XAchse : GlobaleDatentypen.Kartenfeld;
      
   end record;
   
   

   type RasseUndPlatznummerRecord is record
      
      Rasse : GlobaleDatentypen.RassenMitNullwert;
      Platznummer : Natural;
      
   end record;



   type EinheitRasseUndPlatznummerUndIDRecord is record
      
      Rasse : GlobaleDatentypen.RassenMitNullwert;
      Platznummer : Natural;
      ID : GlobaleDatentypen.EinheitenIDMitNullWert;

   end record;
   

   
   type CursorRecord is record
      
      CursorGrafik : Wide_Wide_Character;
      AchsenPosition : AchsenAusKartenfeldPositivRecord;
      AchsenPositionAlt : AchsenAusKartenfeldPositivRecord;
      AchsenPositionStadt : AchsenAusStadtfeldRecord;
      
   end record;



   type EinheitenGebautRecord is record
      
      -- 0 = Sie hat nichts zu tun, > 0 = Sie hat eine festgelegte Aufgabe (z. B. Straße bauen), -10 = Die KI hat irgendwas gemacht und es soll nicht geändert werden, < 0 = KI Einheit die irgendetwas erledigt hat
      AktuelleBeschäftigung : Integer;
      AktuelleBeschäftigung2 : Natural;
      
      ID : GlobaleDatentypen.EinheitenIDMitNullWert;
      AchsenPosition : AchsenAusKartenfeldPositivRecord;
      
      AktuelleLebenspunkte : Integer;
      AktuelleBewegungspunkte : Float;
      AktuelleErfahrungspunkte : Natural;
      AktuellerRang : Natural;
      
      AktuelleBeschäftigungszeit : Natural;
      AktuelleBeschäftigungszeit2 : Natural;
      
   end record;



   type StadtGebautRecord is record
      
      ID : Natural;
      AchsenPosition : AchsenAusKartenfeldPositivRecord;
      AmWasser : Boolean;
      Einwohner : Natural;
      
      AktuelleNahrungsmittel : GlobaleDatentypen.KostenLager;
      AktuelleNahrungsproduktion : GlobaleDatentypen.GesamtproduktionStadt;
      AktuelleRessourcen : GlobaleDatentypen.KostenLager;
      AktuelleProduktionrate : GlobaleDatentypen.GesamtproduktionStadt;

      AktuelleGeldgewinnung : GlobaleDatentypen.GesamtproduktionStadt;
      AktuelleForschungsrate : GlobaleDatentypen.GesamtproduktionStadt;
      AktuellesBauprojekt : Natural;
      VerbleibendeBauzeit : GlobaleDatentypen.KostenLager;

      Korruption : GlobaleDatentypen.GesamtproduktionStadt;      
      -- Eine Liste anlegen welche Nummer welches Gebäude ist.
      GebäudeVorhanden : Wide_Wide_String (Integer (GlobaleDatentypen.GebäudeID'First) .. Integer (GlobaleDatentypen.GebäudeID'Last));
      Name : Unbounded_Wide_Wide_String;

      UmgebungBewirtschaftung : GlobaleDatentypen.UmgebungBewirtschaftungArray;
      ArbeitendeEinwohner : Natural;
      StadtUmgebungGröße : GlobaleDatentypen.Stadtfeld;
      
      -- 0 = Sie hat nichts zu tun, > 0 = Sie hat eine festgelegte Aufgabe (z. B. Gebäude bauen), -10 = Die KI hat irgendwas gemacht und es soll nicht geändert werden, < 0 = KI Einheit die irgendetwas erledigt hat
      KIAktuelleBeschäftigung : Integer;
      
   end record;



   type WichtigesRecord is record
      
      AktuelleGeldmenge : Integer;
      GeldZugewinnProRunde : GlobaleDatentypen.KostenLager;

      AktuelleForschungsrate : GlobaleDatentypen.KostenLager;
      AktuelleForschungsmenge : GlobaleDatentypen.KostenLager;
      VerbleibendeForschungszeit : GlobaleDatentypen.KostenLager;
      AktuellesForschungsprojekt : Natural;

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

      -- Sichtbar2
      -- VerbesserungStraße2
      -- VerbesserungGebiet2
      -- Noch mehr?

   end record;

end GlobaleRecords;
