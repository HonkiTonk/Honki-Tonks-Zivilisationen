with RassenDatentypen;

with LeseRassenbelegung;

package MeldungFestlegenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   procedure MeldungFestlegen
     (MeldungExtern : in Positive);

   procedure SpielermeldungFestlegen
     (MeldungExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

end MeldungFestlegenLogik;
