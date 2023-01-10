with SpeziesDatentypen;

private with RueckgabeDatentypen;
private with DiplomatieDatentypen;

with LeseSpeziesbelegung;

package DebugmenueLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure Debugmenü
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

private

   Taste : Wide_Wide_Character;

   RückgabeDebugmenü : RueckgabeDatentypen.Rückgabe_Werte_Enum;

   WelcherText : Positive;

   type WechselArray is array (Wide_Wide_Character'Val (Wide_Wide_Character'Pos ('a')) .. Wide_Wide_Character'Val (Wide_Wide_Character'Pos ('r'))) of SpeziesDatentypen.Spezies_Verwendet_Enum;
   Wechsel : constant WechselArray := (
                                       'a' => SpeziesDatentypen.Menschen_Enum,
                                       'b' => SpeziesDatentypen.Kasrodiah_Enum,
                                       'c' => SpeziesDatentypen.Lasupin_Enum,
                                       'd' => SpeziesDatentypen.Lamustra_Enum,
                                       'e' => SpeziesDatentypen.Manuky_Enum,
                                       'f' => SpeziesDatentypen.Suroka_Enum,
                                       'g' => SpeziesDatentypen.Pryolon_Enum,
                                       'h' => SpeziesDatentypen.Moru_Phisihl_Enum,
                                       'i' => SpeziesDatentypen.Larinos_Lotaris_Enum,
                                       'j' => SpeziesDatentypen.Carupex_Enum,
                                       'k' => SpeziesDatentypen.Alary_Enum,
                                       'l' => SpeziesDatentypen.Natries_Zermanis_Enum,
                                       'm' => SpeziesDatentypen.Tridatus_Enum,
                                       'n' => SpeziesDatentypen.Senelari_Enum,
                                       'o' => SpeziesDatentypen.Aspari_2_Enum,
                                       'p' => SpeziesDatentypen.Ekropa_Enum,
                                       'q' => SpeziesDatentypen.Tesorahn_Enum,
                                       'r' => SpeziesDatentypen.Talbidahr_Enum
                                      );

   procedure KarteAufdecken
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

   procedure DiplomatischenStatusÄndern
     (NeuerStatusExtern : in DiplomatieDatentypen.Status_Untereinander_Enum);

   procedure MenschKITauschen
     (TasteExtern : in Wide_Wide_Character);

end DebugmenueLogik;
