with BewegungssystemEinheiten, GlobaleVariablen, GlobaleDatentypen, Karten, SchleifenPruefungen, KIRecords, GlobaleRecords;
use GlobaleDatentypen;

package KIBewegung is
   
   procedure KIBewegung (RasseExtern : in GlobaleDatentypen.Rassen; EinheitStatus : KIRecords.EinheitStatusRecord);

private
   
   Kartenwert : GlobaleRecords.AchsenAusKartenfeld;
   Bewegungsziel : GlobaleRecords.AchsenAusKartenfeldPositiv;

   procedure BewegungSiedler (RasseExtern : in GlobaleDatentypen.Rassen; EinheitStatus : KIRecords.EinheitStatusRecord);
   procedure BewegungBauarbeiter (RasseExtern : in GlobaleDatentypen.Rassen; EinheitStatus : KIRecords.EinheitStatusRecord);
   procedure BewegungBodenEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitStatus : KIRecords.EinheitStatusRecord);
   procedure BewegungLuftEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitStatus : KIRecords.EinheitStatusRecord);
   procedure BewegungWasserEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitStatus : KIRecords.EinheitStatusRecord);
   procedure BewegungUnterwasserEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitStatus : KIRecords.EinheitStatusRecord);

end KIBewegung;
