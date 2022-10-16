pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenverbesserungDatentypen;
with KartendatenbankRecord;

package VerbesserungenDatenbank is
   
   type VerbesserungenlisteArray is array (KartenverbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum'Range) of KartendatenbankRecord.KartenlistenRecord;
   Verbesserungenliste : VerbesserungenlisteArray;
   
   type WegelisteArray is array (KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Range) of KartendatenbankRecord.KartenpassierbarkeitslistenRecord;
   Wegeliste : WegelisteArray;
   
   procedure StandardVerbesserungenDatenbankLaden;
   procedure StandardWegeDatenbankLaden;
   procedure VerbesserungenDatenbankSpeichern;
         
end VerbesserungenDatenbank;
