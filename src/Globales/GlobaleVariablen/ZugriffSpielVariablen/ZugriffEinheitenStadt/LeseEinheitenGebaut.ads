with SpeziesDatentypen;
with EinheitenDatentypen;
with KartenDatentypen;
with StadtDatentypen;
with EinheitenRecords;
with KartenRecords;
with AufgabenDatentypen;
with KampfDatentypen;
with KartenKonstanten;
with ProduktionDatentypen;
with EinheitenKonstanten;

with LeseWeltkarteneinstellungen;
with LeseGrenzen;
with LeseSpeziesbelegung;

with KIDatentypen;

package LeseEinheitenGebaut is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;
   use type KartenDatentypen.Ebene;
   use type EinheitenDatentypen.Einheitenbereich;

   function ID
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenDatentypen.EinheitenID;
   --  with
    --   Pre => (
    --            EinheitSpeziesNummerExtern.Nummer in LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
                 --  and
               --    LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
     --         );

   function Koordinaten
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KartenRecords.KartenfeldNaturalRecord
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
                 --  and
               --    LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
         
       Post => (
                  Koordinaten'Result.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
                and
                  Koordinaten'Result.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
                and
                  (if Koordinaten'Result.Senkrechte = KartenKonstanten.LeerSenkrechte then Koordinaten'Result.Waagerechte = KartenKonstanten.LeerWaagerechte and Koordinaten'Result.Ebene = KartenKonstanten.LeerEbene)
                and
                  (if Koordinaten'Result.Waagerechte = KartenKonstanten.LeerWaagerechte then Koordinaten'Result.Senkrechte = KartenKonstanten.LeerSenkrechte and Koordinaten'Result.Ebene = KartenKonstanten.LeerEbene)
                and
                  (if Koordinaten'Result.Ebene = KartenKonstanten.LeerEbene then Koordinaten'Result.Senkrechte = KartenKonstanten.LeerSenkrechte and Koordinaten'Result.Waagerechte = KartenKonstanten.LeerWaagerechte)
               );
   pragma Inline (Koordinaten);
   
   function Heimatstadt
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return StadtDatentypen.Städtebereich
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (Heimatstadt);
      
   function Lebenspunkte
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KampfDatentypen.Lebenspunkte
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function Bewegungspunkte
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenDatentypen.BewegungspunkteVorhanden
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (Bewegungspunkte);
   
   function Erfahrungspunkte
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KampfDatentypen.Erfahrungspunkte
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function Rang
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KampfDatentypen.Rang
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
      
   function Beschäftigung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return AufgabenDatentypen.Einheiten_Aufgaben_Enum
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (Beschäftigung);
   
   function BeschäftigungNachfolger
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return AufgabenDatentypen.Einheiten_Aufgaben_Enum
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (BeschäftigungNachfolger);
      
   function Beschäftigungszeit
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return ProduktionDatentypen.Arbeitszeit
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (Beschäftigungszeit);
   
   function BeschäftigungszeitNachfolger
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return ProduktionDatentypen.Arbeitszeit
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (BeschäftigungszeitNachfolger);
   
   function BeschäftigungSpeichern
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenRecords.ArbeitRecord
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (BeschäftigungSpeichern);
   
   function BeschäftigungNachfolgerSpeichern
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenRecords.ArbeitRecord
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (BeschäftigungNachfolgerSpeichern);
      
   -- Die KIZugriffe müssen auch für menschliche Spieler lesbar sein wegen dem Debugsystem.
   function KIZielKoordinaten
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KartenRecords.KartenfeldNaturalRecord
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
         
       Post => (
                  KIZielKoordinaten'Result.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
                and
                  KIZielKoordinaten'Result.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
                and
                  (if KIZielKoordinaten'Result.Senkrechte = KartenKonstanten.LeerSenkrechte then
                         KIZielKoordinaten'Result.Waagerechte = KartenKonstanten.LeerWaagerechte and KIZielKoordinaten'Result.Ebene = KartenKonstanten.LeerEbene)
                and
                  (if KIZielKoordinaten'Result.Waagerechte = KartenKonstanten.LeerWaagerechte then
                         KIZielKoordinaten'Result.Senkrechte = KartenKonstanten.LeerSenkrechte and KIZielKoordinaten'Result.Ebene = KartenKonstanten.LeerEbene)
                and
                  (if KIZielKoordinaten'Result.Ebene = KartenKonstanten.LeerEbene then
                         KIZielKoordinaten'Result.Senkrechte = KartenKonstanten.LeerSenkrechte and KIZielKoordinaten'Result.Waagerechte = KartenKonstanten.LeerWaagerechte)
               );
   pragma Inline (KIZielKoordinaten);
   
   function KIBeschäftigt
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KIDatentypen.Einheit_Aufgabe_Enum
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (KIBeschäftigt);
   
   function KIZielKoordinatenNachfolger
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KartenRecords.KartenfeldNaturalRecord
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
         
       Post => (
                  KIZielKoordinatenNachfolger'Result.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
                and
                  KIZielKoordinatenNachfolger'Result.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
                and
                  (if KIZielKoordinatenNachfolger'Result.Senkrechte = KartenKonstanten.LeerSenkrechte then
                         KIZielKoordinatenNachfolger'Result.Waagerechte = KartenKonstanten.LeerWaagerechte and KIZielKoordinatenNachfolger'Result.Ebene = KartenKonstanten.LeerEbene)
                and
                  (if KIZielKoordinatenNachfolger'Result.Waagerechte = KartenKonstanten.LeerWaagerechte then
                         KIZielKoordinatenNachfolger'Result.Senkrechte = KartenKonstanten.LeerSenkrechte and KIZielKoordinatenNachfolger'Result.Ebene = KartenKonstanten.LeerEbene)
                and
                  (if KIZielKoordinatenNachfolger'Result.Ebene = KartenKonstanten.LeerEbene then
                         KIZielKoordinatenNachfolger'Result.Senkrechte = KartenKonstanten.LeerSenkrechte and KIZielKoordinatenNachfolger'Result.Waagerechte = KartenKonstanten.LeerWaagerechte)
               );
   pragma Inline (KIZielKoordinatenNachfolger);
     
   function KIBeschäftigtNachfolger
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KIDatentypen.Einheit_Aufgabe_Enum
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (KIBeschäftigtNachfolger);
   
   function KIVerbesserung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return AufgabenDatentypen.Einheiten_Aufgaben_Enum
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (KIVerbesserung);
   
   function KIBewegungPlan
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      PlanschrittExtern : in EinheitenDatentypen.BewegungsplanVorhanden)
      return KartenRecords.KartenfeldNaturalRecord
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
         
       Post => (
                  KIBewegungPlan'Result.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
                and
                  KIBewegungPlan'Result.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
                and
                  (if KIBewegungPlan'Result.Senkrechte = KartenKonstanten.LeerSenkrechte then
                         KIBewegungPlan'Result.Waagerechte = KartenKonstanten.LeerWaagerechte and KIBewegungPlan'Result.Ebene = KartenKonstanten.LeerEbene)
                and
                  (if KIBewegungPlan'Result.Waagerechte = KartenKonstanten.LeerWaagerechte then
                         KIBewegungPlan'Result.Senkrechte = KartenKonstanten.LeerSenkrechte and KIBewegungPlan'Result.Ebene = KartenKonstanten.LeerEbene)
                and
                  (if KIBewegungPlan'Result.Ebene = KartenKonstanten.LeerEbene then
                         KIBewegungPlan'Result.Senkrechte = KartenKonstanten.LeerSenkrechte and KIBewegungPlan'Result.Waagerechte = KartenKonstanten.LeerWaagerechte)
               );
   pragma Inline (KIBewegungPlan);
      
   function Transportiert
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      PlatzExtern : in EinheitenDatentypen.Transportplätze)
      return EinheitenDatentypen.Einheitenbereich
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (Transportiert);
   
   function WirdTransportiert
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenDatentypen.Einheitenbereich
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (WirdTransportiert);
      
   function Meldungen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      WelcheMeldungExtern : in EinheitenDatentypen.Einheit_Meldung_Art_Enum)
      return EinheitenDatentypen.Einheit_Meldung_Enum
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (Meldungen);
   
   function AlleMeldungen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenRecords.EinheitMeldungenArray
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (AlleMeldungen);
   
   function GanzerEintrag
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenRecords.EinheitenGebautRecord
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (GanzerEintrag);
   
private
   
   EinheitID : EinheitenDatentypen.EinheitenID;
   
   Beförderungsgrenze : KampfDatentypen.Erfahrungspunkte;
   MaximalerRang : KampfDatentypen.Rang;
   
   ErlaubteLebenspunkte : KampfDatentypen.LebenspunkteVorhanden;

end LeseEinheitenGebaut;
