with KartenverbesserungDatentypen;
with KartendatenbankRecord;
with KartenwegeDatentypen;

package VerbesserungenDatenbank is
   pragma Preelaborate;
   
   type VerbesserungenlisteArray is array (KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum'Range) of KartendatenbankRecord.VerbesserungenlisteRecord;
   Verbesserungenliste : VerbesserungenlisteArray;
   
   type WegelisteArray is array (KartenwegeDatentypen.Weg_Vorhanden_Enum'Range) of KartendatenbankRecord.WegelisteRecord;
   Wegeliste : WegelisteArray;
         
end VerbesserungenDatenbank;
