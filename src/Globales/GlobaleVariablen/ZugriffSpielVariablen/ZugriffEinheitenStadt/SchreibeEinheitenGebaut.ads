with KartenDatentypen;
with SpeziesDatentypen;
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
with LeseSpeziesbelegung;

with KIDatentypen;

package SchreibeEinheitenGebaut is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;
   use type KartenDatentypen.Ebene;

   procedure ID
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenID)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (ID);
   
   procedure Koordinaten
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      EinheitentauschExtern : in Boolean)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 (if KoordinatenExtern.Senkrechte = KartenKonstanten.LeerSenkrechte then KoordinatenExtern.Waagerechte = KartenKonstanten.LeerWaagerechte and KoordinatenExtern.Ebene = KartenKonstanten.LeerEbene)
               and
                 (if KoordinatenExtern.Waagerechte = KartenKonstanten.LeerWaagerechte then KoordinatenExtern.Senkrechte = KartenKonstanten.LeerSenkrechte and KoordinatenExtern.Ebene = KartenKonstanten.LeerEbene)
               and
                 (if KoordinatenExtern.Ebene = KartenKonstanten.LeerEbene then KoordinatenExtern.Senkrechte = KartenKonstanten.LeerSenkrechte and KoordinatenExtern.Waagerechte = KartenKonstanten.LeerWaagerechte)
              );
   
   procedure KoordinatenLaden
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      KartenplatzierungExtern : in Boolean)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 (if KoordinatenExtern.Senkrechte = KartenKonstanten.LeerSenkrechte then KoordinatenExtern.Waagerechte = KartenKonstanten.LeerWaagerechte and KoordinatenExtern.Ebene = KartenKonstanten.LeerEbene)
               and
                 (if KoordinatenExtern.Waagerechte = KartenKonstanten.LeerWaagerechte then KoordinatenExtern.Senkrechte = KartenKonstanten.LeerSenkrechte and KoordinatenExtern.Ebene = KartenKonstanten.LeerEbene)
               and
                 (if KoordinatenExtern.Ebene = KartenKonstanten.LeerEbene then KoordinatenExtern.Senkrechte = KartenKonstanten.LeerSenkrechte and KoordinatenExtern.Waagerechte = KartenKonstanten.LeerWaagerechte)
              );
   
   procedure Heimatstadt
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      HeimatstadtExtern : in StadtDatentypen.Städtebereich)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (Heimatstadt);
   
   procedure Lebenspunkte
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      LebenspunkteExtern : in KampfDatentypen.Lebenspunkte;
      RechnenSetzenExtern : in Boolean)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure Bewegungspunkte
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      BewegungspunkteExtern : in EinheitenDatentypen.Bewegungspunkte;
      RechnenSetzenExtern : in Boolean)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure Erfahrungspunkte
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      ErfahrungspunkteExtern : in KampfDatentypen.Erfahrungspunkte;
      AddierenSetzenExtern : in Boolean)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure Rang
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      RangExtern : in KampfDatentypen.Rang;
      AddierenSetzenExtern : in Boolean)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure Beschäftigung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      BeschäftigungExtern : in AufgabenDatentypen.Einheiten_Aufgaben_Enum)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (Beschäftigung);
   
   procedure BeschäftigungNachfolger
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      BeschäftigungExtern : in AufgabenDatentypen.Einheiten_Aufgaben_Enum)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (BeschäftigungNachfolger);
   
   procedure Beschäftigungszeit
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      ZeitExtern : in ProduktionDatentypen.Arbeitszeit;
      RechnenSetzenExtern : in Boolean)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure BeschäftigungszeitNachfolger
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      ZeitExtern : in ProduktionDatentypen.Arbeitszeit;
      RechnenSetzenExtern : in Boolean)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure BeschäftigungLaden
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      BeschäftigungExtern : in EinheitenRecords.ArbeitRecord;
      BeschäftigungNachfolgerExtern : in EinheitenRecords.ArbeitRecord)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure KIZielKoordinaten
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 (if KoordinatenExtern.Senkrechte = KartenKonstanten.LeerSenkrechte then KoordinatenExtern.Waagerechte = KartenKonstanten.LeerWaagerechte and KoordinatenExtern.Ebene = KartenKonstanten.LeerEbene)
               and
                 (if KoordinatenExtern.Waagerechte = KartenKonstanten.LeerWaagerechte then KoordinatenExtern.Senkrechte = KartenKonstanten.LeerSenkrechte and KoordinatenExtern.Ebene = KartenKonstanten.LeerEbene)
               and
                 (if KoordinatenExtern.Ebene = KartenKonstanten.LeerEbene then KoordinatenExtern.Senkrechte = KartenKonstanten.LeerSenkrechte and KoordinatenExtern.Waagerechte = KartenKonstanten.LeerWaagerechte)
              );
   pragma Inline (KIZielKoordinaten);
   
   procedure KIBeschäftigt
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      AufgabeExtern : in KIDatentypen.Einheit_Aufgabe_Enum)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
               -- Kann hier nicht nur auf KISpieler prüfen, da in VerbesserungFertiggestelltLogik/AufgabeNachfolgerVerschieben es auch bei menschlichem Spieler gesetzt wird.
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (KIBeschäftigt);
   
   procedure KIZielKoordinatenNachfolger
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
               and
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 (if KoordinatenExtern.Senkrechte = KartenKonstanten.LeerSenkrechte then KoordinatenExtern.Waagerechte = KartenKonstanten.LeerWaagerechte and KoordinatenExtern.Ebene = KartenKonstanten.LeerEbene)
               and
                 (if KoordinatenExtern.Waagerechte = KartenKonstanten.LeerWaagerechte then KoordinatenExtern.Senkrechte = KartenKonstanten.LeerSenkrechte and KoordinatenExtern.Ebene = KartenKonstanten.LeerEbene)
               and
                 (if KoordinatenExtern.Ebene = KartenKonstanten.LeerEbene then KoordinatenExtern.Senkrechte = KartenKonstanten.LeerSenkrechte and KoordinatenExtern.Waagerechte = KartenKonstanten.LeerWaagerechte)
              );
   pragma Inline (KIZielKoordinatenNachfolger);
     
   procedure KIBeschäftigtNachfolger
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      AufgabeExtern : in KIDatentypen.Einheit_Aufgabe_Enum)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
   pragma Inline (KIBeschäftigtNachfolger);
     
   procedure KIVerbesserung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      BeschäftigungExtern : in AufgabenDatentypen.Einheiten_Aufgaben_Enum)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
   pragma Inline (KIVerbesserung);
   
   procedure KIBewegungPlan
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      PlanplatzExtern : in EinheitenDatentypen.BewegungsplanVorhanden)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 (if KoordinatenExtern.Senkrechte = KartenKonstanten.LeerSenkrechte then KoordinatenExtern.Waagerechte = KartenKonstanten.LeerWaagerechte and KoordinatenExtern.Ebene = KartenKonstanten.LeerEbene)
               and
                 (if KoordinatenExtern.Waagerechte = KartenKonstanten.LeerWaagerechte then KoordinatenExtern.Senkrechte = KartenKonstanten.LeerSenkrechte and KoordinatenExtern.Ebene = KartenKonstanten.LeerEbene)
               and
                 (if KoordinatenExtern.Ebene = KartenKonstanten.LeerEbene then KoordinatenExtern.Senkrechte = KartenKonstanten.LeerSenkrechte and KoordinatenExtern.Waagerechte = KartenKonstanten.LeerWaagerechte)
              );
   pragma Inline (KIBewegungPlan);
   
   procedure KIBewegungsplanLeeren
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (KIBewegungsplanLeeren);
      
   procedure Transportiert
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      LadungExtern : in EinheitenDatentypen.Einheitenbereich;
      LadungsplatzExtern : in EinheitenDatentypen.Transportplätze)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (Transportiert);
   
   procedure GesamteLadung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      LadungExtern : in EinheitenRecords.TransporterArray)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (GesamteLadung);
   
   procedure WirdTransportiert
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      TransporterExtern : in EinheitenDatentypen.Einheitenbereich)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (WirdTransportiert);
      
   procedure Meldungen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      MeldungExtern : in EinheitenDatentypen.Einheit_Meldung_Enum;
      WelcheMeldungExtern : in EinheitenDatentypen.Einheit_Meldung_Art_Enum)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (Meldungen);
   
   procedure AlleMeldungen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      MeldungExtern : in EinheitenRecords.EinheitMeldungenArray)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (AlleMeldungen);
   
   procedure LeerMeldungen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (LeerMeldungen);
   
   procedure Nullsetzung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure Standardwerte
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenIDVorhanden;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      StadtNummerExtern : in StadtDatentypen.Städtebereich)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 (if KoordinatenExtern.Senkrechte = KartenKonstanten.LeerSenkrechte then KoordinatenExtern.Waagerechte = KartenKonstanten.LeerWaagerechte and KoordinatenExtern.Ebene = KartenKonstanten.LeerEbene)
               and
                 (if KoordinatenExtern.Waagerechte = KartenKonstanten.LeerWaagerechte then KoordinatenExtern.Senkrechte = KartenKonstanten.LeerSenkrechte and KoordinatenExtern.Ebene = KartenKonstanten.LeerEbene)
               and
                 (if KoordinatenExtern.Ebene = KartenKonstanten.LeerEbene then KoordinatenExtern.Senkrechte = KartenKonstanten.LeerSenkrechte and KoordinatenExtern.Waagerechte = KartenKonstanten.LeerWaagerechte)
              );
   
   procedure GanzerEintrag
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      EintragExtern : in EinheitenRecords.EinheitenGebautRecord)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure Standardeinstellungen;
   pragma Inline (Standardeinstellungen);
   
   procedure Standardbewegungsplan;
   pragma Inline (Standardbewegungsplan);
   
private
   
   Beförderungsgrenze : KampfDatentypen.ErfahrungspunkteVorhanden;
   
   MaximaleLebenspunkte : KampfDatentypen.LebenspunkteVorhanden;
   
   MaximaleBewegungspunkte : EinheitenDatentypen.BewegungspunkteVorhanden;

end SchreibeEinheitenGebaut;
