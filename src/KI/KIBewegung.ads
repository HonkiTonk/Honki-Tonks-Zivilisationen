with BewegungssystemEinheiten, GlobaleVariablen, GlobaleDatentypen, Karten, SchleifenPruefungen, GlobaleRecords;
use GlobaleDatentypen, GlobaleRecords;

with KIVariablen;

package KIBewegung is
   
   procedure KIBewegung (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive; Aufgabe : Wide_Wide_Character);

private

   ImWeg : Boolean;
   AltePosition : Boolean;
   
   Kartenwert : GlobaleRecords.AchsenAusKartenfeld;
   BewegungZiel : GlobaleRecords.AchsenAusKartenfeldPositiv;
   EinheitImWeg : GlobaleRecords.RasseUndPlatznummerRecord;
   StadtImWeg : GlobaleRecords.RasseUndPlatznummerRecord;

   procedure BewegungSiedler (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive);
   procedure BewegungBauarbeiter (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive);
   procedure BewegungBodenEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive);
   procedure BewegungLuftEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive);
   procedure BewegungWasserEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive);
   procedure BewegungUnterwasserEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive);

   procedure BewegungDurchführen (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive; EAchse : in GlobaleDatentypen.Ebene; YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv);

   function ZeugImWeg (EAchse : in GlobaleDatentypen.Ebene; YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) return Boolean;
   function IstDasEineAltePosition (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive; EAchse : in GlobaleDatentypen.Ebene; YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) return Boolean;

end KIBewegung;
