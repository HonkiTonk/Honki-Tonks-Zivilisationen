with SpeziesDatentypen;

with LeseSpeziesbelegung;

package MeldungFestlegenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure MeldungFestlegen
     (MeldungExtern : in Positive);

   procedure SpielermeldungFestlegen
     (MeldungExtern : in Positive;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end MeldungFestlegenLogik;
