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
   use type KartenDatentypen.Kartenfeld;
   use type EinheitenDatentypen.Bewegungspunkte;
   
   function Bewegungspunkte
     (NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenDatentypen.Bewegungspunkte
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 NeueKoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 NeueKoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   function NotwendigeBewegungspunkte
     (NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenDatentypen.VorhandeneBewegungspunkte
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 NeueKoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 NeueKoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              ),
         
       Post => (
                  NotwendigeBewegungspunkte'Result > 0
               );
   
private
   
   Gesamtgrund : KartenRecords.KartengrundRecord;
   
   EinheitID : EinheitenDatentypen.EinheitenIDMitNullWert;
   
   AktuelleBewegungspunkte : EinheitenDatentypen.VorhandeneBewegungspunkte;
   
   BenötigteBewegungspunkte : EinheitenDatentypen.Bewegungspunkte;
   BewegungspunkteNotwendig : EinheitenDatentypen.Bewegungspunkte;
   
   BewegungspunkteGesamt : Positive;
   
   

   function NotwendigeBewegungspunkteErmitteln
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return EinheitenDatentypen.Bewegungspunkte
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 NeueKoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 NeueKoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

end BewegungspunkteBerechnenLogik;
