with SpeziesDatentypen;
with KartenDatentypen;
with EinheitenDatentypen;
with KartenRecords;
with EinheitenRecords;
with EinheitenKonstanten;

with LeseWeltkarteneinstellungen;
with LeseGrenzen;
with LeseSpeziesbelegung;

package BewegungspunkteBerechnenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;
   use type EinheitenDatentypen.BewegungspunkteBasis;
   
   function Bewegungspunkte
     (NeueKoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenDatentypen.BewegungspunkteBasis
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 NeueKoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 NeueKoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function NotwendigeBewegungspunkte
     (NeueKoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenDatentypen.BewegungspunkteVorhanden
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 NeueKoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 NeueKoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              ),
         
       Post => (
                  NotwendigeBewegungspunkte'Result > 0
               );
   
private
   
   Gesamtgrund : KartenRecords.KartengrundRecord;
   
   EinheitID : EinheitenDatentypen.EinheitenIDBasis;
   
   AktuelleBewegungspunkte : EinheitenDatentypen.BewegungspunkteVorhanden;
   
   BenötigteBewegungspunkte : EinheitenDatentypen.BewegungspunkteBasis;
   BewegungspunkteNotwendig : EinheitenDatentypen.BewegungspunkteBasis;
   
   BewegungspunkteGesamt : Positive;
   
   

   function NotwendigeBewegungspunkteErmitteln
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return EinheitenDatentypen.BewegungspunkteBasis
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 NeueKoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 NeueKoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

end BewegungspunkteBerechnenLogik;
