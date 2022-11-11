with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;

private with RueckgabeDatentypen;
private with DiplomatieDatentypen;

package DebugmenueLogik is
   pragma Elaborate_Body;

   procedure Debugmenü
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );

private

   Taste : Wide_Wide_Character;

   RückgabeDebugmenü : RueckgabeDatentypen.Rückgabe_Werte_Enum;

   WelcherText : Positive;

   type WechselArray is array (Wide_Wide_Character'Val (Wide_Wide_Character'Pos ('a')) .. Wide_Wide_Character'Val (Wide_Wide_Character'Pos ('r'))) of RassenDatentypen.Rassen_Verwendet_Enum;
   Wechsel : constant WechselArray := (
                                       'a' => RassenDatentypen.Menschen_Enum,
                                       'b' => RassenDatentypen.Kasrodiah_Enum,
                                       'c' => RassenDatentypen.Lasupin_Enum,
                                       'd' => RassenDatentypen.Lamustra_Enum,
                                       'e' => RassenDatentypen.Manuky_Enum,
                                       'f' => RassenDatentypen.Suroka_Enum,
                                       'g' => RassenDatentypen.Pryolon_Enum,
                                       'h' => RassenDatentypen.Moru_Phisihl_Enum,
                                       'i' => RassenDatentypen.Larinos_Lotaris_Enum,
                                       'j' => RassenDatentypen.Carupex_Enum,
                                       'k' => RassenDatentypen.Alary_Enum,
                                       'l' => RassenDatentypen.Natries_Zermanis_Enum,
                                       'm' => RassenDatentypen.Tridatus_Enum,
                                       'n' => RassenDatentypen.Senelari_Enum,
                                       'o' => RassenDatentypen.Aspari_2_Enum,
                                       'p' => RassenDatentypen.Ekropa_Enum,
                                       'q' => RassenDatentypen.Tesorahn_Enum,
                                       'r' => RassenDatentypen.Talbidahr_Enum
                                      );

   procedure KarteAufdecken
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );

   procedure DiplomatischenStatusÄndern
     (NeuerStatusExtern : in DiplomatieDatentypen.Status_Untereinander_Enum);

   procedure MenschKITauschen
     (TasteExtern : in Wide_Wide_Character);

end DebugmenueLogik;
