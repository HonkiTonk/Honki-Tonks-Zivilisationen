with Sf.Window.Window;
with Sf.System.Vector2;
with Sf;

with GrafikRecords;
with GrafikKonstanten;

package SchreibeEinstellungenGrafik is
   pragma Elaborate_Body;
   use type Sf.sfUint32;
   use type Sf.Window.Window.sfWindowStyle;
   
   -- Fenstereinstellungen
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
                 FarbtiefeExtern > 0
              );
   pragma Inline (Farbtiefe);
   
   procedure Bildrate
     (BildrateExtern : in Sf.sfUint32)
     with
       Pre => (
                 BildrateExtern in GrafikKonstanten.MinimaleBildrate .. GrafikKonstanten.MaximaleBildrate
              );
   pragma Inline (Bildrate);
   -- Fenstereinstellungen
   
   
   
   -- Grafikeinstellungen
   procedure EbenenUnterhalbSichtbar;
   pragma Inline (EbenenUnterhalbSichtbar);
   -- Grafikeinstellungen
   
   

   procedure Fenstereinstellungen
     (EintragExtern : in GrafikRecords.FensterRecord);
   pragma Inline (Fenstereinstellungen);
   
   procedure Grafikeinstellungen
     (EintragExtern : in GrafikRecords.GrafikeinstellungenRecord);
   pragma Inline (Grafikeinstellungen);

end SchreibeEinstellungenGrafik;
