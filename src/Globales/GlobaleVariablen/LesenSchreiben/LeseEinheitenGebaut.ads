with RassenDatentypen; use RassenDatentypen;
with EinheitenDatentypen; use EinheitenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with StadtDatentypen;
with EinheitenRecords;
with SpielVariablen;
with KartenRecords;
with AufgabenDatentypen;
with KampfDatentypen;
with KartenKonstanten;
with ProduktionDatentypen;
with Weltkarte;

with KIDatentypen;

package LeseEinheitenGebaut is
   pragma Elaborate_Body;

   function ID
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return EinheitenDatentypen.EinheitenIDMitNullWert
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

   function Koordinaten
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              ),
         
       Post => (
                  Koordinaten'Result.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
                and
                  Koordinaten'Result.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
                and
                  (if Koordinaten'Result.YAchse = KartenKonstanten.LeerYAchse then Koordinaten'Result.XAchse = KartenKonstanten.LeerXAchse and Koordinaten'Result.EAchse = KartenKonstanten.LeerEAchse)
                and
                  (if Koordinaten'Result.XAchse = KartenKonstanten.LeerXAchse then Koordinaten'Result.YAchse = KartenKonstanten.LeerYAchse and Koordinaten'Result.EAchse = KartenKonstanten.LeerEAchse)
                and
                  (if Koordinaten'Result.EAchse = KartenKonstanten.LeerEAchse then Koordinaten'Result.YAchse = KartenKonstanten.LeerYAchse and Koordinaten'Result.XAchse = KartenKonstanten.LeerXAchse)
               );
   
   function Heimatstadt
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return StadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
      
   function Lebenspunkte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return EinheitenDatentypen.Lebenspunkte
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function Bewegungspunkte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return EinheitenDatentypen.VorhandeneBewegungspunkte
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function Erfahrungspunkte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KampfDatentypen.Erfahrungspunkte
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function Rang
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KampfDatentypen.Rang
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
      
   function Beschäftigung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return AufgabenDatentypen.Einheiten_Aufgaben_Enum
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function BeschäftigungNachfolger
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return AufgabenDatentypen.Einheiten_Aufgaben_Enum
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
      
   function Beschäftigungszeit
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return ProduktionDatentypen.Arbeitszeit
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function BeschäftigungszeitNachfolger
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return ProduktionDatentypen.Arbeitszeit
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
      
   -- Die KIZugriffe müssen auch für menschliche Spieler lesbar sein wegen dem Debugsystem.
   function KIZielKoordinaten
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              ),
         
       Post => (
                  KIZielKoordinaten'Result.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
                and
                  KIZielKoordinaten'Result.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
                and
                  (if KIZielKoordinaten'Result.YAchse = KartenKonstanten.LeerYAchse then KIZielKoordinaten'Result.XAchse = KartenKonstanten.LeerXAchse and KIZielKoordinaten'Result.EAchse = KartenKonstanten.LeerEAchse)
                and
                  (if KIZielKoordinaten'Result.XAchse = KartenKonstanten.LeerXAchse then KIZielKoordinaten'Result.YAchse = KartenKonstanten.LeerYAchse and KIZielKoordinaten'Result.EAchse = KartenKonstanten.LeerEAchse)
                and
                  (if KIZielKoordinaten'Result.EAchse = KartenKonstanten.LeerEAchse then KIZielKoordinaten'Result.YAchse = KartenKonstanten.LeerYAchse and KIZielKoordinaten'Result.XAchse = KartenKonstanten.LeerXAchse)
               );
   
   function KIBeschäftigt
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.Einheit_Aufgabe_Enum
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function KIZielKoordinatenNachfolger
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              ),
         
       Post => (
                  KIZielKoordinatenNachfolger'Result.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
                and
                  KIZielKoordinatenNachfolger'Result.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
                and
                  (if KIZielKoordinatenNachfolger'Result.YAchse = KartenKonstanten.LeerYAchse
                         then KIZielKoordinatenNachfolger'Result.XAchse = KartenKonstanten.LeerXAchse and KIZielKoordinatenNachfolger'Result.EAchse = KartenKonstanten.LeerEAchse)
                and
                  (if KIZielKoordinatenNachfolger'Result.XAchse = KartenKonstanten.LeerXAchse
                         then KIZielKoordinatenNachfolger'Result.YAchse = KartenKonstanten.LeerYAchse and KIZielKoordinatenNachfolger'Result.EAchse = KartenKonstanten.LeerEAchse)
                and
                  (if KIZielKoordinatenNachfolger'Result.EAchse = KartenKonstanten.LeerEAchse
                         then KIZielKoordinatenNachfolger'Result.YAchse = KartenKonstanten.LeerYAchse and KIZielKoordinatenNachfolger'Result.XAchse = KartenKonstanten.LeerXAchse)
               );
     
   function KIBeschäftigtNachfolger
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.Einheit_Aufgabe_Enum
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function KIVerbesserung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return AufgabenDatentypen.Einheiten_Aufgaben_Enum
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function KIBewegungPlan
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      PlanschrittExtern : in EinheitenDatentypen.Bewegungsplan)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              ),
         
       Post => (
                  KIBewegungPlan'Result.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
                and
                  KIBewegungPlan'Result.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
                and
                  (if KIBewegungPlan'Result.YAchse = KartenKonstanten.LeerYAchse then KIBewegungPlan'Result.XAchse = KartenKonstanten.LeerXAchse and KIBewegungPlan'Result.EAchse = KartenKonstanten.LeerEAchse)
                and
                  (if KIBewegungPlan'Result.XAchse = KartenKonstanten.LeerXAchse then KIBewegungPlan'Result.YAchse = KartenKonstanten.LeerYAchse and KIBewegungPlan'Result.EAchse = KartenKonstanten.LeerEAchse)
                and
                  (if KIBewegungPlan'Result.EAchse = KartenKonstanten.LeerEAchse then KIBewegungPlan'Result.YAchse = KartenKonstanten.LeerYAchse and KIBewegungPlan'Result.XAchse = KartenKonstanten.LeerXAchse)
               );
      
   function Transportiert
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      PlatzExtern : in EinheitenDatentypen.Transportplätze)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function WirdTransportiert
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
      
   function Meldungen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      WelcheMeldungExtern : in EinheitenDatentypen.Einheit_Meldung_Art_Enum)
      return EinheitenDatentypen.Einheit_Meldung_Enum
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function GanzerEintrag
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return EinheitenRecords.EinheitenGebautRecord
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
private
   
   EinheitID : EinheitenDatentypen.EinheitenIDMitNullWert;
   
   Beförderungsgrenze : KampfDatentypen.Erfahrungspunkte;
   MaximalerRang : KampfDatentypen.Rang;
   
   ErlaubteLebenspunkte : EinheitenDatentypen.VorhandeneLebenspunkte;

end LeseEinheitenGebaut;
