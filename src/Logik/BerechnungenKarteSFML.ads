pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;

with SystemDatentypen; use SystemDatentypen;
with KartenDatentypen;
with KartenRecords;
with GlobaleVariablen;
with SystemKonstanten;

package BerechnungenKarteSFML is
   
   FensterKarte : Sf.System.Vector2.sfVector2f;
   FensterAnzeige : Sf.System.Vector2.sfVector2f;
   
   StadtKarte : Sf.System.Vector2.sfVector2f;
   StadtAnzeige : Sf.System.Vector2.sfVector2f;
   
   KartenfelderAbmessung : Sf.System.Vector2.sfVector2f;
   StadtfelderAbmessung : Sf.System.Vector2.sfVector2f;
   
   procedure KartenfelderAbmessungBerechnen;
   procedure StadtfelderAbmessungBerechnen;
   
   
   
   function SichtbereichKarteBerechnen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.SichtbereichAnfangEndeArray
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemKonstanten.SpielerMenschKonstante);
   
private
   
   YSichtAnfang : KartenDatentypen.Kartenfeld;
   YSichtEnde : KartenDatentypen.KartenfeldPositiv;
   XSichtAnfang : KartenDatentypen.Kartenfeld;
   XSichtEnde : KartenDatentypen.KartenfeldPositiv;
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   AusschnittKarte : constant Float := 0.80;
   AusschnittStadtKarte : constant Float := 0.80;

end BerechnungenKarteSFML;
