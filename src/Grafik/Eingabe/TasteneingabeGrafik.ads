pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Window.Event;

package TasteneingabeGrafik is

   procedure Tasteneingabe;
   procedure FensterAnpassen;
   
private
   
   Nutzereingabe : Sf.Window.Event.sfEvent;
   Fensteranpassung : Sf.Window.Event.sfEvent;

end TasteneingabeGrafik;
