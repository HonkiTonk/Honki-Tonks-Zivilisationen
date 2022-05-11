pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen;

with DatenbankRecords;

package KartengrundDatenbank is
   
   ----------------- Die ganzen Listen mal in Datenbanken umbenennen? Warum habe ich das nicht von Anfang an so benannt?
   
   type KartengrundlisteArray is array (KartengrundDatentypen.Kartengrund_Vorhanden_Enum'Range) of DatenbankRecords.KartengrundlisteRecord;
   Kartengrundliste : KartengrundlisteArray;
   
   procedure StandardKartengrundDatenbankLaden;

end KartengrundDatenbank;
