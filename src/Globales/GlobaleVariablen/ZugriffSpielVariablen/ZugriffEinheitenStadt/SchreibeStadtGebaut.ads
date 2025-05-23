with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SpeziesDatentypen;
with EinheitenDatentypen;
with StadtDatentypen;
with KartenDatentypen;
with KartenRecords;
with KartenverbesserungDatentypen;
with ProduktionDatentypen;
with StadtRecords;
with KartenKonstanten;
with StadtKonstanten;
with StadtArrays;

with LeseWeltkarteneinstellungen;
with LeseGrenzen;
with LeseSpeziesbelegung;

with KIDatentypen;

package SchreibeStadtGebaut is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;
   use type KartenDatentypen.Ebene;
   use type StadtDatentypen.GebäudeID;
   use type EinheitenDatentypen.EinheitenID;

   procedure ID
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in KartenverbesserungDatentypen.Verbesserung_Stadt_ID_Enum)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (ID);
   
   procedure Koordinaten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
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
   
   procedure IDKoordinatenLaden
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in KartenverbesserungDatentypen.Verbesserung_Städte_Enum;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
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
   
   procedure EinwohnerArbeiter
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinwohnerArbeiterExtern : in Boolean;
      WachsenSchrumpfenExtern : in Boolean)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure EinwohnerArbeiterLaden
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinwohnerArbeiterExtern : in StadtRecords.EinwohnerArbeiterArray)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
      
   procedure Nahrungsmittel
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      NahrungsmittelExtern : in ProduktionDatentypen.Stadtproduktion;
      ÄndernSetzenExtern : in Boolean)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure Nahrungsproduktion
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      NahrungsproduktionExtern : in ProduktionDatentypen.Stadtproduktion;
      ÄndernSetzenExtern : in Boolean)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure Material
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      MaterialExtern : in ProduktionDatentypen.Produktion;
      ÄndernSetzenExtern : in Boolean)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure Produktionrate
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      ProduktionrateExtern : in ProduktionDatentypen.Stadtproduktion;
      ÄndernSetzenExtern : in Boolean)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure Geldgewinnung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      GeldgewinnungExtern : in ProduktionDatentypen.Stadtproduktion;
      ÄndernSetzenExtern : in Boolean)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure PermanenteKostenPosten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      WelcherPostenExtern : in ProduktionDatentypen.Permanente_Kosten_Vorhanden_Enum;
      KostenExtern : in ProduktionDatentypen.Stadtproduktion;
      ÄndernSetzenExtern : in Boolean)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure AlleKostenposten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      AlleKostenpostenExtern : in StadtRecords.PermanenteKostenArray)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
      
   procedure Forschungsrate
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      ForschungsrateExtern : in ProduktionDatentypen.Stadtproduktion;
      ÄndernSetzenExtern : in Boolean)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure Bauprojekt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      BauprojektExtern : in StadtRecords.BauprojektRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 (if BauprojektExtern.Gebäude /= 0 then BauprojektExtern.Einheit = 0)
               and
                 (if BauprojektExtern.Einheit /= 0 then BauprojektExtern.Gebäude = 0)
              );
   
   procedure Bauzeit
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure Korruption
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      KorruptionExtern : in ProduktionDatentypen.Stadtproduktion;
      ÄndernSetzenExtern : in Boolean)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure Zufriedenheit
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      ZufriedenheitExtern : in ProduktionDatentypen.Zufriedenheit;
      ÄndernSetzenExtern : in Boolean)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure GebäudeVorhanden
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      WelchesGebäudeExtern : in StadtDatentypen.GebäudeIDVorhanden;
      HinzufügenEntfernenExtern : in Boolean)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (GebäudeVorhanden);
   
   procedure AlleGebäude
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      GebäudeExtern : in StadtArrays.GebäudeArray)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (AlleGebäude);
   
   procedure Name
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      NameExtern : in Unbounded_Wide_Wide_String)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (Name);
   
   procedure UmgebungBewirtschaftung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      YKoordinateExtern : in KartenDatentypen.SenkrechteUmgebungDrei;
      XKoordinateExtern : in KartenDatentypen.WaagerechteUmgebungDrei;
      BelegenEntfernenExtern : in Boolean)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (UmgebungBewirtschaftung);
   
   procedure GesamteBewirtschaftung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      BewirtschaftungExtern : in StadtRecords.UmgebungBewirtschaftungArray)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (GesamteBewirtschaftung);
   
   procedure Gesamtumgebung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      UmgebungGrößeExtern : in KartenRecords.UmgebungDreiRecord;
      ÄndernSetzenExtern : in Boolean)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (Gesamtumgebung);
   
   procedure Umgebungssenkrechte
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      UmgebungExtern : in KartenDatentypen.SenkrechteUmgebungDrei;
      ÄndernSetzenExtern : in Boolean)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (Umgebungssenkrechte);
   
   procedure Umgebungswaagerechte
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      UmgebungExtern : in KartenDatentypen.WaagerechteUmgebungDrei;
      ÄndernSetzenExtern : in Boolean)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (Umgebungswaagerechte);
      
   procedure Meldungen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      WelcheMeldungExtern : in StadtDatentypen.Stadt_Meldung_Art_Enum;
      MeldungExtern : in StadtDatentypen.Stadt_Meldung_Enum)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (Meldungen);
   
   procedure AlleMeldungen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      MeldungenExtern : in StadtRecords.StadtMeldungenArray)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (AlleMeldungen);
   
   procedure LeerMeldungen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (LeerMeldungen);
      
   procedure KIBeschäftigung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      BeschäftigungExtern : in KIDatentypen.Stadt_Aufgabe_Enum)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (KIBeschäftigung);
   
   procedure Bewohnerentfernung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (Bewohnerentfernung);
   
   procedure Nullsetzung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
      
   procedure GanzerEintrag
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EintragExtern : in StadtRecords.StadtGebautRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (GanzerEintrag);
   
   procedure Standardeinstellungen;
   pragma Inline (Standardeinstellungen);
   
private
   
   AktuelleEinwohner : StadtDatentypen.Einwohner;
   AktuelleArbeiter : StadtDatentypen.Einwohner;
   
   Stadtkoordinaten : KartenRecords.KartenfeldNaturalRecord;

end SchreibeStadtGebaut;
