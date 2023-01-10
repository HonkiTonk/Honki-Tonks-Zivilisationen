private with SpeziesDatentypen;
private with ForschungenDatentypen;

private with LeseSpeziesbelegung;

package ForschungsfortschrittLogik is
   pragma Elaborate_Body;

   procedure Forschungsfortschritt;
   
private
   use type SpeziesDatentypen.Spieler_Enum;
   
   AktuellesForschungsprojekt : ForschungenDatentypen.ForschungIDMitNullWert;

   procedure Fortschritt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end ForschungsfortschrittLogik;
