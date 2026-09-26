with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

private with Ada.Strings.Wide_Wide_Unbounded;

private with Menuetexte;

package EinlesenTextMenuesLogik is
   pragma Elaborate_Body;
   
   procedure Menüs
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);

private
   use Ada.Strings.Wide_Wide_Unbounded;
   
   Hauptmenü : constant Positive := Menuetexte.Hauptmenü'Last;
   Spielmenü : constant Positive := Hauptmenü + Menuetexte.Spielmenü'Last;
   Optionsmenü : constant Positive := Spielmenü + Menuetexte.Optionsmenü'Last;
   Grafikmenü : constant Positive := Optionsmenü + Menuetexte.Grafikmenü'Last;
   Soundmenü : constant Positive := Grafikmenü + Menuetexte.Soundmenü'Last;
   Steuerungsmenü : constant Positive := Soundmenü + Menuetexte.Steuerungsmenü'Last;
   Sonstigesmenü : constant Positive := Steuerungsmenü + Menuetexte.Spieleinstellungsmenü'Last;
   Kartengröße : constant Positive := Sonstigesmenü + Menuetexte.Kartengröße'Last;
   Kartenebene : constant Positive := Kartengröße + Menuetexte.Kartenebene'Last;
   Kartenart : constant Positive := Kartenebene + Menuetexte.Kartenart'Last;
   Kartentemperatur : constant Positive := Kartenart + Menuetexte.Kartentemperatur'Last;
   Speziesauswahl : constant Positive := Kartentemperatur + Menuetexte.Speziesauswahl'Last;
   Schwierigkeitsgrad : constant Positive := Speziesauswahl + Menuetexte.Schwierigkeitsgrad'Last;
   Kartenform : constant Positive := Schwierigkeitsgrad + Menuetexte.Kartenform'Last;
   Rohstoffemenge : constant Positive := Kartenform + Menuetexte.Rohstoffemenge'Last;
   Diplomatiemenü : constant Positive := Rohstoffemenge + Menuetexte.Diplomatiemenü'Last;
   Einstellungsmenü : constant Positive := Diplomatiemenü + Menuetexte.Einstellungsmenü'Last;
   Kartenpole : constant Positive := Einstellungsmenü + Menuetexte.Kartenpole'Last;
   Spielstandmenü : constant Positive := Kartenpole + Menuetexte.Spielstandmenü'Last;
   Editorenmenü : constant Positive := Spielstandmenü + Menuetexte.Editorenmenü'Last;
   Handelsmenü : constant Positive := Editorenmenü + Menuetexte.Handelsmenü'Last;
   
   EinzulesendeZeile : Positive;
   AktuelleZeile : Positive;
   
   Zwischenspeicher : Unbounded_Wide_Wide_String;

end EinlesenTextMenuesLogik;
