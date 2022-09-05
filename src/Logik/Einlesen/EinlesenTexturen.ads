pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with TextKonstanten;
private with RassenDatentypen;

private with EingeleseneTexturenGrafik;

package EinlesenTexturen is

   procedure EinlesenTexturen;

private

   -- Das hier mal in Bereiche aufteilen um die Zeilenanzahl in der adb ein wenig zu verringern? äöü
   -- Wenn dann in die gleichen Bereiche wie in EingeleseneTexturenGrafik. äöü

   AktuelleZeile : Positive;
   ZeileRassenhintergrund : Positive;
   ZeileEinheiten : Positive;
   ZeileGebäude : Positive;

   DateiHintergrund : File_Type;
   DateiKartenfelder : File_Type;
   DateiKartenflüsse : File_Type;
   DateiKartenressourcen : File_Type;
   DateiVerbesserungen : File_Type;
   DateiWege : File_Type;
   DateiRassen : File_Type;
   DateiRassenhintergründe : File_Type;
   DateiEinheiten : File_Type;
   DateiGebäude : File_Type;

   type HintergrundEinlesenArray is array (EingeleseneTexturenGrafik.HintergrundAccessArray'Range) of Unbounded_Wide_Wide_String;
   HintergrundEinlesen : HintergrundEinlesenArray := (others => TextKonstanten.LeerUnboundedString);

   type KartenfelderEinlesenArray is array (EingeleseneTexturenGrafik.KartenfelderAccessArray'Range) of Unbounded_Wide_Wide_String;
   KartenfelderEinlesen : KartenfelderEinlesenArray := (others => TextKonstanten.LeerUnboundedString);

   type KartenflüsseEinlesenArray is array (EingeleseneTexturenGrafik.KartenflussAccessArray'Range) of Unbounded_Wide_Wide_String;
   KartenflüsseEinlesen : KartenflüsseEinlesenArray := (others => TextKonstanten.LeerUnboundedString);

   type KartenressourcenEinlesenArray is array (EingeleseneTexturenGrafik.KartenressourcenAccessArray'Range) of Unbounded_Wide_Wide_String;
   KartenressourcenEinlesen : KartenressourcenEinlesenArray := (others => TextKonstanten.LeerUnboundedString);

   type VerbesserungenEinlesenArray is array (EingeleseneTexturenGrafik.VerbesserungenAccessArray'Range) of Unbounded_Wide_Wide_String;
   VerbesserungenEinlesen : VerbesserungenEinlesenArray := (others => TextKonstanten.LeerUnboundedString);

   type WegeEinlesenArray is array (EingeleseneTexturenGrafik.WegeAccessArray'Range) of Unbounded_Wide_Wide_String;
   WegeEinlesen : WegeEinlesenArray := (others => TextKonstanten.LeerUnboundedString);

   type RassenEinlesenArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, 1 .. 3) of Unbounded_Wide_Wide_String;
   RassenEinlesen : RassenEinlesenArray := (others => (others => TextKonstanten.LeerUnboundedString));

   type RassenhintergrundEinlesenArray is array (EingeleseneTexturenGrafik.RassenhintergrundAccessArray'Range (1), EingeleseneTexturenGrafik.RassenhintergrundAccessArray'Range (2)) of Unbounded_Wide_Wide_String;
   RassenhintergrundEinlesen : RassenhintergrundEinlesenArray := (others => (others => TextKonstanten.LeerUnboundedString));

   type EinheitenEinlesenArray is array (EingeleseneTexturenGrafik.EinheitenAccesArray'Range (1), EingeleseneTexturenGrafik.EinheitenAccesArray'Range (2)) of Unbounded_Wide_Wide_String;
   EinheitenEinlesen : EinheitenEinlesenArray := (others => (others => TextKonstanten.LeerUnboundedString));

   type GebäudeEinlesenArray is array (EingeleseneTexturenGrafik.GebäudeAccessArray'Range (1), EingeleseneTexturenGrafik.GebäudeAccessArray'Range (2)) of Unbounded_Wide_Wide_String;
   GebäudeEinlesen : GebäudeEinlesenArray := (others => (others => TextKonstanten.LeerUnboundedString));

   procedure EinlesenHintergrund;
   procedure EinlesenKartenfelder;
   procedure EinlesenKartenflüsse;
   procedure EinlesenKartenressourcen;
   procedure EinlesenVerbesserungen;
   procedure EinlesenWege;
   procedure EinlesenRassen;
   procedure EinlesenRassenhintergrund
     (DateipfadExtern : in Wide_Wide_String;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 DateipfadExtern'Length > 0
              );

   procedure EinlesenEinheiten
     (DateipfadExtern : in Wide_Wide_String;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 DateipfadExtern'Length > 0
              );

   procedure EinlesenGebäude
     (DateipfadExtern : in Wide_Wide_String;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 DateipfadExtern'Length > 0
              );

end EinlesenTexturen;
