with SpeziesDatentypen;
with ForschungenDatentypen;
with ProduktionDatentypen;
with AufgabenDatentypen;
with SystemDatentypen;
with BefehleDatentypen;

with LeseSpeziesbelegung;

package LeseForschungenDatenbank is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   function Kosten
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in ForschungenDatentypen.ForschungIDMitNullWert)
      return ProduktionDatentypen.Lagermenge
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   function AnforderungForschung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in ForschungenDatentypen.ForschungIDMitNullWert;
      WelcheAnforderungExtern : in ForschungenDatentypen.Forschung_Anforderung_Enum)
      return ForschungenDatentypen.ForschungIDNichtMöglich
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   function Verbesserungen
     (VerbesserungExtern : in BefehleDatentypen.Siedler_Verbesserung_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ForschungenDatentypen.ForschungIDNichtMöglich
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   function Wege
     (WegExtern : in AufgabenDatentypen.Einheitenbefehle_Wege_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ForschungenDatentypen.ForschungIDNichtMöglich
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   function Umgebung
     (AnfangEndeExtern : in SystemDatentypen.Anfang_Ende_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ForschungenDatentypen.ForschungIDNichtMöglich
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end LeseForschungenDatenbank;
