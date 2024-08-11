with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Directories; use Ada.Directories;

private with SystemDatentypen;
private with VerzeichnisKonstanten;
private with BetriebssystemDatentypen;

package VerzeichnisDateinamenTests is
   pragma Elaborate_Body;

   function GültigeZeichenlänge
     (LinuxTextExtern : in Unbounded_Wide_Wide_String;
      WindowsTextExtern : in Unbounded_Wide_Wide_String)
      return Boolean
     with
       Pre => (
                 To_Wide_Wide_String (Source => WindowsTextExtern)'Length >= To_Wide_Wide_String (Source => LinuxTextExtern)'Length
              );

   function Standardeinleseprüfung
     (VerzeichnisDateinameExtern : in Wide_Wide_String)
      return Boolean
     with
       Pre => (
                 VerzeichnisDateinameExtern'Length > 0
              );

   function StandardeinleseprüfungNeu
     (LinuxTextExtern : in Wide_Wide_String;
      WindowsTextExtern : in Wide_Wide_String)
      return Boolean
     with
       Pre => (
                 WindowsTextExtern'Length >= LinuxTextExtern'Length
              );

   function StandardwerteEinleseprüfung
     (LinuxTextExtern : in Wide_Wide_String;
      WindowsTextExtern : in Wide_Wide_String)
      return Boolean
     with
       Pre => (
                 WindowsTextExtern'Length > 0
               and
                 WindowsTextExtern'Length >= LinuxTextExtern'Length
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

   LängeAktuellesVerzeichnis : constant Positive := Current_Directory'Length;

   Text : Unbounded_Wide_Wide_String;

   type ZeichenabzugArray is array (BetriebssystemDatentypen.Betriebsystem_Zeichenabzug_Enum'Range, SystemDatentypen.Zeichenabzug_Enum'Range) of Natural;
   Zeichenabzug : constant ZeichenabzugArray := (BetriebssystemDatentypen.Windows_Enum =>
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
