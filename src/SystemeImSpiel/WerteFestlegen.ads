with Ada.Wide_Wide_Text_IO;
use Ada.Wide_Wide_Text_IO;

with GlobaleDatentypen, SchleifenPruefungen, KartenDatenbank, VerbesserungenDatenbank, Karten, GlobaleRecords;
use GlobaleDatentypen;

package WerteFestlegen is
   
   procedure KartenfelderBewerten (Generierung : Boolean; EAchse : GlobaleDatentypen.Ebene; YAchse, XAchse : GlobaleDatentypen.KartenfeldPositiv) with
     Pre => EAchse > -3 and YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

private
   
   type KartenwertArray is array (-2 .. 2) of GlobaleRecords.AchsenAusKartenfeld;
   Kartenwert : KartenwertArray;

   procedure KartenfelderBewertenKleineSchleife (EAchse : GlobaleDatentypen.Ebene; YAchse, XAchse : GlobaleDatentypen.KartenfeldPositiv) with
     Pre => EAchse > -3 and YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

   procedure BewertungSelbst (EAchse : GlobaleDatentypen.Ebene; YAchse, XAchse, YAchseFeldAufschlag, XAchseFeldAufschlag : GlobaleDatentypen.KartenfeldPositiv; Teiler : GlobaleDatentypen.LoopRangeMinusDreiZuDrei) with
     Pre => EAchse > -3 and YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

end WerteFestlegen;
