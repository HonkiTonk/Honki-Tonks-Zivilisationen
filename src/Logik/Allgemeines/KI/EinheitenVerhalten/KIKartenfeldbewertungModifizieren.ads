pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with KartenRecords;
with SpielVariablen;

with Karten;

package KIKartenfeldbewertungModifizieren is

   function BewertungStadtBauen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.GesamteFeldbewertung
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.KI_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );
   
private
   
   BewertungKartenfeld : KartenDatentypen.GesamteFeldbewertung;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;

end KIKartenfeldbewertungModifizieren;
