with KarteneffektDatentypen;
with KartendatenbankRecord;

package EffekteDatenbank is
   pragma Preelaborate;

   type EffektelisteArray is array (KarteneffektDatentypen.Effekt_Kartenfeld_Vorhanden_Enum'Range) of KartendatenbankRecord.KarteneffektlisteRecord;
   Effekteliste : EffektelisteArray;

end EffekteDatenbank;
