private with Sf.System.Vector2;

with RassenDatentypen;
with StadtRecords;
with StadtKonstanten;

private with StadtDatentypen;
private with KartenDatentypen;
private with KartenRecords;

with LeseGrenzen;
with LeseRassenbelegung;

package StadtkarteGrafik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   procedure Stadtkarte
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => StadtRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
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
