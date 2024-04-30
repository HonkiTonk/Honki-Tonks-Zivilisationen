with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemDatentypen;

private with VerzeichnisKonstanten;

package VerzeichnisDateinamenTests is
   pragma Elaborate_Body;

   function GültigeZeichenlänge
     (TextExtern : in Unbounded_Wide_Wide_String;
      ZeichenabzugExtern : in SystemDatentypen.Zeichenabzug_Enum)
      return Boolean
     with
       Pre => (
                 To_Wide_Wide_String (Source => TextExtern)'Length > 0
              );

   function Standardeinleseprüfung
     (VerzeichnisDateinameExtern : in Wide_Wide_String)
      return Boolean
     with
       Pre => (
                 VerzeichnisDateinameExtern'Length > 0
              );

   function GültigesZeichen
     (ZeichenExtern : in Wide_Wide_Character)
      return Boolean;

   function GültigerNamen
     (NameExtern : in Wide_Wide_String)
      return Boolean
     with
       Pre => (
                 NameExtern'Length > 0
              );

   function Namensprüfungen
     (TextExtern : in Unbounded_Wide_Wide_String)
      return Boolean
     with
       Pre => (
                 To_Wide_Wide_String (Source => TextExtern)'Length > 0
              );

private

   Erlaubt : Boolean;

   Text : Unbounded_Wide_Wide_String;

   type ZeichenabzugArray is array (SystemDatentypen.Betriebsystem_Zeichenabzug_Enum'Range, SystemDatentypen.Zeichenabzug_Enum'Range) of Natural;
   Zeichenabzug : constant ZeichenabzugArray := (SystemDatentypen.Windows_Enum =>
                                                   (
                                                    SystemDatentypen.Speichern_Enum => VerzeichnisKonstanten.ExtrazeichenSpielstand,
                                                    SystemDatentypen.Text_Enum      => 0,
                                                    SystemDatentypen.Texturen_Enum  => 0
                                                   )
                                                );



   function NamenprüfungenWindows
     (TextExtern : in Unbounded_Wide_Wide_String)
      return Boolean
     with
       Pre => (
                 To_Wide_Wide_String (Source => TextExtern)'Length > 0
              );

end VerzeichnisDateinamenTests;
