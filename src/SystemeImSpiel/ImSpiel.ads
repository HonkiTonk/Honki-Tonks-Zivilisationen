with Ada.Calendar;
use Ada.Calendar;

with InDerStadt, Wachstum, Bauen, Karte, BefehleImSpiel, Optionen, Sichtbarkeit, EinheitenDatenbank, Verbesserungen, ForschungsDatenbank, GebaeudeDatenbank, GlobaleVariablen, Anzeige, KI, Ladezeiten;

package ImSpiel is

   function ImSpiel return Integer with
     Post => ImSpiel'Result >= -1;

private

   AktuellerBefehl : Integer;

end ImSpiel;
