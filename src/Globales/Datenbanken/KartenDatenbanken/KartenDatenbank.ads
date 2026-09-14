with KartenzusatzgrundDatentypen;
with KartendatenbankRecord;
with KartenfluesseDatentypen;
with KartenrohstoffeDatentypen;
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
   
   type KartenrohstoffelisteArray is array (KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum'Range) of KartendatenbankRecord.KartenextraslisteRecord;
   Kartenrohstoffeliste : KartenrohstoffelisteArray;
   
end KartenDatenbank;
