with BewegungssystemEinheiten, GlobaleVariablen, GlobaleDatentypen, Karten, SchleifenPruefungen;
use GlobaleDatentypen;

package KIBewegung is
   
   procedure KIBewegung (Rasse : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord);

private
   
   Kartenwert : GlobaleDatentypen.AchsenAusKartenfeld;
   Bewegungsziel : GlobaleDatentypen.AchsenAusKartenfeldPositiv;

   procedure BewegungSiedler (Rasse : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord);
   procedure BewegungBauarbeiter (Rasse : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord);
   procedure BewegungBodenEinheit (Rasse : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord);
   procedure BewegungLuftEinheit (Rasse : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord);
   procedure BewegungWasserEinheit (Rasse : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord);
   procedure BewegungUnterwasserEinheit (Rasse : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord);

end KIBewegung;
