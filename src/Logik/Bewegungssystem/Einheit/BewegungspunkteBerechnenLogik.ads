pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with EinheitenDatentypen;
with SpielVariablen;
with KartenRecords;
with EinheitenRecords;
with Weltkarte;

package BewegungspunkteBerechnenLogik is
   
   function AbzugDurchBewegung
     (NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return EinheitenDatentypen.BewegungFloat
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 NeueKoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 NeueKoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
private
   
   EinheitID : EinheitenDatentypen.EinheitenIDMitNullWert;
      
   KleinerAbzug : constant EinheitenDatentypen.VorhandeneBewegungspunkte := 1.00;
   MittlererAbzug : constant EinheitenDatentypen.VorhandeneBewegungspunkte := 2.00;
   GroßerAbzug : constant EinheitenDatentypen.VorhandeneBewegungspunkte := 3.00;
   KeinAbzug : constant EinheitenDatentypen.VorhandeneBewegungspunkte := 0.00;
   Bewegungsbonus : EinheitenDatentypen.VorhandeneBewegungspunkte;
   
   Gesamtgrund : KartenRecords.KartengrundRecord;
   
   -- Sollte man das in was Globales verschieben? äöü
   type Bewegungsbonus_Enum is (
                                Leer_Enum,
                                Fluss_Enum,
                                Straße_Enum, Tunnel_Enum, Schiene_Enum
                               );
   
   type BewegungsmodifikatorArray is array (Bewegungsbonus_Enum'Range) of EinheitenDatentypen.VorhandeneBewegungspunkte;
   Bewegungsmodifikator : constant BewegungsmodifikatorArray := (
                                                                 Leer_Enum         => 0.00,
                                                                 Fluss_Enum        => 0.50,
                                                                 Straße_Enum       => 0.50,
                                                                 Tunnel_Enum       => 0.50,
                                                                 Schiene_Enum      => 1.00
                                                                );
   
   

   function StraßeUndFlussPrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Bewegungsbonus_Enum
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 NeueKoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 NeueKoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

end BewegungspunkteBerechnenLogik;
