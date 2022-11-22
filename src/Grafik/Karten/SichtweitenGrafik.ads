with Sf.System.Vector2;
with Sf.Graphics.Rect;

with RassenDatentypen;
with KartenDatentypen;

private with TastenbelegungDatentypen;
private with KartenRecords;

with LeseRassenbelegung;

-- Das Ganze später besser aufteilen? äöü
-- Um ein im Kreis linken zu verhindern erst einmal die KartenberechnungenGrafik hier mit rein geschoben. äöü
package SichtweitenGrafik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   
   -- Das hier über eine Funktion abrufen? äöü
   KartenfelderAbmessung : Sf.System.Vector2.sfVector2f;
   StadtfelderAbmessung : Sf.System.Vector2.sfVector2f;
   
   FensterKarte : Sf.Graphics.Rect.sfFloatRect;
   StadtKarte : Sf.Graphics.Rect.sfFloatRect;
   
   procedure KartenfelderAbmessungBerechnen;
   procedure StadtfelderAbmessungBerechnen;
   procedure SichtweiteBewegungsfeldFestlegen;
   
   procedure ZoomstufeÄndern
     (ÄnderungExtern : in KartenDatentypen.Kartenfeld);
   
   procedure StandardSichtweiten;
   
   
   
   function SichtweiteLesen
     return KartenDatentypen.KartenfeldPositiv;
   
   function BewegungsfeldLesen
     return KartenDatentypen.KartenfeldPositiv;
   
   function UntenRechts
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   WelcheZoomanpassung : TastenbelegungDatentypen.Tastenbelegung_Bewegung_Erweitert_Enum;
   
   MaximaleZoomstufe : constant KartenDatentypen.KartenfeldPositiv := 10;
   StandardZoomstufe : constant KartenDatentypen.KartenfeldPositiv := 4;
   MinimaleZoomstufe : KartenDatentypen.KartenfeldPositiv := KartenDatentypen.KartenfeldPositiv'First;
   AktuelleZoomstufe : KartenDatentypen.KartenfeldPositiv := StandardZoomstufe;
   
   Cursor : KartenRecords.AchsenKartenfeldNaturalRecord;

end SichtweitenGrafik;
