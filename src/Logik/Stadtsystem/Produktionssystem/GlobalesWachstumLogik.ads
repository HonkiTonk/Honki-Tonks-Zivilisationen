with SpeziesDatentypen;

with LeseSpeziesbelegung;

package GlobalesWachstumLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure WachstumWichtiges
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
private
   
   procedure WachstumsratenBerechnen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end GlobalesWachstumLogik;
