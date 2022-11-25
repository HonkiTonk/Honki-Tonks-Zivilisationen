with KartengrundDatentypen;
with KartendatenbankRecord;
with KartenextraDatentypen;

package KartenDatenbank is
   pragma Preelaborate;
      
   type BasisgrundlisteArray is array (KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Range) of KartendatenbankRecord.KartenpassierbarkeitslistenRecord;
   Basisgrundliste : BasisgrundlisteArray;
      
   type ZusatzgrundlisteArray is array (KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Range) of KartendatenbankRecord.KartenzusatzgrundlisteRecord;
   Zusatzgrundliste : ZusatzgrundlisteArray;
   
   type KartenflusslisteArray is array (KartenextraDatentypen.Fluss_Vorhanden_Enum'Range) of KartendatenbankRecord.KartenlistenRecord;
   Kartenflussliste : KartenflusslisteArray;
   
   type KartenressourcenlisteArray is array (KartenextraDatentypen.Ressourcen_Vorhanden_Enum'Range) of KartendatenbankRecord.KartenlistenRecord;
   Kartenressourcenliste : KartenressourcenlisteArray;
   
end KartenDatenbank;
