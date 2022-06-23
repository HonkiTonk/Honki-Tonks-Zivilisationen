pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with EinheitenRecords;
with EinheitenDatentypen;
with SpielVariablen;
with KartenRecords;
with SonstigeVariablen;

with Karten;

package BewegungLadenEntladen is

   procedure TransporterBeladen
     (TransporterExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      LadungExtern : in EinheitenDatentypen.MaximaleEinheiten)
     with
       Pre => (
                 TransporterExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (TransporterExtern.Rasse).Einheitengrenze
               and
                 SonstigeVariablen.RassenImSpiel (TransporterExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure EinheitAusTransporterEntfernen
     (TransporterExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      LadungExtern : in EinheitenDatentypen.MaximaleEinheiten)
     with
       Pre => (
                 TransporterExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (TransporterExtern.Rasse).Einheitengrenze
               and
                 SonstigeVariablen.RassenImSpiel (TransporterExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure TransporterladungVerschieben
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 NeueKoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 NeueKoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );
   
   procedure TransporterStadtEntladen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 NeueKoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 NeueKoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );
   
private
   
   TransporterNummer : EinheitenDatentypen.MaximaleEinheiten;
   
   EinheitAusladen : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   
   FreierPlatzNummer : EinheitenDatentypen.Transportplätze;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   function FreienPlatzErmitteln
     (TransporterExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return EinheitenDatentypen.Transportplätze
     with
       Pre => (
                 TransporterExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (TransporterExtern.Rasse).Einheitengrenze
               and
                 SonstigeVariablen.RassenImSpiel (TransporterExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );

end BewegungLadenEntladen;
