pragma SPARK_Mode (On);

with SystemDatentypen, EinheitStadtRecords, GlobaleVariablen, SonstigeDatentypen, EinheitStadtDatentypen, KartenDatentypen;
use SonstigeDatentypen;

package Aufgaben is
   
   function VerbesserungTesten
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      BefehlExtern : in SystemDatentypen.Tastenbelegung_Befehle_Enum)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);
   
   function VerbesserungAnlegen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      BefehlExtern : in SystemDatentypen.Tastenbelegung_Befehle_Enum)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);
   
private
   
   IDEinheit : EinheitStadtDatentypen.EinheitenID;
   
   Grund : KartenDatentypen.Karten_Grund_Enum;
   
   procedure EinheitVerschanzen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);
   
   procedure RundeAussetzen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);
   
   procedure EinheitAuflösen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);
   
   procedure EinheitVerbessern
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);
   
   procedure Plünderung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   
   
   function VerbesserungFestgelegt
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      BefehlExtern : in SystemDatentypen.Tastenbelegung_Befehle_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);
   
   function EinheitHeilen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      AnlegenTestenExtern : in Boolean)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);
   
   function VerbesserungPlündern
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      AnlegenTestenExtern : in Boolean)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);
   
   function VerbesserungEinheit
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      AnlegenTestenExtern : in Boolean)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);
   
   function AllgemeinerAnfangstest
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      BefehlExtern : in SystemDatentypen.Tastenbelegung_Befehle_Enum)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);

end Aufgaben;
