with SpeziesDatentypen;
with StadtDatentypen;
with GebaeudedatenbankRecord;

package GebaeudeDatenbank is
   pragma Preelaborate;

   type GebäudelisteArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range, StadtDatentypen.GebäudeIDVorhanden'Range) of GebaeudedatenbankRecord.GebäudelisteRecord;
   GebäudeListe : GebäudelisteArray;
   
end GebaeudeDatenbank;
