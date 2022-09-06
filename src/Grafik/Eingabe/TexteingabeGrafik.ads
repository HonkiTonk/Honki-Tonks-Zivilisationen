pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.Window.Event;

package TexteingabeGrafik is

   procedure Texteingabe;

private

   MaximaleZeichenlängeDateisystem : constant Positive := 256;

   EingegebenesZeichen : Wide_Wide_Character;

   CharacterZuText : Wide_Wide_String (1 .. 1);

   TextEingegeben : Sf.Window.Event.sfEvent;

   procedure ZeichenHinzufügen
     (EingegebenesZeichenExtern : in Wide_Wide_Character);

   procedure ZeichenEntfernen;
   
end TexteingabeGrafik;