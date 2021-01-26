with BewegungssystemEinheiten, GlobaleVariablen, GlobaleDatentypen, Karten, SchleifenPruefungen, KIRecords, GlobaleRecords;
use GlobaleDatentypen;

package KIBewegung is
   
   procedure KIBewegung (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive; Aufgabe : Wide_Wide_Character);

private
   
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

end KIBewegung;
