pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.Window.Event;

package EingabesystemeGrafik is

   procedure TastenEingabe;
   procedure TextEingeben;
   procedure FensterAnpassen;

private

   MaximaleZeichenlängeDateisystem : constant Positive := 256;

   EingegebenesZeichen : Wide_Wide_Character;

   CharacterZuText : Wide_Wide_String (1 .. 1);

   Nutzereingabe : Sf.Window.Event.sfEvent;
   TextEingegeben : Sf.Window.Event.sfEvent;
   Fensteranpassung : Sf.Window.Event.sfEvent;

   procedure TextPrüfen
     (UnicodeNummerExtern : in Sf.sfUint32);

   procedure ZeichenHinzufügen
     (EingegebenesZeichenExtern : in Wide_Wide_Character);

   procedure ZeichenEntfernen;

end EingabesystemeGrafik;
