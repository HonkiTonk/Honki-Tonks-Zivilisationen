with KartenverbesserungDatentypen;
with KartendatenbankRecord;

package VerbesserungenDatenbank is
   pragma Preelaborate;
   
   type VerbesserungenlisteArray is array (KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum'Range) of KartendatenbankRecord.KartenlistenRecord;
   Verbesserungenliste : VerbesserungenlisteArray;
   
   type WegelisteArray is array (KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Range) of KartendatenbankRecord.KartenpassierbarkeitslistenRecord;
   Wegeliste : WegelisteArray;
         
end VerbesserungenDatenbank;
