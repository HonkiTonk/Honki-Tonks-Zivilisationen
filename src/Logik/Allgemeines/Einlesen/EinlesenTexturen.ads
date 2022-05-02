pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with TextKonstanten;

with EingeleseneTexturenSFML;

package EinlesenTexturen is

   procedure EinlesenTexturen;

private

   ------------------- Das hier mal in Bereiche aufteilen um die Zeilenanzahl in der adb ein wenig zu verringern?
   ------------------- Wenn dann in die gleichen Bereiche wie in EingeleseneTexturenSFML.

   AktuelleZeile : Positive;

   DateiTextEinlesen : File_Type;

   type MenüHintergrundEinlesenArray is array (EingeleseneTexturenSFML.MenüHintergrundAccessArray'Range) of Unbounded_Wide_Wide_String;
   MenüHintergrundEinlesen : MenüHintergrundEinlesenArray := (others => TextKonstanten.LeerUnboundedString);

   type KartenfelderEinlesenArray is array (EingeleseneTexturenSFML.KartenfelderAccessArray'Range) of Unbounded_Wide_Wide_String;
   KartenfelderEinlesen : KartenfelderEinlesenArray := (others => TextKonstanten.LeerUnboundedString);

   type KartenflüsseEinlesenArray is array (EingeleseneTexturenSFML.KartenflussAccessArray'Range) of Unbounded_Wide_Wide_String;
   KartenflüsseEinlesen : KartenflüsseEinlesenArray := (others => TextKonstanten.LeerUnboundedString);

   type KartenressourcenEinlesenArray is array (EingeleseneTexturenSFML.KartenressourcenAccessArray'Range) of Unbounded_Wide_Wide_String;
   KartenressourcenEinlesen : KartenressourcenEinlesenArray := (others => TextKonstanten.LeerUnboundedString);

   type VerbesserungenEinlesenArray is array (EingeleseneTexturenSFML.VerbesserungenAccessArray'Range) of Unbounded_Wide_Wide_String;
   VerbesserungenEinlesen : VerbesserungenEinlesenArray := (others => TextKonstanten.LeerUnboundedString);

   type WegeEinlesenArray is array (EingeleseneTexturenSFML.WegeAccessArray'Range) of Unbounded_Wide_Wide_String;
   WegeEinlesen : WegeEinlesenArray := (others => TextKonstanten.LeerUnboundedString);

   type EinheitenEinlesenArray is array (EingeleseneTexturenSFML.EinheitenAccesArray'Range (1), EingeleseneTexturenSFML.EinheitenAccesArray'Range (2)) of Unbounded_Wide_Wide_String;
   EinheitenEinlesen : EinheitenEinlesenArray := (others => (others => TextKonstanten.LeerUnboundedString));

   type GebäudeEinlesenArray is array (EingeleseneTexturenSFML.GebäudeAccessArray'Range (1), EingeleseneTexturenSFML.GebäudeAccessArray'Range (2)) of Unbounded_Wide_Wide_String;
   GebäudeEinlesen : GebäudeEinlesenArray := (others => (others => TextKonstanten.LeerUnboundedString));

   procedure EinlesenMenüHintergrund;
   procedure EinlesenKartenfelder;
   procedure EinlesenKartenflüsse;
   procedure EinlesenKartenressourcen;
   procedure EinlesenVerbesserungen;
   procedure EinlesenWege;
   procedure EinlesenEinheiten;
   procedure EinlesenGebäude;

end EinlesenTexturen;
