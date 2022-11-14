private with RassenDatentypen;
private with SpielVariablen;
private with ForschungenDatentypen;

package ForschungsfortschrittLogik is
   pragma Elaborate_Body;

   procedure Forschungsfortschritt;
   
private
   use type RassenDatentypen.Spieler_Enum;
   
   AktuellesForschungsprojekt : ForschungenDatentypen.ForschungIDMitNullWert;

   procedure Fortschritt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

end ForschungsfortschrittLogik;
