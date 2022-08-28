pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.System.Vector2;

with KartenDatentypen; use KartenDatentypen;
with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with EinheitenRecords;

private with KartenRecords;

private with Karten;

package WeltkarteSFML is
   
   procedure Weltkarte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   SichtbereichAnfangEnde : KartenDatentypen.SichtbereichAnfangEndeArray;
   
   YMultiplikator : Float;
   XMultiplikator : Float;
      
   Position : Sf.System.Vector2.sfVector2f;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   CursorKoordinatenAlt : KartenRecords.AchsenKartenfeldNaturalRecord;
   AktuelleKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
         
   -- Hier die Benennung von RasseEinheitExtern auf EinheitRasseNummerExtern umschreiben. äöü
   procedure IstSichtbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseEinheitExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );

end WeltkarteSFML;
