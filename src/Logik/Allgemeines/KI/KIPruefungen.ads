pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenRecords; use EinheitenRecords;
with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with SpielVariablen;
with KartenRecords;
with EinheitenDatentypen;
with SonstigeVariablen;
with StadtRecords;

with Karten;

package KIPruefungen is
   
   function StadtUmgebungPrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              ),
           
       Post => (
                  StadtUmgebungPrüfen'Result.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
                and
                  StadtUmgebungPrüfen'Result.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
               );
   
   function UmgebungStadtBauenPrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      MindestBewertungFeldExtern : in KartenDatentypen.GesamteFeldbewertung)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              ),
           
       Post => (
                  UmgebungStadtBauenPrüfen'Result.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
                and
                  UmgebungStadtBauenPrüfen'Result.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
               );
   
private
   
   FeldGutUndFrei : Boolean;
   VerbesserungTesten : Boolean;
   
   AbstandKleiner : KartenDatentypen.KartenfeldPositiv;
   YAchseKoordinatePrüfen : KartenDatentypen.KartenfeldPositiv;
   XAchseKoordinatePrüfen : KartenDatentypen.KartenfeldPositiv;
   YAchseKoordinatenSchonGeprüft : KartenDatentypen.KartenfeldNatural;
   XAchseKoordinatenSchonGeprüft : KartenDatentypen.KartenfeldNatural;
   
   VerbesserungAnlegen : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   EinheitAufFeld : EinheitenRecords.RasseEinheitnummerRecord;
   
   StadtVerbesserungUmgebungKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   StadtBauenUmgebungKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenWertZwei : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   function KartenfeldUmgebungPrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      MindestBewertungFeldExtern : in KartenDatentypen.GesamteFeldbewertung)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
               and
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );
   
   function StadtUmgebungUnverbessert
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EinheitNummerExtern : in EinheitenDatentypen.MaximaleEinheiten)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
               and
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
              ),
           
       Post => (
                  StadtUmgebungUnverbessert'Result.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
                and
                  StadtUmgebungUnverbessert'Result.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
               );
   
   function VerbesserungDortAnlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
               and
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );
   
   function VerbesserungAnlegbar
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );
   
   function FeldBelegt
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );
   
   function NeuesStadtFeldSuchen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      MindestBewertungFeldExtern : in KartenDatentypen.GesamteFeldbewertung;
      YUmgebungExtern : in KartenDatentypen.KartenfeldPositiv;
      XUmgebungExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              ),
           
       Post => (
                  NeuesStadtFeldSuchen'Result.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
                and
                  NeuesStadtFeldSuchen'Result.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
               );
   
   function FelderDurchgehen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      MindestBewertungFeldExtern : in KartenDatentypen.GesamteFeldbewertung)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              ),
           
       Post => (
                  FelderDurchgehen'Result.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
                and
                  FelderDurchgehen'Result.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
               );
   
end KIPruefungen;
