pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenverbesserungDatentypen;

with DatenbankRecords;

package VerbesserungenDatenbank is
   
   type VerbesserungenlisteArray is array (KartenverbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum'Range) of DatenbankRecords.VerbesserungenWegeListeRecord;
   Verbesserungenliste : VerbesserungenlisteArray;
   
   type WegelisteArray is array (KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Range) of DatenbankRecords.VerbesserungenWegeListeRecord;
   Wegeliste : WegelisteArray;
   
   procedure StandardVerbesserungenDatenbankLaden;
   procedure StandardWegeDatenbankLaden;
   procedure VerbesserungenDatenbankSpeichern;
         
end VerbesserungenDatenbank;
