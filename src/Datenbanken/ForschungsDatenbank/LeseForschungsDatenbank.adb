pragma SPARK_Mode (On);

with ForschungsDatenbank;

package body LeseForschungsDatenbank is

   function PreisForschung
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.ForschungID)
      return GlobaleDatentypen.KostenLager
   is begin

      return ForschungsDatenbank.ForschungListe (RasseExtern, IDExtern).PreisForschung;

   end PreisForschung;



   function AnforderungForschung
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.ForschungID;
      WelcheAnforderungExtern : in Positive)
      return GlobaleDatentypen.ForschungIDMitNullWert
   is begin

      return ForschungsDatenbank.ForschungListe (RasseExtern, IDExtern).AnforderungForschung (WelcheAnforderungExtern);

   end AnforderungForschung;



   function GanzerEintrag
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.ForschungID)
      return DatenbankRecords.ForschungListeRecord
   is begin

      return ForschungsDatenbank.ForschungListe (RasseExtern, IDExtern);

   end GanzerEintrag;

end LeseForschungsDatenbank;
