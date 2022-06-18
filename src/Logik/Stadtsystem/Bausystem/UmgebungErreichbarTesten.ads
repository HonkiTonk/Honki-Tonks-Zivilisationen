pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with RassenDatentypen; use RassenDatentypen;
with KartenRecords;
with EinheitenDatentypen;
with SonstigeVariablen;

with Karten;

package UmgebungErreichbarTesten is
   
   function UmgebungErreichbarTesten
     (AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      NotwendigeFelderExtern : in Positive)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre =>
         (AktuelleKoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
          and
            AktuelleKoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
          and
            SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum),
           
         Post =>
           (UmgebungErreichbarTesten'Result.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
            and
              UmgebungErreichbarTesten'Result.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse);
   
private
   
   BereitsGetestet : KartenDatentypen.UmgebungsbereichZwei;
   Umgebung : KartenDatentypen.UmgebungsbereichDrei;
   
   GefundeneFelder : Positive;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenWertZwei : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   function NochErreichbar
     (AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return Boolean
     with
       Pre =>
         (AktuelleKoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
          and
            AktuelleKoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
          and
            SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);

end UmgebungErreichbarTesten;
