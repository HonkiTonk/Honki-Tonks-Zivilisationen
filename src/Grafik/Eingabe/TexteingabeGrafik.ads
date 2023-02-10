private with Sf.Window.Event;

package TexteingabeGrafik is
   pragma Elaborate_Body;

   procedure Texteingabe;

private

   EingegebenesZeichen : Wide_Wide_Character;

   CharacterZuText : Wide_Wide_String (1 .. 1);

   TextEingegeben : Sf.Window.Event.sfEvent;

   procedure ZeichenHinzufügen
     (EingegebenesZeichenExtern : in Wide_Wide_Character);

   procedure ZeichenEntfernen;
   
end TexteingabeGrafik;
