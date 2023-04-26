with Sf.System.Vector2;

with SpeziesDatentypen;
with KartenDatentypen;
with KartenRecords;

private with TastenbelegungDatentypen;

package SichtweitenGrafik is
   pragma Elaborate_Body;
      
   procedure KartenfelderAbmessungBerechnen;
   procedure StadtumgebungAbmessungBerechnen;
   procedure StandardSichtweiten;
   
   procedure ZoomstufeÄndern
     (ÄnderungExtern : in KartenDatentypen.Kartenfeld);
   
   
   
   function SichthöheLesen
     return KartenDatentypen.KartenfeldPositiv;
   
   function SichtbreiteLesen
     return KartenDatentypen.KartenfeldPositiv;
   
   function SichtbereichLesen
     return KartenRecords.YXAchsenKartenfeldPositivRecord;
   
   function BewegungshöheLesen
     return KartenDatentypen.KartenfeldPositiv;
   
   function BewegungsbreiteLesen
     return KartenDatentypen.KartenfeldPositiv;
   
   function BewegungsbereichLesen
     return KartenRecords.YXAchsenKartenfeldPositivRecord;
   
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
     return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Kartenfläche'Result.x >= 0.00
                and
                  Kartenfläche'Result.y >= 0.00
               );
   
private
      
   WelcheZoomanpassung : TastenbelegungDatentypen.Tastenbelegung_Bewegung_Erweitert_Enum;
   
   -- Maximale und Minimale Zoomstufe später anpassbar machen? äöü
   MaximaleZoomstufe : constant KartenDatentypen.KartenfeldPositiv := 10;
   MinimaleZoomstufe : constant KartenDatentypen.KartenfeldPositiv := KartenDatentypen.KartenfeldPositiv'First;
   StandardZoomstufe : constant KartenDatentypen.KartenfeldPositiv := 5;
   AktuelleZoomstufe : KartenDatentypen.KartenfeldPositiv := StandardZoomstufe;
   
   Sichtbereich : KartenRecords.YXAchsenKartenfeldPositivRecord;
   Bewegungsbereich : KartenRecords.YXAchsenKartenfeldPositivRecord;
   
   StadtumgebungAbmessung : Sf.System.Vector2.sfVector2f;
   KartenfelderAbmessung : Sf.System.Vector2.sfVector2f;
   
   Cursor : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   FensterKarte : Sf.System.Vector2.sfVector2f;

end SichtweitenGrafik;
