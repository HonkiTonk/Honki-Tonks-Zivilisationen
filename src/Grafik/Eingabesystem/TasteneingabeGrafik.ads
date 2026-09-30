private with Sf.Window.Event;

package TasteneingabeGrafik is
   pragma Elaborate_Body;

   procedure Tasteneingabe;
   
private
   
   Nutzereingabe : Sf.Window.Event.sfEvent;
   Fensteranpassung : Sf.Window.Event.sfEvent;

end TasteneingabeGrafik;
