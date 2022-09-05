pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;

private with ForschungenDatentypen;

package ForschungsfortschrittLogik is

   procedure Forschungsfortschritt;
   
private
   
   AktuellesForschungsprojekt : ForschungenDatentypen.ForschungIDMitNullWert;

   procedure Fortschritt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

end ForschungsfortschrittLogik;
