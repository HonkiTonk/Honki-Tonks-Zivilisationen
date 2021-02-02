with GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen, GlobaleRecords;

package KIBewegung is
   
   procedure KIBewegung (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive; Aufgabe : Wide_Wide_Character);

private

   AltePosition : Boolean;
   ErfolgreichBewegt : Boolean;
   
   Bewegung : GlobaleDatentypen.LoopRangeMinusEinsZuEins;
   
   Kartenwert : GlobaleRecords.AchsenAusKartenfeldRecord;

   procedure BewegungBeliebig (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive);
   procedure BewegungBauarbeiter (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive);
   procedure BewegungBodenEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive);
   procedure BewegungLuftEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive);
   procedure BewegungWasserEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive);
   procedure BewegungUnterwasserEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive);
   procedure BewegungDurchführen (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive; EAchse : in GlobaleDatentypen.Ebene; YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv);

   function Bewegen (Durchgang : in Positive; RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive; EAchse : in GlobaleDatentypen.Ebene; YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) return Boolean;
   function IstDasEineAltePosition (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive; EAchse : in GlobaleDatentypen.Ebene; YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) return Boolean;

end KIBewegung;
