with Ada.Wide_Wide_Text_IO;
use Ada.Wide_Wide_Text_IO;

with GlobaleDatentypen, SchleifenPruefungen, KartenDatenbank, VerbesserungenDatenbank, Karten;
use GlobaleDatentypen;

package WerteFestlegen is
   
   procedure KartenfelderBewerten (Generierung : Boolean; EAchse : GlobaleDatentypen.Ebene; YAchse, XAchse : GlobaleDatentypen.KartenfeldPositiv);

private
   
   type KartenwertArray is array (-2 .. 2) of GlobaleDatentypen.AchsenAusKartenfeld;
   Kartenwert : KartenwertArray;

   procedure KartenfelderBewertenKleineSchleife (EAchse : GlobaleDatentypen.Ebene; YAchse, XAchse : GlobaleDatentypen.KartenfeldPositiv);
   procedure BewertungSelbst (EAchse : GlobaleDatentypen.Ebene; YAchse, XAchse, YAchseFeldAufschlag, XAchseFeldAufschlag : GlobaleDatentypen.KartenfeldPositiv; Teiler : GlobaleDatentypen.LoopRangeMinusDreiZuDrei);

end WerteFestlegen;
