with KartenzusatzgrundDatentypen;
with KartendatenbankRecord;
with KartenfluesseDatentypen;
with KartenressourcenDatentypen;
with KartenbasisgrundDatentypen;

package KartenDatenbank is
   pragma Preelaborate;
      
   type BasisgrundlisteArray is array (KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum'Range) of KartendatenbankRecord.KartenbasisgrundlisteRecord;
   Basisgrundliste : BasisgrundlisteArray;
      
   type ZusatzgrundlisteArray is array (KartenzusatzgrundDatentypen.Zusatzgrund_Vorhanden_Enum'Range) of KartendatenbankRecord.KartenzusatzgrundlisteRecord;
   Zusatzgrundliste : ZusatzgrundlisteArray;
   
   -- Hier mal überall Karten entfernen? äöü
   type KartenflusslisteArray is array (KartenfluesseDatentypen.Fluss_Vorhanden_Enum'Range) of KartendatenbankRecord.KartenextraslisteRecord;
   Kartenflussliste : KartenflusslisteArray;
   
   type KartenressourcenlisteArray is array (KartenressourcenDatentypen.Ressourcen_Vorhanden_Enum'Range) of KartendatenbankRecord.KartenextraslisteRecord;
   Kartenressourcenliste : KartenressourcenlisteArray;
   
end KartenDatenbank;
