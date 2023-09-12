with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with SpeziesDatentypen;
private with TextArrays;
private with EingeleseneTexturenGrafik;

package EinlesenTexturenLogik is
   pragma Elaborate_Body;

   procedure EinlesenTexturen;

private

   Basisgrund : constant Positive := EingeleseneTexturenGrafik.BasisgrundAccessArray'Length;
   Zusatzgrund : constant Positive := Basisgrund + EingeleseneTexturenGrafik.ZusatzgrundAccessArray'Length;
   Flüsse : constant Positive := Zusatzgrund + EingeleseneTexturenGrafik.KartenflussAccessArray'Length;
   Ressourcen : constant Positive := Flüsse + EingeleseneTexturenGrafik.KartenressourcenAccessArray'Length;
   Feldeffekte : constant Positive := Ressourcen + EingeleseneTexturenGrafik.FeldeffekteAccessArray'Length;
   Verbesserungen : constant Positive := Feldeffekte + EingeleseneTexturenGrafik.VerbesserungenAccessArray'Length;
   Wege : constant Positive := Verbesserungen + EingeleseneTexturenGrafik.WegeAccessArray'Length;
   System : constant Positive := Wege + EingeleseneTexturenGrafik.SystemAccessArray'Length;
   Hintergrund : constant Positive := System + EingeleseneTexturenGrafik.HintergrundAccessArray'Length;

   AktuelleZeile : Positive;
   EinzulesendeZeile : Positive;
   ZeileSpezieshintergrund : Positive;
   ZeileEinheiten : Positive;
   ZeileGebäude : Positive;

   Verzeichnisname : Unbounded_Wide_Wide_String;
   Zwischenspeicher : Unbounded_Wide_Wide_String;

   DateiKarte : File_Type;
   DateiSystem : File_Type;
   DateiHintergrund : File_Type;
   DateiKartenfelder : File_Type;
   DateiKartenflüsse : File_Type;
   DateiKartenressourcen : File_Type;
   DateiVerbesserungen : File_Type;
   DateiWege : File_Type;
   DateiSpezies : File_Type;
   DateiSpezieshintergründe : File_Type;
   DateiEinheiten : File_Type;
   DateiGebäude : File_Type;

   Speziesverzeichnisse : TextArrays.AllgemeinesTextArray (1 .. 3);

   procedure Spezies;
   procedure Karte;

   procedure Spezieshintergrund
     (DateipfadExtern : in Wide_Wide_String;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 DateipfadExtern'Length > 0
              );

   procedure Einheiten
     (DateipfadExtern : in Wide_Wide_String;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 DateipfadExtern'Length > 0
              );

   procedure Gebäude
     (DateipfadExtern : in Wide_Wide_String;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 DateipfadExtern'Length > 0
              );

end EinlesenTexturenLogik;
