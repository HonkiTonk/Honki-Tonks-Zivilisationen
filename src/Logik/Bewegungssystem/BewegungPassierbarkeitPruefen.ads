pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with KartenRecords;
with EinheitenRecords;
with EinheitenDatentypen;
with StadtDatentypen;
with SonstigeVariablen;
with StadtRecords;

with Karten;

package BewegungPassierbarkeitPruefen is
   
   function PassierbarkeitPrüfenNummer
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            NeueKoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
          and
            NeueKoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
   
   function PassierbarkeitPrüfenID
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre =>
         (NeueKoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
          and
            NeueKoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
          and
            SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);

   function InStadtEntladbar
     (TransporterExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre =>
         (TransporterExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (TransporterExtern.Rasse).Einheitengrenze
          and
            NeueKoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
          and
            NeueKoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
          and
            SonstigeVariablen.RassenImSpiel (TransporterExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
      
   function RichtigeUmgebungVorhanden
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EinheitenIDExtern : in EinheitenDatentypen.EinheitenID)
      return Boolean
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);

private
   
   Passierbar : Boolean;
   
   IDEinheit : EinheitenDatentypen.EinheitenIDMitNullWert;
   
   StadtNummer : StadtDatentypen.MaximaleStädteMitNullWert;
   TransporterNummer : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   Transportplatz : EinheitenDatentypen.MaximaleEinheitenMitNullWert;

   BenötigteFelder : Positive;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   TransportplatzEntladen : EinheitenRecords.TransporterArray;
   
   function PassierbarTesten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      UmgebungExtern : in EinheitenDatentypen.Passierbarkeit_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre =>
         (NeueKoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
          and
            NeueKoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
          and
            SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);
   
   function IstNichtPassierbar
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      UmgebungExtern : in EinheitenDatentypen.Passierbarkeit_Vorhanden_Enum;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre =>
         (NeueKoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
          and
            NeueKoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
          and
            SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);
     
   function IstPassierbar
     (UmgebungExtern : in EinheitenDatentypen.Passierbarkeit_Vorhanden_Enum;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre =>
         (NeueKoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
          and
            NeueKoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse);

end BewegungPassierbarkeitPruefen;
