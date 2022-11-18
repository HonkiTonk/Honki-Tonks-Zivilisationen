with KartengrundDatentypen;
with KartendatenbankRecord;

package KartenDatenbank is
   pragma Preelaborate;
      
   type BasisgrundlisteArray is array (KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Range) of KartendatenbankRecord.KartenpassierbarkeitslistenRecord;
   Basisgrundliste : BasisgrundlisteArray;
      
   type ZusatzgrundlisteArray is array (KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Range) of KartendatenbankRecord.KartenzusatzgrundlisteRecord;
   Zusatzgrundliste : ZusatzgrundlisteArray;
   
   type KartenflusslisteArray is array (KartengrundDatentypen.Kartenfluss_Vorhanden_Enum'Range) of KartendatenbankRecord.KartenlistenRecord;
   Kartenflussliste : KartenflusslisteArray;
   
   type KartenressourcenlisteArray is array (KartengrundDatentypen.Kartenressourcen_Vorhanden_Enum'Range) of KartendatenbankRecord.KartenlistenRecord;
   Kartenressourcenliste : KartenressourcenlisteArray;
   
end KartenDatenbank;
