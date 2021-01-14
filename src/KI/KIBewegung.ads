with BewegungssystemEinheiten, GlobaleVariablen, GlobaleDatentypen, Karten, SchleifenPruefungen;
use GlobaleDatentypen;

package KIBewegung is
   
   procedure KIBewegung (RasseExtern : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;

private
   
   Kartenwert : GlobaleDatentypen.AchsenAusKartenfeld;
   Bewegungsziel : GlobaleDatentypen.AchsenAusKartenfeldPositiv;

   procedure BewegungSiedler (RasseExtern : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;
   procedure BewegungBauarbeiter (RasseExtern : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;
   procedure BewegungBodenEinheit (RasseExtern : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;
   procedure BewegungLuftEinheit (RasseExtern : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;
   procedure BewegungWasserEinheit (RasseExtern : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;
   procedure BewegungUnterwasserEinheit (RasseExtern : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;

end KIBewegung;
