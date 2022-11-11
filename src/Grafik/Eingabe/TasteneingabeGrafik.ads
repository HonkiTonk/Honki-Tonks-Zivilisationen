with Sf.Window.Event;

package TasteneingabeGrafik is
   pragma Elaborate_Body;

   procedure Tasteneingabe;
   procedure FensterAnpassen;
   
private
   
   Nutzereingabe : Sf.Window.Event.sfEvent;
   Fensteranpassung : Sf.Window.Event.sfEvent;

end TasteneingabeGrafik;
