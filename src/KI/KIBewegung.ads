with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen, Karten;
use GlobaleDatentypen, GlobaleRecords;

package KIBewegung is
   
   procedure KIBewegung (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive; Aufgabe : Wide_Wide_Character) with
     Pre => EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2);

private

   AltePosition : Boolean;
   ErfolgreichBewegt : Boolean;
   
   Bewegung : GlobaleDatentypen.LoopRangeMinusEinsZuEins;
   
   Kartenwert : GlobaleRecords.AchsenAusKartenfeldRecord;

   procedure BewegungBeliebig (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive) with
     Pre => EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2);

   procedure BewegungBauarbeiter (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive) with
     Pre => EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2);

   procedure BewegungBodenEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive) with
     Pre => EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2);

   procedure BewegungLuftEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive) with
     Pre => EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2);

   procedure BewegungWasserEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive) with
     Pre => EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2);

   procedure BewegungUnterwasserEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive) with
     Pre => EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2);

   procedure BewegungUnterirdischeEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive) with
     Pre => EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2);

   procedure BewegungOrbitaleEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive) with
     Pre => EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2);

   procedure BewegungDurchführen (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive; EAchse : in GlobaleDatentypen.EbeneVorhanden; YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) with
     Pre => EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2) and YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;


   function Bewegen (Durchgang : in Positive; RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive; EAchse : in GlobaleDatentypen.EbeneVorhanden;
                     YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) return Boolean with
     Pre => EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2) and YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

   function IstDasEineAltePosition (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive; EAchse : in GlobaleDatentypen.EbeneVorhanden;
                                    YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) return Boolean with
     Pre => EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2) and YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

end KIBewegung;
