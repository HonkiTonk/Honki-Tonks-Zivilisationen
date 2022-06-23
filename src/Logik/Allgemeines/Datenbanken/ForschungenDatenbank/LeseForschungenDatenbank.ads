pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SonstigeVariablen;
with ForschungenDatentypen;
with ProduktionDatentypen;

package LeseForschungenDatenbank is

   function PreisForschung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in ForschungenDatentypen.ForschungID)
      return ProduktionDatentypen.Produktion
     with
       Pre => (
                 SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

   function AnforderungForschung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in ForschungenDatentypen.ForschungID;
      WelcheAnforderungExtern : in Positive)
      return ForschungenDatentypen.ForschungIDNichtMöglich
     with
       Pre => (
                 SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

end LeseForschungenDatenbank;
