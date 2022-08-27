pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;
with Sf.Graphics.Rect;

with KartenDatentypen;

package BerechnungenKarteSFML is
   
   -- Das hier über eine Funktion abrufen? äöü
   KartenfelderAbmessung : Sf.System.Vector2.sfVector2f;
   StadtfelderAbmessung : Sf.System.Vector2.sfVector2f;
   
   FensterKarte : Sf.Graphics.Rect.sfFloatRect;
   StadtKarte : Sf.Graphics.Rect.sfFloatRect;
   
   procedure KartenfelderAbmessungBerechnen;
   procedure StadtfelderAbmessungBerechnen;
   
   
   
   function SichtbereichKarteBerechnen
      return KartenDatentypen.SichtbereichAnfangEndeArray;
   
private
   
   YSichtAnfang : KartenDatentypen.Kartenfeld;
   YSichtEnde : KartenDatentypen.KartenfeldPositiv;
   XSichtAnfang : KartenDatentypen.Kartenfeld;
   XSichtEnde : KartenDatentypen.KartenfeldPositiv;

end BerechnungenKarteSFML;
