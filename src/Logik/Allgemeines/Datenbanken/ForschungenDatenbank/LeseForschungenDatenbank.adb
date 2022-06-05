pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ForschungenDatenbank;

package body LeseForschungenDatenbank is

   function PreisForschung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in ForschungenDatentypen.ForschungID)
      return ProduktionDatentypen.KostenLager
   is begin

      return ForschungenDatenbank.Forschungsliste (RasseExtern, IDExtern).PreisForschung;

   end PreisForschung;



   function AnforderungForschung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in ForschungenDatentypen.ForschungID;
      WelcheAnforderungExtern : in Positive)
      return ForschungenDatentypen.ForschungIDNichtMöglich
   is begin

      return ForschungenDatenbank.Forschungsliste (RasseExtern, IDExtern).AnforderungForschung (WelcheAnforderungExtern);

   end AnforderungForschung;

end LeseForschungenDatenbank;
