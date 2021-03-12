pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen, KIDatentypen;
use GlobaleDatentypen, KIDatentypen;

with Karten;

package KIBewegung is
   
   procedure KIBewegung (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; Aufgabe : in KIDatentypen.Aufgabe_Enum) with
     Pre => (EinheitRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) = 2));

   procedure NeuesZielErmittelnGefahr (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; RichtungExtern : in KIDatentypen.Richtung_Enum) with
     Pre => (EinheitRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (RichtungExtern = KIDatentypen.Norden or RichtungExtern = Nord_Ost or RichtungExtern = Osten or RichtungExtern = Süd_Ost or RichtungExtern = Süden or RichtungExtern = Süd_West or RichtungExtern = Westen
               or RichtungExtern = Nord_West or RichtungExtern = Beliebig) and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) = 2));

private

   AltePosition : Boolean;
   ErfolgreichBewegt : Boolean;
   
   Bewegung : GlobaleDatentypen.LoopRangeMinusEinsZuEins;

   ZielKoordinaten : GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord;
   
   Kartenwert : GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord;

   procedure BewegungBeliebig (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (EinheitRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) = 2));

   procedure BewegungBauarbeiter (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (EinheitRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) = 2));

   procedure BewegungBodenEinheit (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (EinheitRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) = 2));

   procedure BewegungLuftEinheit (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (EinheitRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) = 2));

   procedure BewegungWasserEinheit (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (EinheitRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) = 2));

   procedure BewegungUnterwasserEinheit (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (EinheitRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) = 2));

   procedure BewegungUnterirdischeEinheit (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (EinheitRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) = 2));

   procedure BewegungOrbitaleEinheit (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (EinheitRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) = 2));

   procedure BewegungDurchführen (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; EAchse : in GlobaleDatentypen.EbeneVorhanden; YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) with
     Pre => (EinheitRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) = 2));


   function Bewegen (Durchgang : in Positive; EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; EAchse : in GlobaleDatentypen.EbeneVorhanden;
                     YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) return Boolean with
     Pre => (EinheitRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) = 2));

   function IstDasEineAltePosition (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; EAchse : in GlobaleDatentypen.EbeneVorhanden;
                                    YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) return Boolean with
     Pre => (EinheitRasseNummer.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2) and EinheitRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
             and (if EinheitRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) = 2));

end KIBewegung;
