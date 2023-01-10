with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with SpeziesDatentypen;

package EinlesenTexturenLogik is
   pragma Elaborate_Body;

   procedure EinlesenTexturen;

private

   -- Das hier mal in Bereiche aufteilen um die Zeilenanzahl in der adb ein wenig zu verringern? äöü
   -- Wenn dann in die gleichen Bereiche wie in EingeleseneTexturenGrafik. äöü

   AktuelleZeile : Positive;
   ZeileSpezieshintergrund : Positive;
   ZeileEinheiten : Positive;
   ZeileGebäude : Positive;

   Verzeichnisname : Unbounded_Wide_Wide_String;

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

   type SpeziesverzeichnisseArray is array (1 .. 3) of Unbounded_Wide_Wide_String;
   Speziesverzeichnisse : SpeziesverzeichnisseArray;

   procedure EinlesenSystem;
   procedure EinlesenHintergrund;
   procedure EinlesenKartenfelder;
   procedure EinlesenKartenflüsse;
   procedure EinlesenKartenressourcen;
   procedure EinlesenVerbesserungen;
   procedure EinlesenWege;
   procedure EinlesenSpezies;

   procedure EinlesenSpezieshintergrund
     (DateipfadExtern : in Wide_Wide_String;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 DateipfadExtern'Length > 0
              );

   procedure EinlesenEinheiten
     (DateipfadExtern : in Wide_Wide_String;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 DateipfadExtern'Length > 0
              );

   procedure EinlesenGebäude
     (DateipfadExtern : in Wide_Wide_String;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 DateipfadExtern'Length > 0
              );

end EinlesenTexturenLogik;
