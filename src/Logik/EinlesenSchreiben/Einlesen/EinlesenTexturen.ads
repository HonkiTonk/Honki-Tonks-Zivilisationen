pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with KartenDatentypen;
with SystemKonstanten;

package EinlesenTexturen is

   procedure EinlesenTexturen;

private

   AktuelleZeile : Positive;

   DateiTextEinlesen : File_Type;

   -- Das hier mal an die Länge in EingeleseneTexturen anpassen.
   type KartenfelderEinlesenArray is array (KartenDatentypen.Test'Range) of Unbounded_Wide_Wide_String;
   KartenfelderEinlesen : KartenfelderEinlesenArray := (others => SystemKonstanten.LeerUnboundedString);

   procedure EinlesenHintergrundMenüs;
   procedure EinlesenKartenfelder;



   function VorzeitigesZeilenende
     (AktuelleZeileExtern : in Positive)
      return Boolean;

end EinlesenTexturen;
