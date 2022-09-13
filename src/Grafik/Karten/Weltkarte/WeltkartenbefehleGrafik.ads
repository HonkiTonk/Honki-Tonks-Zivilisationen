pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.System.Vector2;
private with Sf.Graphics.Rect;

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with EinheitenRecords;

private with GrafikRecordKonstanten;

package WeltkartenbefehleGrafik is

   procedure Kartenbefehle;
   
   procedure Einheitenbefehle
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   Kampfeinheit : Boolean;
   
   AnfangEinheitenbefehle : constant Positive := 2;
   AnfangKartenbefehle : constant Positive := 15;
   Aktuelleposition : Positive;

   Textbreite : Float;

   EinheitenViewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartgrößeView;
   KartenbefehleViewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartgrößeView;
   Textposition : Sf.System.Vector2.sfVector2f;
   
   Textbox : Sf.Graphics.Rect.sfFloatRect;

end WeltkartenbefehleGrafik;
