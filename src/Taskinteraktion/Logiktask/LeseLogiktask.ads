with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Window.Keyboard;
with Sf.Window.Mouse;

with SystemRecordsHTSEB;

package LeseLogiktask is
   pragma Elaborate_Body;
   
   function WartenSound
     return Boolean;
   
   function WartenMusik
     return Boolean;
   
   function WartenGrafik
     return Boolean;

   function WartenIntro
     return Boolean;
   
   function Tastaturtaste
     return Sf.Window.Keyboard.sfKeyCode;
   
   function Maustaste
     return Sf.Window.Mouse.sfMouseButton;
   
   function ErfolgTexteingabe
     return Boolean;
   
   function Texteingabe
     return Unbounded_Wide_Wide_String;
   
   function KompletteTexteingabe
     return SystemRecordsHTSEB.TextEingabeRecord;
   
end LeseLogiktask;
