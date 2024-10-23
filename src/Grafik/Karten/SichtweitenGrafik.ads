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
     (ÄnderungExtern : in KartenDatentypen.Senkrechte);
   
   
   
   function SichthöheLesen
     return KartenDatentypen.SenkrechtePositiv;
   
   function SichtbreiteLesen
     return KartenDatentypen.WaagerechtePositiv;
   
   function SichtbereichLesen
     return KartenRecords.KartenfeldumgebungPositivRecord;
   
   function BewegungshöheLesen
     return KartenDatentypen.SenkrechtePositiv;
   
   function BewegungsbreiteLesen
     return KartenDatentypen.WaagerechtePositiv;
   
   function BewegungsbereichLesen
     return KartenRecords.KartenfeldumgebungPositivRecord;
   
   -- Hier keinen Contract einfügen, da die Grafik möglicherweise noch einmal darauf zugreift nachdem die SpielerSpezies besiegt und entfernt wurde.
   function UntenRechts
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
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
   
   -- Maximale und Minimale Zoomstufe später anpassbar machen. äöü
   MaximaleSenkrechteZoomstufe : constant KartenDatentypen.SenkrechtePositiv := 15;
   MinimaleSenkrechteZoomstufe : constant KartenDatentypen.SenkrechtePositiv := KartenDatentypen.SenkrechtePositiv'First;
   StandardSenkrechteZoomstufe : constant KartenDatentypen.SenkrechtePositiv := 5;
   AktuelleSenkrechteZoomstufe : KartenDatentypen.SenkrechtePositiv := StandardSenkrechteZoomstufe;
   
   MaximaleWaagerechteZoomstufe : constant KartenDatentypen.WaagerechtePositiv := 15;
   MinimaleWaagerechteZoomstufe : constant KartenDatentypen.WaagerechtePositiv := KartenDatentypen.WaagerechtePositiv'First;
   StandardWaagerechteZoomstufe : constant KartenDatentypen.WaagerechtePositiv := 5;
   AktuelleWaagerechteZoomstufe : KartenDatentypen.WaagerechtePositiv := StandardWaagerechteZoomstufe;
   
   Sichtbereich : KartenRecords.KartenfeldumgebungPositivRecord;
   Bewegungsbereich : KartenRecords.KartenfeldumgebungPositivRecord;
   
   StadtumgebungAbmessung : Sf.System.Vector2.sfVector2f;
   KartenfelderAbmessung : Sf.System.Vector2.sfVector2f;
   
   Zeiger : KartenRecords.KartenfeldNaturalRecord;
   
   FensterKarte : Sf.System.Vector2.sfVector2f;

end SichtweitenGrafik;
