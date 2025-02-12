with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Window.Keyboard;
with Sf.Window.Mouse;

with SystemRecordsHTSEB;

package SchreibeLogiktask is
   pragma Elaborate_Body;
   
   procedure WartenSound
     (ZustandExtern : in Boolean);
   
   procedure WartenMusik
     (ZustandExtern : in Boolean);
   
   procedure WartenGrafik
     (ZustandExtern : in Boolean);

   procedure WartenIntro
     (ZustandExtern : in Boolean);
   
   procedure Tastaturtaste
     (TasteExtern : in Sf.Window.Keyboard.sfKeyCode);
   
   procedure Maustaste
     (TasteExtern : in Sf.Window.Mouse.sfMouseButton);
   
   procedure ErfolgTexteingabe
     (ErfolgExtern : in Boolean);
   
   procedure Texteingabe
     (TextExtern : in Unbounded_Wide_Wide_String);
   
   procedure KompletteTexteingabe
     (EingabeExtern : in SystemRecordsHTSEB.TextEingabeRecord);

end SchreibeLogiktask;
