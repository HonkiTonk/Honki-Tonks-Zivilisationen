pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Window.Event;
with Sf.Window.Keyboard;
with Sf.Window.Mouse;

package EingabeSystemeSFML is

   MausBewegt : Boolean;

   MausRad : Float;

   TastaturTaste : Sf.Window.Keyboard.sfKeyCode;

   MausTaste : Sf.Window.Mouse.sfMouseButton;

   EingegebenerName : Unbounded_Wide_Wide_String;

   procedure TastenEingabe;



   function TextEingeben
     return Unbounded_Wide_Wide_String;

private

   EingegebenesZeichen : Wide_Wide_Character;

   Mausbewegungen : Natural;

   CharacterZuText : Wide_Wide_String (1 .. 1);

   ZeichenEingeben : Sf.Window.Event.sfEvent;

   TextEingegeben : Sf.Window.Event.sfEvent;

   procedure TextPrüfen
     (UnicodeNummerExtern : in Sf.sfUint32);

   procedure ZeichenHinzufügen
     (EingegebenesZeichenExtern : in Wide_Wide_Character);

   procedure ZeichenEntfernen;

end EingabeSystemeSFML;
