with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Ada.Directories;

with SystemRecordsHTSEB;

package VerzeichnisDateinamentestsHTSEB is
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
      return SystemRecordsHTSEB.TextEingabeRecord
     with
       Pre => (
                 To_Wide_Wide_String (Source => TextExtern)'Length > 0
              ),

       Post => (
                  if Namensprüfungen'Result.ErfolgreichAbbruch = True then To_Wide_Wide_String (Source => Namensprüfungen'Result.EingegebenerText)'Length > 0
               );

private
   use Ada.Directories;

   Erlaubt : Boolean;

   LängeAktuellesVerzeichnis : constant Positive := Current_Directory'Length;

   DreierText : Wide_Wide_String (1 .. 3);
   ViererText : Wide_Wide_String (1 .. 4);
   FünferText : Wide_Wide_String (1 .. 5);

   Text : Unbounded_Wide_Wide_String;

  -- type ZeichenabzugArray is array (BetriebssystemDatentypenHTSEB.Betriebsystem_Zeichenabzug_Enum'Range, SystemDatentypen.Zeichenabzug_Enum'Range) of Natural;
  -- Zeichenabzug : constant ZeichenabzugArray := (BetriebssystemDatentypenHTSEB.Windows_Enum =>
  --                                                 (
  --                                                  SystemDatentypen.Speichern_Enum => VerzeichnisKonstanten.ExtrazeichenSpielstand,
  --                                                  SystemDatentypen.Text_Enum      => 0,
   --                                                 SystemDatentypen.Texturen_Enum  => 0
   --                                                )
   --                                             );



   function NamenprüfungenWindows
     (TextExtern : in Unbounded_Wide_Wide_String)
      return SystemRecordsHTSEB.TextEingabeRecord
     with
       Pre => (
                 To_Wide_Wide_String (Source => TextExtern)'Length > 0
              ),

       Post => (
                  if NamenprüfungenWindows'Result.ErfolgreichAbbruch = True then To_Wide_Wide_String (Source => NamenprüfungenWindows'Result.EingegebenerText)'Length > 0
               );

end VerzeichnisDateinamentestsHTSEB;
