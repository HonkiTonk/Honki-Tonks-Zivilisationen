with RassenDatentypen;
with SpielVariablen;

package GlobalesWachstumLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   procedure WachstumWichtiges
     (RasseExtern : in RassenDatentypen.Rassen_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
private
   
   procedure WachstumsratenBerechnen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

end GlobalesWachstumLogik;
