pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen, Karten;
use GlobaleDatentypen, GlobaleRecords;

package KIBewegung is
   
   procedure KIBewegung (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; Aufgabe : Wide_Wide_Character) with
     Pre => EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen;

private

   AltePosition : Boolean;
   ErfolgreichBewegt : Boolean;
   
   Bewegung : GlobaleDatentypen.LoopRangeMinusEinsZuEins;
   
   Kartenwert : GlobaleRecords.AchsenKartenfeldRecord;

   procedure BewegungBeliebig (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen;

   procedure BewegungBauarbeiter (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen;

   procedure BewegungBodenEinheit (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen;

   procedure BewegungLuftEinheit (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen;

   procedure BewegungWasserEinheit (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen;

   procedure BewegungUnterwasserEinheit (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen;

   procedure BewegungUnterirdischeEinheit (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen;

   procedure BewegungOrbitaleEinheit (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen;

   procedure BewegungDurchführen (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; EAchse : in GlobaleDatentypen.EbeneVorhanden; YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) with
     Pre => EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
     and YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;


   function Bewegen (Durchgang : in Positive; EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; EAchse : in GlobaleDatentypen.EbeneVorhanden;
                     YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) return Boolean with
     Pre => EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
     and YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

   function IstDasEineAltePosition (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; EAchse : in GlobaleDatentypen.EbeneVorhanden;
                                    YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) return Boolean with
     Pre => EinheitRasseNummer.Platznummer in GlobaleVariablen.EinheitenGebaut'Range (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
     and YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

end KIBewegung;
