with GlobaleDatentypen, SchleifenPruefungen, KartenDatenbank, VerbesserungenDatenbank, Karten;
use GlobaleDatentypen;

package WerteFestlegen is
   
   procedure KartenfelderBewerten (Generierung : Boolean; EAchse : GlobaleDatentypen.Ebene; YAchse, XAchse : GlobaleDatentypen.KartenfeldPositiv);

private
   
   Kartenwert : GlobaleDatentypen.AchsenAusKartenfeld;

   procedure KartenfelderBewertenKleineSchleife (EAchse : GlobaleDatentypen.Ebene; YAchse, XAchse : GlobaleDatentypen.KartenfeldPositiv);

end WerteFestlegen;
