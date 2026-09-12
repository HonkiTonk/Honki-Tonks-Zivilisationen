with KartendatenbankRecord;
with KarteneffekteDatentypen;

package EffekteDatenbank is
   pragma Preelaborate;

   type EffektelisteArray is array (KarteneffekteDatentypen.Effekt_Kartenfeld_Vorhanden_Enum'Range) of KartendatenbankRecord.KartenextraslisteRecord;
   Effekteliste : EffektelisteArray;

end EffekteDatenbank;
