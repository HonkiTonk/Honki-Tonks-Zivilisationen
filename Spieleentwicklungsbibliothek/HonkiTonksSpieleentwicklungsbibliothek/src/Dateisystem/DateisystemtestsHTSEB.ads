with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Ada.Directories;

with SystemRecordsHTSEB;

package DateisystemtestsHTSEB is
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
       Post => (
                  if Namensprüfungen'Result.ErfolgreichAbbruch = True then To_Wide_Wide_String (Source => Namensprüfungen'Result.EingegebenerText)'Length > 0
               );

private
   use Ada.Directories;

   LängeAktuellesVerzeichnis : constant Positive := Current_Directory'Length;

   Zwischenspeicher : Wide_Wide_String (1 .. 3);

   FünferText : Wide_Wide_String (1 .. 5);

   Text : Unbounded_Wide_Wide_String;



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

   function PrüfungDrei
     (TextExtern : in Wide_Wide_String;
      VerbotenerTextExtern : in Wide_Wide_String)
      return Boolean
     with
       Pre => (
                 VerbotenerTextExtern'Length in 3 .. 5
              );

end DateisystemtestsHTSEB;
