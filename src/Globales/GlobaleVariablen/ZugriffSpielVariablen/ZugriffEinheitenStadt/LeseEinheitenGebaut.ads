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
   use type KartenDatentypen.Kartenfeld;
   use type KartenDatentypen.Ebene;

   function ID
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenDatentypen.EinheitenIDMitNullWert
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
             --  and
             --    LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   function Koordinaten
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
             --  and
             --    LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
         
       Post => (
                  Koordinaten'Result.YAchse <= LeseWeltkarteneinstellungen.YAchse
                and
                  Koordinaten'Result.XAchse <= LeseWeltkarteneinstellungen.XAchse
                and
                  (if Koordinaten'Result.YAchse = KartenKonstanten.LeerYAchse then Koordinaten'Result.XAchse = KartenKonstanten.LeerXAchse and Koordinaten'Result.EAchse = KartenKonstanten.LeerEAchse)
                and
                  (if Koordinaten'Result.XAchse = KartenKonstanten.LeerXAchse then Koordinaten'Result.YAchse = KartenKonstanten.LeerYAchse and Koordinaten'Result.EAchse = KartenKonstanten.LeerEAchse)
                and
                  (if Koordinaten'Result.EAchse = KartenKonstanten.LeerEAchse then Koordinaten'Result.YAchse = KartenKonstanten.LeerYAchse and Koordinaten'Result.XAchse = KartenKonstanten.LeerXAchse)
               );
   
   function Heimatstadt
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return StadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
      
   function Lebenspunkte
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenDatentypen.Lebenspunkte
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function Bewegungspunkte
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenDatentypen.VorhandeneBewegungspunkte
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
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
   
   function BeschäftigungNachfolger
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return AufgabenDatentypen.Einheiten_Aufgaben_Enum
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
      
   function Beschäftigungszeit
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return ProduktionDatentypen.Arbeitszeit
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function BeschäftigungszeitNachfolger
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return ProduktionDatentypen.Arbeitszeit
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
      
   -- Die KIZugriffe müssen auch für menschliche Spieler lesbar sein wegen dem Debugsystem.
   function KIZielKoordinaten
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
         
       Post => (
                  KIZielKoordinaten'Result.YAchse <= LeseWeltkarteneinstellungen.YAchse
                and
                  KIZielKoordinaten'Result.XAchse <= LeseWeltkarteneinstellungen.XAchse
                and
                  (if KIZielKoordinaten'Result.YAchse = KartenKonstanten.LeerYAchse then KIZielKoordinaten'Result.XAchse = KartenKonstanten.LeerXAchse and KIZielKoordinaten'Result.EAchse = KartenKonstanten.LeerEAchse)
                and
                  (if KIZielKoordinaten'Result.XAchse = KartenKonstanten.LeerXAchse then KIZielKoordinaten'Result.YAchse = KartenKonstanten.LeerYAchse and KIZielKoordinaten'Result.EAchse = KartenKonstanten.LeerEAchse)
                and
                  (if KIZielKoordinaten'Result.EAchse = KartenKonstanten.LeerEAchse then KIZielKoordinaten'Result.YAchse = KartenKonstanten.LeerYAchse and KIZielKoordinaten'Result.XAchse = KartenKonstanten.LeerXAchse)
               );
   
   function KIBeschäftigt
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KIDatentypen.Einheit_Aufgabe_Enum
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function KIZielKoordinatenNachfolger
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
         
       Post => (
                  KIZielKoordinatenNachfolger'Result.YAchse <= LeseWeltkarteneinstellungen.YAchse
                and
                  KIZielKoordinatenNachfolger'Result.XAchse <= LeseWeltkarteneinstellungen.XAchse
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
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KIDatentypen.Einheit_Aufgabe_Enum
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function KIVerbesserung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return AufgabenDatentypen.Einheiten_Aufgaben_Enum
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function KIBewegungPlan
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      PlanschrittExtern : in EinheitenDatentypen.BewegungsplanVorhanden)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
         
       Post => (
                  KIBewegungPlan'Result.YAchse <= LeseWeltkarteneinstellungen.YAchse
                and
                  KIBewegungPlan'Result.XAchse <= LeseWeltkarteneinstellungen.XAchse
                and
                  (if KIBewegungPlan'Result.YAchse = KartenKonstanten.LeerYAchse then KIBewegungPlan'Result.XAchse = KartenKonstanten.LeerXAchse and KIBewegungPlan'Result.EAchse = KartenKonstanten.LeerEAchse)
                and
                  (if KIBewegungPlan'Result.XAchse = KartenKonstanten.LeerXAchse then KIBewegungPlan'Result.YAchse = KartenKonstanten.LeerYAchse and KIBewegungPlan'Result.EAchse = KartenKonstanten.LeerEAchse)
                and
                  (if KIBewegungPlan'Result.EAchse = KartenKonstanten.LeerEAchse then KIBewegungPlan'Result.YAchse = KartenKonstanten.LeerYAchse and KIBewegungPlan'Result.XAchse = KartenKonstanten.LeerXAchse)
               );
      
   function Transportiert
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      PlatzExtern : in EinheitenDatentypen.Transportplätze)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function WirdTransportiert
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
      
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
   
   function GanzerEintrag
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenRecords.EinheitenGebautRecord
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
private
   
   EinheitID : EinheitenDatentypen.EinheitenIDMitNullWert;
   
   Beförderungsgrenze : KampfDatentypen.Erfahrungspunkte;
   MaximalerRang : KampfDatentypen.Rang;
   
   ErlaubteLebenspunkte : EinheitenDatentypen.VorhandeneLebenspunkte;

end LeseEinheitenGebaut;
