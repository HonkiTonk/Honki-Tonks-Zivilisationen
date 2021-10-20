pragma SPARK_Mode (On);

with Sf.System.Vector2;
with Sf.Graphics.Color;

with SonstigeDatentypen; use SonstigeDatentypen;
with KartenDatentypen;
with KartenRecords;
with GlobaleVariablen;
with EinheitStadtRecords;

package KarteSFML is
   
   procedure KarteAnzeigen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SonstigeDatentypen.Spieler_Mensch);
   
   procedure Sichtbarkeit
     (InDerStadtExtern : in Boolean;
      SichtweiteEbeneExtern : in KartenRecords.AchsenKartenfeldRecord;
      RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SonstigeDatentypen.Spieler_Mensch);
   
private
   
   YMultiplikator : Float;
   XMultiplikator : Float;
   
   EinheitStadtRasseNummer : EinheitStadtRecords.RassePlatznummerRecord;
   
   Abmessung : Sf.System.Vector2.sfVector2f;
   Position : Sf.System.Vector2.sfVector2f;
   FensterKarte : Sf.System.Vector2.sfVector2f;
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   procedure IstSichtbar
     (InDerStadtExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);

   procedure AnzeigeLandschaft
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord);

   procedure AnzeigeStadt
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord);

   procedure AnzeigeEinheit
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord);

   procedure AnzeigeCursor
     (InDerStadtExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);
   
   
   
   function FarbeErmitteln
     (GrundExtern : in KartenDatentypen.Karten_Grund_Enum)
      return Sf.Graphics.Color.sfColor;

end KarteSFML;
