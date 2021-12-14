pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemDatentypen; use SystemDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;
with KartenRecords;
with KartenDatentypen;
with EinheitStadtDatentypen;

with KIDatentypen;

with Karten;

package SchreibeStadtGebaut is

   procedure ID
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      IDExtern : in KartenDatentypen.Karten_Verbesserung_Stadt_ID_Enum)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemDatentypen.Leer);
   
   procedure Position
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemDatentypen.Leer
          and
            PositionExtern.YAchse in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   procedure EinwohnerArbeiter
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EinwohnerArbeiterExtern : in Boolean;
      ÄnderungExtern : in EinheitStadtDatentypen.ProduktionFeld)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemDatentypen.Leer);
      
   procedure Nahrungsmittel
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      NahrungsmittelExtern : in EinheitStadtDatentypen.GesamtproduktionStadt;
      ÄndernSetzenExtern : in Boolean)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemDatentypen.Leer);
   
   procedure Nahrungsproduktion
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      NahrungsproduktionExtern : in EinheitStadtDatentypen.GesamtproduktionStadt;
      ÄndernSetzenExtern : in Boolean)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemDatentypen.Leer);
   
   procedure Ressourcen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      RessourcenExtern : in EinheitStadtDatentypen.KostenLager;
      ÄndernSetzenExtern : in Boolean)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemDatentypen.Leer);
   
   procedure Produktionrate
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      ProduktionrateExtern : in EinheitStadtDatentypen.GesamtproduktionStadt;
      ÄndernSetzenExtern : in Boolean)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemDatentypen.Leer);
   
   procedure Geldgewinnung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      GeldgewinnungExtern : in EinheitStadtDatentypen.GesamtproduktionStadt;
      ÄndernSetzenExtern : in Boolean)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemDatentypen.Leer);
   
   procedure PermanenteKostenPosten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      WelcherPostenExtern : in EinheitStadtDatentypen.Permanente_Kosten_Verwendet_Enum;
      KostenExtern : in EinheitStadtDatentypen.GesamtePermanenteKosten;
      ÄndernSetzenExtern : in Boolean)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemDatentypen.Leer);
      
   procedure Forschungsrate
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      ForschungsrateExtern : in EinheitStadtDatentypen.GesamtproduktionStadt;
      ÄndernSetzenExtern : in Boolean)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemDatentypen.Leer);
   
   procedure Bauprojekt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      BauprojektExtern : in EinheitStadtRecords.BauprojektRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemDatentypen.Leer);
   
   procedure Bauzeit
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemDatentypen.Leer);
   
   procedure Korruption
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      KorruptionExtern : in EinheitStadtDatentypen.GesamtproduktionStadt;
      ÄndernSetzenExtern : in Boolean)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemDatentypen.Leer);
   
   procedure GebäudeVorhanden
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      WelchesGebäudeExtern : in EinheitStadtDatentypen.GebäudeID;
      HinzufügenEntfernenExtern : in Boolean)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemDatentypen.Leer);
   
   procedure Name
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      NameExtern : in Unbounded_Wide_Wide_String)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemDatentypen.Leer);
   
   procedure UmgebungBewirtschaftung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      YPositionExtern, XPositionExtern : in KartenDatentypen.LoopRangeMinusDreiZuDrei;
      BelegenEntfernenExtern : in Boolean)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemDatentypen.Leer);
   
   procedure UmgebungGröße
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      UmgebungGrößeExtern : in KartenDatentypen.LoopRangeMinusDreiZuDrei;
      ÄndernSetzenExtern : in Boolean)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemDatentypen.Leer);
      
   procedure Meldungen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      WelcheMeldungExtern : in EinheitStadtDatentypen.Stadt_Meldung_Art_Enum;
      MeldungExtern : in EinheitStadtDatentypen.Stadt_Meldung_Enum)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemDatentypen.Leer);
      
   procedure KIBeschäftigung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      BeschäftigungExtern : in KIDatentypen.Stadt_Aufgabe_Enum)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemDatentypen.Leer);
   
   procedure Nullsetzung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemDatentypen.Leer);
      
   procedure GanzerEintrag
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EintragExtern : in EinheitStadtRecords.StadtGebautRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemDatentypen.Leer);

end SchreibeStadtGebaut;
