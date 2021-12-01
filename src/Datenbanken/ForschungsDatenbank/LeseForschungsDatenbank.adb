pragma SPARK_Mode (On);

with ForschungsDatenbank;

package body LeseForschungsDatenbank is

   function PreisForschung
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.ForschungID)
      return EinheitStadtDatentypen.KostenLager
   is begin

      return ForschungsDatenbank.ForschungListe (RasseExtern, IDExtern).PreisForschung;

   end PreisForschung;



   function AnforderungForschung
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.ForschungID;
      WelcheAnforderungExtern : in Positive)
      return EinheitStadtDatentypen.ForschungIDNichtMöglich
   is begin

      return ForschungsDatenbank.ForschungListe (RasseExtern, IDExtern).AnforderungForschung (WelcheAnforderungExtern);

   end AnforderungForschung;



   function GanzerEintrag
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.ForschungID)
      return DatenbankRecords.ForschungListeRecord
   is begin

      return ForschungsDatenbank.ForschungListe (RasseExtern, IDExtern);

   end GanzerEintrag;

end LeseForschungsDatenbank;
