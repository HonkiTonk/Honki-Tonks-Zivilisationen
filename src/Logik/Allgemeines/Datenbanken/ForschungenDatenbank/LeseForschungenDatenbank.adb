pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ForschungenDatenbank;

package body LeseForschungenDatenbank is

   function PreisForschung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.ForschungID)
      return EinheitStadtDatentypen.KostenLager
   is begin

      return ForschungenDatenbank.Forschungsliste (RasseExtern, IDExtern).PreisForschung;

   end PreisForschung;



   function AnforderungForschung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.ForschungID;
      WelcheAnforderungExtern : in Positive)
      return EinheitStadtDatentypen.ForschungIDNichtMöglich
   is begin

      return ForschungenDatenbank.Forschungsliste (RasseExtern, IDExtern).AnforderungForschung (WelcheAnforderungExtern);

   end AnforderungForschung;



   function GanzerEintrag
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.ForschungID)
      return DatenbankRecords.ForschungslisteRecord
   is begin

      return ForschungenDatenbank.Forschungsliste (RasseExtern, IDExtern);

   end GanzerEintrag;

end LeseForschungenDatenbank;
