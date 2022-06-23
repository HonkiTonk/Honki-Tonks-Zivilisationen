pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with RassenDatentypen; use RassenDatentypen;
with StadtDatentypen; use StadtDatentypen;
with SonstigeVariablen;
with KartenRecords;
with SystemRecords;
with StadtRecords;
with SpielVariablen;

with Karten;

package StadtSuchen is
   
   function KoordinatenStadtMitRasseSuchen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return StadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
               and
                 SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              ),
                      
       Post => (
                  KoordinatenStadtMitRasseSuchen'Result <= SpielVariablen.Grenzen (RasseExtern).Städtegrenze
               );
   
   function KoordinatenStadtOhneRasseSuchen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return StadtRecords.RasseStadtnummerRecord
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );

   function KoordinatenStadtOhneSpezielleRasseSuchen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return StadtRecords.RasseStadtnummerRecord
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
               and
                 SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function StadtNachNamenSuchen
     return StadtRecords.RasseStadtnummerRecord
     with
       Post => (
                  StadtNachNamenSuchen'Result.Nummer <= SpielVariablen.Grenzen (StadtNachNamenSuchen'Result.Rasse).Städtegrenze
                and
                  SonstigeVariablen.RassenImSpiel (StadtNachNamenSuchen'Result.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               );

private
   
   StadtNummer : StadtDatentypen.MaximaleStädteMitNullWert;
   
   StadtName : SystemRecords.TextEingabeRecord;

end StadtSuchen;
