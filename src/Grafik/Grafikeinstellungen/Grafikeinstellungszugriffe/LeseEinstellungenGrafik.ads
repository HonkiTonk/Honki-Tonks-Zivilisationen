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
   
   function Auflösung
     return Sf.System.Vector2.sfVector2u
     with
       Post => (
                  Auflösung'Result.x in GrafikKonstanten.MinimaleAuflösungsbreite .. GrafikKonstanten.MaximaleAuflösungsbreite
                and
                  Auflösung'Result.y in GrafikKonstanten.MinimaleAuflösunghöhe .. GrafikKonstanten.MaximaleAuflösungshöhe
               );
   
   function Farbtiefe
     return Sf.sfUint32
     with
       Post => (
                  Farbtiefe'Result > 0
               );
   
   function Bildrate
     return Sf.sfUint32
     with
       Post => (
                  Bildrate'Result in GrafikKonstanten.MinimaleBildrate .. GrafikKonstanten.MaximaleBildrate
               );
   -- Fenstereinstellungen
   
   
   
   -- Grafikeinstellungen
   function EbenenUnterhalbSichtbar
     return Boolean;
   -- Grafikeinstellungen
   
   

   function Fenstereinstellungen
     return GrafikRecords.FensterRecord;
   
   function Grafikeinstellungen
     return GrafikRecords.GrafikeinstellungenRecord;

end LeseEinstellungenGrafik;
