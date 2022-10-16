pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ForschungenDatentypen;
with RassenDatentypen;
with ForschungKonstanten;
with ForschungsdatenbankRecord;

package ForschungenDatenbank is

   type ForschungslisteArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, ForschungenDatentypen.ForschungID'Range) of ForschungsdatenbankRecord.ForschungslisteRecord;
   Forschungsliste : ForschungslisteArray;

   TechnologieVerbesserungen : ForschungKonstanten.TechnologieVerbesserungenArray;

   TechnologieWege : ForschungKonstanten.TechnologieWegeArray;

   TechnologieUmgebungsgröße : ForschungKonstanten.TechnologieUmgebungsgrößeArray;

   procedure StandardForschungenDatenbankLaden;
   procedure ForschungenDatenbankSpeichern;

private

   procedure StandardTechnologienLaden
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);

end ForschungenDatenbank;
