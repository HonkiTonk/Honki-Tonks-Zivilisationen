with Sf.System.Vector2;
with Sf.Graphics.Rect;

with SpeziesDatentypen;
with KartenDatentypen;

private with TastenbelegungDatentypen;
private with KartenRecords;

-- Das Ganze später besser aufteilen? äöü
-- Um ein im Kreis linken zu verhindern erst einmal die KartenberechnungenGrafik hier mit rein geschoben. äöü
package SichtweitenGrafik is
   pragma Elaborate_Body;
      
   procedure KartenfelderAbmessungBerechnen;
   procedure StadtumgebungAbmessungBerechnen;
   procedure StandardSichtweiten;
   
   procedure ZoomstufeÄndern
     (ÄnderungExtern : in KartenDatentypen.Kartenfeld);
   
   
      
   function SichtweiteLesen
     return KartenDatentypen.KartenfeldPositiv;
   
   function BewegungsfeldLesen
     return KartenDatentypen.KartenfeldPositiv;
   
   -- Hier keinen Contract einfügen, da die Grafik möglicherweise noch einmal darauf zugreift nachdem die SpielerSpezies besiegt und entfernt wurde.
   function UntenRechts
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Boolean;
   
   function Kartenfeldfläche
     return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Kartenfeldfläche'Result.x >= 0.00
                and
                  Kartenfeldfläche'Result.y >= 0.00
               );
     
   function Stadtumgebungsfläche
     return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Stadtumgebungsfläche'Result.x >= 0.00
                and
                  Stadtumgebungsfläche'Result.y >= 0.00
               );
   
   function Kartenfläche
     return Sf.Graphics.Rect.sfFloatRect
     with
       Post => (
                  Kartenfläche'Result.left >= 0.00
                and
                  Kartenfläche'Result.top >= 0.00
                and
                  Kartenfläche'Result.width >= 0.00
                and
                  Kartenfläche'Result.height >= 0.00
               );
   
private
   
   WelcheZoomanpassung : TastenbelegungDatentypen.Tastenbelegung_Bewegung_Erweitert_Enum;
   
   MaximaleZoomstufe : constant KartenDatentypen.KartenfeldPositiv := 10;
   StandardZoomstufe : constant KartenDatentypen.KartenfeldPositiv := 4;
   MinimaleZoomstufe : KartenDatentypen.KartenfeldPositiv := KartenDatentypen.KartenfeldPositiv'First;
   AktuelleZoomstufe : KartenDatentypen.KartenfeldPositiv := StandardZoomstufe;
   
   StadtumgebungAbmessung : Sf.System.Vector2.sfVector2f;
   KartenfelderAbmessung : Sf.System.Vector2.sfVector2f;
   
   Cursor : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   FensterKarte : Sf.Graphics.Rect.sfFloatRect;

end SichtweitenGrafik;
