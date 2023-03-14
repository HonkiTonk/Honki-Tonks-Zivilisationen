with Sf.Window.Window;
with Sf.System.Vector2;
with Sf;

with GrafikRecords;
with GrafikKonstanten;

package LeseEinstellungenGrafik is
   pragma Elaborate_Body;
   use type Sf.sfUint32;
   use type Sf.Window.Window.sfWindowStyle;
   
   -- Fenstereinstellungen
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
                  Farbtiefe'Result > 0
               );
   pragma Inline (Farbtiefe);
   
   function Bildrate
     return Sf.sfUint32
     with
       Post => (
                  Bildrate'Result in GrafikKonstanten.MinimaleBildrate .. GrafikKonstanten.MaximaleBildrate
               );
   pragma Inline (Bildrate);
   -- Fenstereinstellungen
   
   
   
   -- Grafikeinstellungen
   function EbenenUnterhalbSichtbar
     return Boolean;
   pragma Inline (EbenenUnterhalbSichtbar);
   -- Grafikeinstellungen
   
   

   function Fenstereinstellungen
     return GrafikRecords.FensterRecord;
   pragma Inline (Fenstereinstellungen);
   
   function Grafikeinstellungen
     return GrafikRecords.GrafikeinstellungenRecord;
   pragma Inline (Grafikeinstellungen);

end LeseEinstellungenGrafik;
