with Ada.Calendar; use Ada.Calendar;

package BildrateAnzeigenGrafik is
   pragma Elaborate_Body;

   procedure Bildrate;
   
private
   
   AktuelleBildrate : Float;
   
   LetzteZeit : Time := Clock;
   
   procedure Terminalanzeige
     (BildrateExtern : in Float)
     with
       Pre => (
                 BildrateExtern > 0.00
              );
   
   procedure SFMLAnzeige
     (BildrateExtern : in Float)
     with
       Pre => (
                 BildrateExtern > 0.00
              );

end BildrateAnzeigenGrafik;
