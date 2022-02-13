pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with KartenDatentypen; use KartenDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;
with KartenRecords;
with SystemKonstanten;

with KIDatentypen;

package LeseEinheitenGebaut is

   function ID
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.EinheitenIDMitNullWert
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante);

   function Koordinaten
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return KartenRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante);
   
   function Heimatstadt
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante);
      
   function Lebenspunkte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.Lebenspunkte
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante);
   
   function Bewegungspunkte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.VorhandeneBewegungspunkte
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante);
   
   function Erfahrungspunkte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.Kampfwerte
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante);
   
   function Rang
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.Kampfwerte
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante);
      
   function Beschäftigung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return SystemDatentypen.Tastenbelegung_Enum
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante);
   
   function BeschäftigungNachfolger
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return SystemDatentypen.Tastenbelegung_Enum
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante);
      
   function Beschäftigungszeit
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante);
   
   function BeschäftigungszeitNachfolger
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante);
      
   function KIZielKoordinaten
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return KartenRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante);
   
   function KIBeschäftigt
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return KIDatentypen.Einheit_Aufgabe_Enum
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante);
   
   function KIBewegungPlan
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      PlanschrittExtern : in KartenDatentypen.Stadtfeld)
      return KartenRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante);
      
   function Transportiert
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      PlatzExtern : in EinheitStadtDatentypen.Transportplätze)
      return EinheitStadtDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante
          and
            PlatzExtern <= EinheitStadtRecords.TransporterArray'Last);
   
   function WirdTransportiert
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante);
      
   function Meldungen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      WelcheMeldungExtern : in EinheitStadtDatentypen.Einheit_Meldung_Art_Enum)
      return EinheitStadtDatentypen.Einheit_Meldung_Enum
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante);
   
   function GanzerEintrag
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtRecords.EinheitenGebautRecord
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante);

end LeseEinheitenGebaut;
