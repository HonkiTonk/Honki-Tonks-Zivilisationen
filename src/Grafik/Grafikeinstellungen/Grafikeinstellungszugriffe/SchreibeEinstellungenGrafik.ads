with Sf.Window.Window;
with Sf.System.Vector2;
with Sf;

with GrafikRecords;
with GrafikKonstanten;

package SchreibeEinstellungenGrafik is
   pragma Elaborate_Body;
   use type Sf.sfUint32;
   use type Sf.Window.Window.sfWindowStyle;
   
   procedure Fenstermodus
     (FenstermodusExtern : in Sf.Window.Window.sfWindowStyle)
     with
       Pre => (
                 FenstermodusExtern <= 8
              );
   pragma Inline (Fenstermodus);
   
   procedure Auflösung
     (AuflösungExtern : in Sf.System.Vector2.sfVector2u)
     with
       Pre => (
                 AuflösungExtern.x in GrafikKonstanten.MinimaleAuflösungsbreite .. GrafikKonstanten.MaximaleAuflösungsbreite
               and
                 AuflösungExtern.y in GrafikKonstanten.MinimaleAuflösunghöhe .. GrafikKonstanten.MaximaleAuflösungshöhe
              );
   pragma Inline (Auflösung);
   
   procedure Farbtiefe
     (FarbtiefeExtern : in Sf.sfUint32)
     with
       Pre => (
                 FarbtiefeExtern in GrafikKonstanten.MinimaleFarbtiefe .. GrafikKonstanten.MaximaleFarbtiefe
              );
   pragma Inline (Farbtiefe);
   
   procedure Bildrate
     (BildrateExtern : in Sf.sfUint32)
     with
       Pre => (
                 BildrateExtern <= GrafikKonstanten.MaximaleBildrate
              );
   pragma Inline (Bildrate);
   
   procedure EbenenUnterhalbSichtbar;
   pragma Inline (EbenenUnterhalbSichtbar);
   
   procedure BildrateAnzeigen;
   pragma Inline (BildrateAnzeigen);
   
   procedure GesamteGrafikeinstellungen
     (EinstellungenExtern : in GrafikRecords.GrafikeinstellungenRecord);
   pragma Inline (GesamteGrafikeinstellungen);

end SchreibeEinstellungenGrafik;
