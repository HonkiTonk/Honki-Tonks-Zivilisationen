with Sf.Window.Window;
with Sf.System.Vector2;
with Sf;
with Sf.Graphics.Color;

with GrafikKonstanten;
with SpeziesDatentypen;

package LeseEinstellungenGrafik is
   pragma Elaborate_Body;
   use type Sf.sfUint32;
   use type Sf.Window.Window.sfWindowStyle;
   
   function Fenstermodus
     return Sf.Window.Window.sfWindowStyle
     with
       Post => (
                  Fenstermodus'Result <= 8
               );
   pragma Inline (Fenstermodus);
   
   function Auflösung
     return Sf.System.Vector2.sfVector2u
     with
       Post => (
                  Auflösung'Result.x in GrafikKonstanten.MinimaleAuflösungsbreite .. GrafikKonstanten.MaximaleAuflösungsbreite
                and
                  Auflösung'Result.y in GrafikKonstanten.MinimaleAuflösunghöhe .. GrafikKonstanten.MaximaleAuflösungshöhe
               );
   pragma Inline (Auflösung);
   
   function Farbtiefe
     return Sf.sfUint32
     with
       Post => (
                  Farbtiefe'Result in GrafikKonstanten.MinimaleFarbtiefe .. GrafikKonstanten.MaximaleFarbtiefe
               );
   pragma Inline (Farbtiefe);
   
   function Bildrate
     return Sf.sfUint32
     with
       Post => (
                  Bildrate'Result <= GrafikKonstanten.MaximaleBildrate
               );
   pragma Inline (Bildrate);
   
   function VSync
     return Sf.sfBool;
   pragma Inline (VSync);
   
   function SpeziesfarbeLesen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Sf.Graphics.Color.sfColor;
   pragma Inline (SpeziesfarbeLesen);
   
   function RahmenfarbeLesen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Sf.Graphics.Color.sfColor;
   pragma Inline (RahmenfarbeLesen);
   
   function EbenenUnterhalbSichtbar
     return Boolean;
   pragma Inline (EbenenUnterhalbSichtbar);
   
   function BildrateAnzeigen
     return Boolean;
   pragma Inline (BildrateAnzeigen);

end LeseEinstellungenGrafik;
