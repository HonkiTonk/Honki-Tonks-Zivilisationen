with Sf.Graphics;
with Sf.System.Vector2;

private with Sf.Window;
private with Sf.Window.Window;

with GrafikDatentypen;

package FensterGrafik is
   pragma Elaborate_Body;
   use type Sf.Graphics.sfRenderWindow_Ptr;

   procedure FensterAnpassen
     (FensterVerändertExtern : in GrafikDatentypen.Fenster_Anpassen_Enum);
   
   procedure BildrateÄndern;
   procedure FensterErzeugen;
   procedure FensterEntfernen;
   procedure FensterLeeren;
   procedure FensterAnzeigen;
   
   
   
   function FensterLesen
     return Sf.Graphics.sfRenderWindow_Ptr
     with
       Post => (
                  FensterLesen'Result /= null
               );
   
   function AktuelleAuflösung
     return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  AktuelleAuflösung'Result.x > 0.00
                and
                  AktuelleAuflösung'Result.y > 0.00
               );

private
   
   Fenstermodus : Sf.Window.Window.sfWindowStyle;
   
   FensterAccess : Sf.Graphics.sfRenderWindow_Ptr := null;
   
   Startauflösung : Sf.System.Vector2.sfVector2u;
   Auflösung : Sf.System.Vector2.sfVector2u;
      
   AktuelleFensterAuflösung : Sf.System.Vector2.sfVector2f;
   
   FensterNichtErzeugbar : exception;
   
   procedure AktuelleAuflösungFestlegen;
   procedure MauszeigerFestlegen;
   
   
   
   function FensterErzeugenErweitert
     return Sf.Graphics.sfRenderWindow_Ptr;
   
end FensterGrafik;
