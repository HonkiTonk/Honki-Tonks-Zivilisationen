pragma SPARK_Mode (On);

with Sf;

with SonstigeDatentypen; use SonstigeDatentypen;
with GlobaleVariablen;
with KartenRecords;

package BewegungCursorSFML is

   procedure BewegungCursorRichtung
     (KarteExtern : in Boolean;
      YÄnderungExtern : in Sf.sfInt32;
      XÄnderungExtern : in Sf.sfInt32;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SonstigeDatentypen.Spieler_Mensch);

private

   Position : KartenRecords.AchsenKartenfeldPositivRecord;

   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   procedure BewegungCursorBerechnen
     (YÄnderungExtern : in Sf.sfInt32;
      XÄnderungExtern : in Sf.sfInt32;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

end BewegungCursorSFML;
