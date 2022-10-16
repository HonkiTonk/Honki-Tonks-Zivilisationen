pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen;
with KartendatenbankRecord;

package KartenDatenbank is
      
   type KartengrundlisteArray is array (KartengrundDatentypen.Kartengrund_Vorhanden_Enum'Range) of KartendatenbankRecord.KartenpassierbarkeitslistenRecord;
   Kartengrundliste : KartengrundlisteArray;
   
   type KartenflusslisteArray is array (KartengrundDatentypen.Kartenfluss_Vorhanden_Enum'Range) of KartendatenbankRecord.KartenlistenRecord;
   Kartenflussliste : KartenflusslisteArray;
   
   type KartenressourcenlisteArray is array (KartengrundDatentypen.Kartenressourcen_Vorhanden_Enum'Range) of KartendatenbankRecord.KartenlistenRecord;
   Kartenressourcenliste : KartenressourcenlisteArray;
   
   procedure StandardKartengrundDatenbankLaden;
   procedure StandardKartenflussDatenbankLaden;
   procedure StandardKartenressourcenDatenbankLaden;
   procedure KartengrundDatenbankSpeichern;

end KartenDatenbank;
