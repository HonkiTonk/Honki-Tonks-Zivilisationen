with BewegungssystemEinheiten, GlobaleVariablen, GlobaleDatentypen, Karten, SchleifenPruefungen;
use GlobaleDatentypen;

package KIBewegung is
   
   procedure KIBewegung (RasseExtern : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord);

private
   
   Kartenwert : GlobaleDatentypen.AchsenAusKartenfeld;
   Bewegungsziel : GlobaleDatentypen.AchsenAusKartenfeldPositiv;

   procedure BewegungSiedler (RasseExtern : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord);
   procedure BewegungBauarbeiter (RasseExtern : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord);
   procedure BewegungBodenEinheit (RasseExtern : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord);
   procedure BewegungLuftEinheit (RasseExtern : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord);
   procedure BewegungWasserEinheit (RasseExtern : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord);
   procedure BewegungUnterwasserEinheit (RasseExtern : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord);

end KIBewegung;
