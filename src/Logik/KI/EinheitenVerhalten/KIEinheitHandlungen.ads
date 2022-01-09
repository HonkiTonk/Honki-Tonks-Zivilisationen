pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with EinheitStadtRecords;

package KIEinheitHandlungen is

   procedure EinheitHandlungen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SystemDatentypen.Spieler_KI);

private

   FeindlicheEinheit : EinheitStadtRecords.RassePlatznummerRecord;

   procedure NormaleHandlungen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SystemDatentypen.Spieler_KI);

   procedure GefahrenHandlungen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      FeindlicheEinheitExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SystemDatentypen.Spieler_KI
          and
            FeindlicheEinheitExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (FeindlicheEinheitExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (FeindlicheEinheitExtern.Rasse) /= SystemDatentypen.Leer
          and
            EinheitRasseNummerExtern.Rasse /= FeindlicheEinheitExtern.Rasse);

   procedure BewegungAufgabenplanung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);



   function HandlungBeendet
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SystemDatentypen.Spieler_KI);

end KIEinheitHandlungen;
