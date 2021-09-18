pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen;

package Aufgaben is

   procedure VerbesserungFertiggestellt;
   
   
   
   function VerbesserungTesten
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BefehlExtern : in GlobaleDatentypen.Tastenbelegung_Befehle_Enum)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);
   
   function VerbesserungAnlegen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BefehlExtern : in GlobaleDatentypen.Tastenbelegung_Befehle_Enum)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);
   
private
   
   Test : Boolean;
   
   IDEinheit : GlobaleDatentypen.EinheitenID;
   
   Grund : GlobaleDatentypen.Karten_Grund_Enum;
   
   type Verbesserungen_Verbessern_Enum is (Schiene_Bauen, Tunnel_Bauen);
   type VerbesserungenVerbessernAnforderungenArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range, Verbesserungen_Verbessern_Enum'Range) of GlobaleDatentypen.ForschungIDNichtMöglich;
   -- Später nutzen um ohne zusätzliche Tastenbelegung vorhandene Verbesserung zu verbessern.
   VerbesserungenVerbessernAnforderungen : constant VerbesserungenVerbessernAnforderungenArray := (others => (others => 0));

   procedure VerbesserungFertiggestelltPrüfen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure EinheitVerschanzen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);
   
   procedure RundeAussetzen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);
   
   procedure EinheitAuflösen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);
   
   procedure VerbesserungAngelegt
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);
   
   procedure EinheitVerbessern
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);
   
   procedure VerbesserungWaldAufforsten
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   
   
   function VerbesserungFestgelegt
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BefehlExtern : in Tastenbelegung_Befehle_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);
   
   function EinheitHeilen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      AnlegenTestenExtern : in Boolean)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);
   
   function VerbesserungPlündern
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      AnlegenTestenExtern : in Boolean)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);
   
   function VerbesserungEinheit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      AnlegenTestenExtern : in Boolean)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);
   
   function AllgemeinerAnfangstest
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BefehlExtern : in GlobaleDatentypen.Tastenbelegung_Befehle_Enum)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);

end Aufgaben;
