private with Ada.Wide_Wide_Text_IO;
private with Ada.Strings.Wide_Wide_Unbounded;

private with Sf.Graphics;
private with Sf;
private with Sf.Graphics.Texture;

private with SpeziesDatentypen;

package EinlesenTexturenLogik is
   pragma Elaborate_Body;

   procedure EinlesenTexturen;

private
   use Ada.Wide_Wide_Text_IO;
   use Ada.Strings.Wide_Wide_Unbounded;

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
   Allgemeines : constant Positive := Kartenformen + 1;
   PZBEnde : constant Positive := Allgemeines + 1;

   HintergründeAnfang : constant Positive := PZBEnde + 1;
   HintergründeEnde : constant Positive := PZBEnde + SpeziesDatentypen.SpeziesnummernVorhanden'Last;

   EinheitenAnfang : constant Positive := HintergründeEnde + 1;
   EinheitenEnde : constant Positive := HintergründeEnde + SpeziesDatentypen.SpeziesnummernVorhanden'Last;

   GebäudeAnfang : constant Positive := EinheitenEnde + 1;
   GebäudeEnde : constant Positive := EinheitenEnde + SpeziesDatentypen.SpeziesnummernVorhanden'Last;

   AktuelleZeile : Positive;
   EinzulesendeZeile : Positive;

   Dateiname : Unbounded_Wide_Wide_String;
   GesamterPfad : Unbounded_Wide_Wide_String;

   DateiTexturen : File_Type;

   MaximaleTexturengröße : constant Sf.sfUint32 := Sf.Graphics.Texture.getMaximumSize;



   function TexturFestlegen
     (TexturenAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      TexturenpfadExtern : in String)
      return Sf.Graphics.sfTexture_Ptr
     with
       Pre => (
                 TexturenpfadExtern'Length > 0
              );

end EinlesenTexturenLogik;
