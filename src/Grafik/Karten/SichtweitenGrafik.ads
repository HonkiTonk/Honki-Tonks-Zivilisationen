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
   
   -- Das hier über eine Funktion abrufen? äöü
   KartenfelderAbmessung : Sf.System.Vector2.sfVector2f;
   
   FensterKarte : Sf.Graphics.Rect.sfFloatRect;
   
   procedure KartenfelderAbmessungBerechnen;
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
   
private
   
   WelcheZoomanpassung : TastenbelegungDatentypen.Tastenbelegung_Bewegung_Erweitert_Enum;
   
   MaximaleZoomstufe : constant KartenDatentypen.KartenfeldPositiv := 10;
   StandardZoomstufe : constant KartenDatentypen.KartenfeldPositiv := 4;
   MinimaleZoomstufe : KartenDatentypen.KartenfeldPositiv := KartenDatentypen.KartenfeldPositiv'First;
   AktuelleZoomstufe : KartenDatentypen.KartenfeldPositiv := StandardZoomstufe;
   
   Cursor : KartenRecords.AchsenKartenfeldNaturalRecord;

end SichtweitenGrafik;
