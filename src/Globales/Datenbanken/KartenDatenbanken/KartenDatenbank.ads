pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen;
with KartendatenbankRecord;

package KartenDatenbank is
      
   type BasisgrundlisteArray is array (KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Range) of KartendatenbankRecord.KartenpassierbarkeitslistenRecord;
   Basisgrundliste : BasisgrundlisteArray;
      
   type ZusatzgrundlisteArray is array (KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Range) of KartendatenbankRecord.KartenlistenRecord;
   Zusatzgrundliste : ZusatzgrundlisteArray;
   
   type KartenflusslisteArray is array (KartengrundDatentypen.Kartenfluss_Vorhanden_Enum'Range) of KartendatenbankRecord.KartenlistenRecord;
   Kartenflussliste : KartenflusslisteArray;
   
   type KartenressourcenlisteArray is array (KartengrundDatentypen.Kartenressourcen_Vorhanden_Enum'Range) of KartendatenbankRecord.KartenlistenRecord;
   Kartenressourcenliste : KartenressourcenlisteArray;
   
   procedure StandardBasisgrundDatenbankLaden;
   procedure StandardZusatzgrundDatenbankLaden;
   procedure StandardKartenflussDatenbankLaden;
   procedure StandardKartenressourcenDatenbankLaden;
   procedure KartengrundDatenbankSpeichern;

end KartenDatenbank;
