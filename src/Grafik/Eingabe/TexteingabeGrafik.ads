with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Sf.Window.Event;

package TexteingabeGrafik is
   pragma Elaborate_Body;

   procedure Texteingabe;

private
   
   EingegebenesZeichen : Wide_Wide_Character;
   
   Text : Unbounded_Wide_Wide_String;

   TextEingegeben : Sf.Window.Event.sfEvent;

   procedure ZeichenEntfernen;
   procedure Abbruch;

   procedure ZeichenHinzufügen
     (EingegebenesZeichenExtern : in Wide_Wide_Character);
   
   
   
   function Spielstandnamen
     (EingegebenesZeichenExtern : in Wide_Wide_Character)
      return Boolean;
   
end TexteingabeGrafik;
