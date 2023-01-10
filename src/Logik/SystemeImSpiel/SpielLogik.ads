with RueckgabeDatentypen;

private with SpeziesDatentypen;

private with LeseSpeziesbelegung;

package SpielLogik is
   pragma Elaborate_Body;

   function Spiel
     return RueckgabeDatentypen.Rückgabe_Werte_Enum;

private
   use type SpeziesDatentypen.Spieler_Enum;

   AktuellerBefehlSpieler : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   RückgabeOptionen : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   RückgabeSpezies : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   RückgabeWert : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   RückgabeSpielmenü : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   RückgabeMenschAmZug : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   AuswahlSpielmenü : RueckgabeDatentypen.Rückgabe_Werte_Enum;

   procedure KISpieler
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              );

   function SpeziesImSpiel
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum;

   function SpeziesDurchgehen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   function MenschlicherSpieler
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

   function MenschAmZug
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

   function Spielmenü
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

end SpielLogik;
