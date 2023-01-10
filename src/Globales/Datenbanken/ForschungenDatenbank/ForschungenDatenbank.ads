with ForschungenDatentypen;
with SpeziesDatentypen;
with ForschungKonstanten;
with ForschungsdatenbankRecord;

package ForschungenDatenbank is
   pragma Preelaborate;

   type ForschungslisteArray is array (SpeziesDatentypen.Spezies_Verwendet_Enum'Range, ForschungenDatentypen.ForschungID'Range) of ForschungsdatenbankRecord.ForschungslisteRecord;
   Forschungsliste : ForschungslisteArray;

   TechnologieVerbesserungen : ForschungKonstanten.TechnologieVerbesserungenArray;

   TechnologieWege : ForschungKonstanten.TechnologieWegeArray;

   TechnologieUmgebungsgröße : ForschungKonstanten.TechnologieUmgebungsgrößeArray;

end ForschungenDatenbank;
