private with Sf.Window.Event;

package TexteingabeGrafik is
   pragma Elaborate_Body;

   procedure Texteingabe;

private
   
   Erlaubt : Boolean;

   EingegebenesZeichen : Wide_Wide_Character;

   TextEingegeben : Sf.Window.Event.sfEvent;

   procedure ZeichenHinzufügen
     (EingegebenesZeichenExtern : in Wide_Wide_Character);

   procedure ZeichenEntfernen;
   
   
   
   function Spielstandnamen
     (EingegebenesZeichenExtern : in Wide_Wide_Character)
      return Boolean;
   
   function SpielstandnamenLinux
     (EingegebenesZeichenExtern : in Wide_Wide_Character)
      return Boolean;
     
   function SpielstandnamenWindows
     (EingegebenesZeichenExtern : in Wide_Wide_Character)
      return Boolean;
   
   function Extraprüfungen
     return Boolean;
   
   function ExtraprüfungenWindows
     return Boolean;
   
end TexteingabeGrafik;
