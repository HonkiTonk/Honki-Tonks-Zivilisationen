private with RassenDatentypen;
private with ForschungenDatentypen;

private with LeseRassenbelegung;

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
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

end ForschungsfortschrittLogik;
