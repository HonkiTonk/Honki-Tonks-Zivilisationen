with KartenDatentypen;
with RassenDatentypen;
with EinheitenRecords;
with KartenRecords;
with EinheitenDatentypen;
with StadtDatentypen;
with AufgabenDatentypen;
with KampfDatentypen;
with KartenKonstanten;
with ProduktionDatentypen;
with EinheitenKonstanten;

with LeseWeltkarteneinstellungen;
with LeseGrenzen;
with LeseRassenbelegung;

with KIDatentypen;

package SchreibeEinheitenGebaut is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;
   use type KartenDatentypen.Ebene;

   procedure ID
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure Koordinaten
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitentauschExtern : in Boolean)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 (if KoordinatenExtern.YAchse = KartenKonstanten.LeerYAchse then KoordinatenExtern.XAchse = KartenKonstanten.LeerXAchse and KoordinatenExtern.EAchse = KartenKonstanten.LeerEAchse)
               and
                 (if KoordinatenExtern.XAchse = KartenKonstanten.LeerXAchse then KoordinatenExtern.YAchse = KartenKonstanten.LeerYAchse and KoordinatenExtern.EAchse = KartenKonstanten.LeerEAchse)
               and
                 (if KoordinatenExtern.EAchse = KartenKonstanten.LeerEAchse then KoordinatenExtern.YAchse = KartenKonstanten.LeerYAchse and KoordinatenExtern.XAchse = KartenKonstanten.LeerXAchse)
              );
   
   procedure Heimatstadt
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      HeimatstadtExtern : in StadtDatentypen.MaximaleStädteMitNullWert)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure Lebenspunkte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      LebenspunkteExtern : in EinheitenDatentypen.Lebenspunkte;
      RechnenSetzenExtern : in Boolean)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure Bewegungspunkte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      BewegungspunkteExtern : in EinheitenDatentypen.Bewegungspunkte;
      RechnenSetzenExtern : in Boolean)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure Erfahrungspunkte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      ErfahrungspunkteExtern : in KampfDatentypen.ErfahrungspunkteVorhanden;
      AddierenSetzenExtern : in Boolean)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure Rang
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure Beschäftigung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      BeschäftigungExtern : in AufgabenDatentypen.Einheiten_Aufgaben_Enum)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure BeschäftigungNachfolger
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      BeschäftigungExtern : in AufgabenDatentypen.Einheiten_Aufgaben_Enum)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure Beschäftigungszeit
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      ZeitExtern : in ProduktionDatentypen.Arbeitszeit;
      RechnenSetzenExtern : in Boolean)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure BeschäftigungszeitNachfolger
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      ZeitExtern : in ProduktionDatentypen.Arbeitszeit;
      RechnenSetzenExtern : in Boolean)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure KIZielKoordinaten
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 (if KoordinatenExtern.YAchse = KartenKonstanten.LeerYAchse then KoordinatenExtern.XAchse = KartenKonstanten.LeerXAchse and KoordinatenExtern.EAchse = KartenKonstanten.LeerEAchse)
               and
                 (if KoordinatenExtern.XAchse = KartenKonstanten.LeerXAchse then KoordinatenExtern.YAchse = KartenKonstanten.LeerYAchse and KoordinatenExtern.EAchse = KartenKonstanten.LeerEAchse)
               and
                 (if KoordinatenExtern.EAchse = KartenKonstanten.LeerEAchse then KoordinatenExtern.YAchse = KartenKonstanten.LeerYAchse and KoordinatenExtern.XAchse = KartenKonstanten.LeerXAchse)
              );
   
   procedure KIBeschäftigt
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AufgabeExtern : in KIDatentypen.Einheit_Aufgabe_Enum)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
               -- Kann hier nicht nur auf KISpieler geprüft werden, da in VerbesserungFertiggestellt.AufgabeNachfolgerVerschieben es auch bei menschlichem Spieler entsprechend gesetzt wird. äöü
               -- Später mal anpassen? äöü
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure KIZielKoordinatenNachfolger
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 (if KoordinatenExtern.YAchse = KartenKonstanten.LeerYAchse then KoordinatenExtern.XAchse = KartenKonstanten.LeerXAchse and KoordinatenExtern.EAchse = KartenKonstanten.LeerEAchse)
               and
                 (if KoordinatenExtern.XAchse = KartenKonstanten.LeerXAchse then KoordinatenExtern.YAchse = KartenKonstanten.LeerYAchse and KoordinatenExtern.EAchse = KartenKonstanten.LeerEAchse)
               and
                 (if KoordinatenExtern.EAchse = KartenKonstanten.LeerEAchse then KoordinatenExtern.YAchse = KartenKonstanten.LeerYAchse and KoordinatenExtern.XAchse = KartenKonstanten.LeerXAchse)
              );
     
   procedure KIBeschäftigtNachfolger
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AufgabeExtern : in KIDatentypen.Einheit_Aufgabe_Enum)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );
     
   procedure KIVerbesserung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      BeschäftigungExtern : in AufgabenDatentypen.Einheiten_Aufgaben_Enum)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );
   
   procedure KIBewegungPlan
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PlanplatzExtern : in EinheitenDatentypen.BewegungsplanVorhanden)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 (if KoordinatenExtern.YAchse = KartenKonstanten.LeerYAchse then KoordinatenExtern.XAchse = KartenKonstanten.LeerXAchse and KoordinatenExtern.EAchse = KartenKonstanten.LeerEAchse)
               and
                 (if KoordinatenExtern.XAchse = KartenKonstanten.LeerXAchse then KoordinatenExtern.YAchse = KartenKonstanten.LeerYAchse and KoordinatenExtern.EAchse = KartenKonstanten.LeerEAchse)
               and
                 (if KoordinatenExtern.EAchse = KartenKonstanten.LeerEAchse then KoordinatenExtern.YAchse = KartenKonstanten.LeerYAchse and KoordinatenExtern.XAchse = KartenKonstanten.LeerXAchse)
              );
   
   procedure KIBewegungsplanLeeren
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );
      
   procedure Transportiert
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      LadungExtern : in EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      LadungsplatzExtern : in EinheitenDatentypen.Transportplätze)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure WirdTransportiert
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      TransporterExtern : in EinheitenDatentypen.MaximaleEinheitenMitNullWert)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
      
   procedure Meldungen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      MeldungExtern : in EinheitenDatentypen.Einheit_Meldung_Enum;
      WelcheMeldungExtern : in EinheitenDatentypen.Einheit_Meldung_Art_Enum)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure LeerMeldungen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure Nullsetzung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure Standardwerte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenID;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      StadtNummerExtern : in StadtDatentypen.MaximaleStädteMitNullWert)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 (if KoordinatenExtern.YAchse = KartenKonstanten.LeerYAchse then KoordinatenExtern.XAchse = KartenKonstanten.LeerXAchse and KoordinatenExtern.EAchse = KartenKonstanten.LeerEAchse)
               and
                 (if KoordinatenExtern.XAchse = KartenKonstanten.LeerXAchse then KoordinatenExtern.YAchse = KartenKonstanten.LeerYAchse and KoordinatenExtern.EAchse = KartenKonstanten.LeerEAchse)
               and
                 (if KoordinatenExtern.EAchse = KartenKonstanten.LeerEAchse then KoordinatenExtern.YAchse = KartenKonstanten.LeerYAchse and KoordinatenExtern.XAchse = KartenKonstanten.LeerXAchse)
              );
   
   procedure GanzerEintrag
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      EintragExtern : in EinheitenRecords.EinheitenGebautRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure Standardeinstellungen;
   
private
   
   Beförderungsgrenze : KampfDatentypen.ErfahrungspunkteVorhanden;
   
   MaximaleLebenspunkte : EinheitenDatentypen.VorhandeneLebenspunkte;
   
   MaximaleBewegungspunkte : EinheitenDatentypen.VorhandeneBewegungspunkte;

end SchreibeEinheitenGebaut;