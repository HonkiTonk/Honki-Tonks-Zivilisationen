with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with SpeziesDatentypen;

package EinlesenTexturenLogik is
   pragma Elaborate_Body;

   procedure EinlesenTexturen;

private

   Basisgrund : constant Positive := 1;
   Zusatzgrund : constant Positive := Basisgrund + 1;
   Flüsse : constant Positive := Zusatzgrund + 1;
   Ressourcen : constant Positive := Flüsse + 1;
   Verbesserungen : constant Positive := Ressourcen + 1;
   Wege : constant Positive := Verbesserungen + 1;
   Feldeffekte : constant Positive := Wege + 1;
   Einheitenbefehle : constant Positive := Feldeffekte + 1;
   Kartenbefehle : constant Positive := Einheitenbefehle + 1;
   RoterKnopf : constant Positive := Kartenbefehle + 1;
   Intro : constant Positive := RoterKnopf + 1;
   Kartenformen : constant Positive := Intro + 1;
   Seitenleiste : constant Positive := Kartenformen + 1;
   Menüs : constant Positive := Seitenleiste + 1;
   PZBEnde : constant Positive := Menüs + 1;
   Auswahl : constant Positive := PZBEnde + 1;
   Meldung : constant Positive := Auswahl + 1;

   HintergründeAnfang : constant Positive := Meldung + 1;
   HintergründeEnde : constant Positive := Meldung + SpeziesDatentypen.SpeziesnummernVorhanden'Last;

   EinheitenAnfang : constant Positive := HintergründeEnde + 1;
   EinheitenEnde : constant Positive := HintergründeEnde + SpeziesDatentypen.SpeziesnummernVorhanden'Last;

   GebäudeAnfang : constant Positive := EinheitenEnde + 1;
   GebäudeEnde : constant Positive := EinheitenEnde + SpeziesDatentypen.SpeziesnummernVorhanden'Last;

   AktuelleZeile : Positive;
   EinzulesendeZeile : Positive;

   Dateiname : Unbounded_Wide_Wide_String;
   GesamterPfad : Unbounded_Wide_Wide_String;

   DateiTexturen : File_Type;

end EinlesenTexturenLogik;
