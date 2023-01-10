private with Sf.System.Vector2;

with SpeziesDatentypen;
with StadtRecords;
with StadtKonstanten;

private with StadtDatentypen;
private with KartenDatentypen;
private with KartenRecords;

with LeseGrenzen;
with LeseSpeziesbelegung;

package StadtkarteGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure Stadtkarte
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

private

   GebäudeID : StadtDatentypen.GebäudeID;

   Stadtgröße : KartenDatentypen.KartenfeldPositiv;

   YMultiplikator : Float;
   XMultiplikator : Float;

   Gesamtgrund : KartenRecords.KartengrundRecord;

   Grafikgröße : Sf.System.Vector2.sfVector2f;

   procedure GrafischeDarstellung
     (GrundExtern : in KartenRecords.KartengrundRecord);

end StadtkarteGrafik;
