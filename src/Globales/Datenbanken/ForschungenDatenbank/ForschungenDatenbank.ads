with ForschungenDatentypen;
with SpeziesDatentypen;
with ForschungRecordKonstanten;
with ForschungsdatenbankRecord;

package ForschungenDatenbank is
   pragma Preelaborate;

   type ForschungslisteArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range, ForschungenDatentypen.ForschungIDVorhanden'Range) of ForschungsdatenbankRecord.ForschungslisteRecord;
   Forschungsliste : ForschungslisteArray;

   TechnologieVerbesserungen : ForschungRecordKonstanten.TechnologieVerbesserungenArray;

   TechnologieWege : ForschungRecordKonstanten.TechnologieWegeArray;

   TechnologieUmgebungsgröße : ForschungRecordKonstanten.TechnologieUmgebungsgrößeArray;

end ForschungenDatenbank;
