pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with RassenDatentypen; use RassenDatentypen;
with EinheitenDatentypen; use EinheitenDatentypen;
with KartenRecords;
with EinheitenRecords;
with SpielVariablen;

with Karten;

package EinheitSuchen is

   function KoordinatenEinheitMitRasseSuchen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LogikGrafikExtern : in Boolean)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
               and
                 SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              ),
                      
       Post => (
                  KoordinatenEinheitMitRasseSuchen'Result <= SpielVariablen.Grenzen (RasseExtern).Einheitengrenze
               );

   function KoordinatenEinheitOhneRasseSuchen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LogikGrafikExtern : in Boolean)
      return EinheitenRecords.RasseEinheitnummerRecord
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );

   function KoordinatenEinheitOhneSpezielleRasseSuchen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LogikGrafikExtern : in Boolean)
      return EinheitenRecords.RasseEinheitnummerRecord
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
               and
                 SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function TransporterladungSuchen
     (TransporterExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      LadungsnummerExtern : in EinheitenDatentypen.MaximaleEinheitenMitNullWert)
      return Boolean;
   
private
   
   Transporterkapazität : EinheitenDatentypen.Transportplätze;
   
   type TransporternummerArray is array (Boolean'Range) of EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   Transporternummer : TransporternummerArray;
   
   type EinheitArray is array (Boolean'Range) of EinheitenRecords.RasseEinheitnummerRecord;
   Einheit : EinheitArray;
   
   
   
   function TransporterverschachtelungDurchgehen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      LogikGrafikExtern : in Boolean)
      return EinheitenRecords.RasseEinheitnummerRecord
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
end EinheitSuchen;
