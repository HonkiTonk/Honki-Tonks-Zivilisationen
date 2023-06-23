with KartenextraDatentypen;
with KartendatenbankRecord;

package EffekteDatenbank is
   pragma Preelaborate;

   type EffektelisteArray is array (KartenextraDatentypen.Effekt_Kartenfeld_Vorhanden_Enum'Range) of KartendatenbankRecord.KartenextraslisteRecord;
   Effekteliste : EffektelisteArray;

end EffekteDatenbank;
