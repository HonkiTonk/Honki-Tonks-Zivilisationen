with GlobaleVariablen, EinheitenDatenbank, ForschungsDatenbank, KartenDatenbank, VerbesserungenDatenbank, GebaeudeDatenbank, InDerStadt, SchleifenPruefungen, KIPruefungen, InDerStadt, GlobaleDatentypen, Karten, KIBewegung;
use GlobaleDatentypen;

package KI is

   procedure KI;

private

   EinheitExistiertNoch : Boolean;
   StadtErfolgreichGebaut : Boolean;

   EinheitStatus : GlobaleDatentypen.EinheitStatusRecord;

   procedure KIAktivität (Rasse : in Integer);
   procedure KIStadtBauen (Rasse : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord);
   procedure KIVerbesserungAnlegen (Rasse : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord);
   procedure KIGebäudeBauen (Rasse : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord);
   procedure KIBefestigen (Rasse : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord);
   procedure KIAngreifen (Rasse : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord);

end KI;
