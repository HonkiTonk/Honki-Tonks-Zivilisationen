with SpeziesDatentypen;

private with ForschungenDatentypen;

with LeseSpeziesbelegung;

package ForschungsfortschrittLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure Forschungsfortschritt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
private
   
   AktuellesForschungsprojekt : ForschungenDatentypen.ForschungID;

end ForschungsfortschrittLogik;
