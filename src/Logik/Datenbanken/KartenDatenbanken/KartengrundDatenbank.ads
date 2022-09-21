pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen;

with DatenbankRecords;

package KartengrundDatenbank is
      
   type KartengrundlisteArray is array (KartengrundDatentypen.Kartengrund_Vorhanden_Enum'Range) of DatenbankRecords.KartengrundlisteRecord;
   Kartengrundliste : KartengrundlisteArray;
   
   procedure StandardKartengrundDatenbankLaden;

end KartengrundDatenbank;
