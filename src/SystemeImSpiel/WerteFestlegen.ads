with Ada.Wide_Wide_Text_IO;
use Ada.Wide_Wide_Text_IO;

with GlobaleDatentypen, SchleifenPruefungen, KartenDatenbank, VerbesserungenDatenbank, Karten, GlobaleRecords;
use GlobaleDatentypen;

package WerteFestlegen is
   
   procedure KartenfelderBewerten (Generierung : Boolean; Koordinaten : in GlobaleRecords.AchsenAusKartenfeldPositiv) with
     Pre => Koordinaten.YAchse in Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and Koordinaten.XAchse in Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

private
   
   type KartenwertArray is array (-2 .. 2) of GlobaleRecords.AchsenAusKartenfeld;
   Kartenwert : KartenwertArray;

   procedure KartenfelderBewertenKleineSchleife (Koordinaten : in GlobaleRecords.AchsenAusKartenfeldPositiv) with
     Pre => Koordinaten.YAchse in Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and Koordinaten.XAchse in Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

   procedure BewertungSelbst (Koordinaten : in GlobaleRecords.AchsenAusKartenfeldPositiv; YAchseFeldAufschlag, XAchseFeldAufschlag : GlobaleDatentypen.KartenfeldPositiv; Teiler : GlobaleDatentypen.LoopRangeMinusDreiZuDrei) with
     Pre => Koordinaten.YAchse in Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and Koordinaten.XAchse in Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

end WerteFestlegen;
