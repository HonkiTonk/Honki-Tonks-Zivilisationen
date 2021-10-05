pragma SPARK_Mode (On);

with EinheitStadtRecords, SystemDatentypen, GlobaleVariablen, KartenRecords, EinheitStadtDatentypen, SonstigeDatentypen, KartenDatentypen;
use SonstigeDatentypen, KartenDatentypen;

with KIDatentypen;

with Karten;

package SchreibeEinheitenGebaut is

   procedure ID
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      IDExtern : in EinheitStadtDatentypen.EinheitenIDMitNullWert)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);
   
   procedure Position
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer
          and
            PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   procedure Heimatstadt
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      HeimatstadtExtern : in EinheitStadtDatentypen.MaximaleStädteMitNullWert)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);
   
   procedure Lebenspunkte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      LebenspunkteExtern : in EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      RechnenSetzenExtern : in KartenDatentypen.LoopRangeMinusEinsZuEins)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);
   
   procedure Bewegungspunkte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      BewegungspunkteExtern : in EinheitStadtDatentypen.BewegungFloat;
      RechnenSetzenExtern : in KartenDatentypen.LoopRangeMinusEinsZuEins)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);
   
   procedure Erfahrungspunkte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      ErfahrungspunkteExtern : in EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      AddierenSetzenExtern : in Boolean)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);
   
   procedure Rang
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);
   
   procedure Beschäftigung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      BeschäftigungExtern : in SystemDatentypen.Tastenbelegung_Enum)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);
   
   procedure BeschäftigungNachfolger
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      BeschäftigungExtern : in SystemDatentypen.Tastenbelegung_Enum)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);
   
   procedure Beschäftigungszeit
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      ZeitExtern : in EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      RechnenSetzenExtern : in KartenDatentypen.LoopRangeMinusEinsZuEins)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);
   
   procedure BeschäftigungszeitNachfolger
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      ZeitExtern : in EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      RechnenSetzenExtern : in KartenDatentypen.LoopRangeMinusEinsZuEins)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);
   
   procedure KIZielKoordinaten
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer
          and
            KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   procedure KIBeschäftigt
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      AufgabeExtern : in KIDatentypen.Einheit_Aufgabe_Enum)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);
   
   procedure KIBewegungPlan
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PlanpositionExtern : in KartenDatentypen.Stadtfeld)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer
          and
            PositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            PositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
      
   procedure Transportiert
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      LadungExtern : in EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
      LadungspositionExtern : in EinheitStadtDatentypen.MaximaleStädte)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);
   
   procedure WirdTransportiert
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      TransporterExtern : in EinheitStadtDatentypen.MaximaleEinheitenMitNullWert)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);
      
   procedure Meldungen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      MeldungExtern : in EinheitStadtDatentypen.Einheit_Meldung_Enum;
      WelcheMeldungExtern : in EinheitStadtDatentypen.Einheit_Meldung_Art_Enum)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);
   
   procedure Nullsetzung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);
   
   procedure GanzerEintrag
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EintragExtern : in EinheitStadtRecords.EinheitenGebautRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);

end SchreibeEinheitenGebaut;
