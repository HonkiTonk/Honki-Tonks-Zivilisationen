with GlobaleVariablen, EinheitenDatenbank, ForschungsDatenbank, KartenDatenbank, VerbesserungenDatenbank, GebaeudeDatenbank, InDerStadt, SchleifenPruefungen, KIPruefungen, InDerStadt, GlobaleDatentypen, Karten, KIBewegung;
use GlobaleDatentypen;

package KI is

   procedure KI (RasseExtern : in Integer);

private

   EinheitExistiertNoch : Boolean;
   StadtErfolgreichGebaut : Boolean;

   EinheitStatus : GlobaleDatentypen.EinheitStatusRecord;

   procedure KIAktivität (RasseExtern : in Integer);
   procedure KIStadtBauen (RasseExtern : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord);
   procedure KIVerbesserungAnlegen (RasseExtern : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord);
   procedure KIGebäudeBauen (RasseExtern : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord);
   procedure KIBefestigen (RasseExtern : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord);
   procedure KIAngreifen (RasseExtern : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord);

end KI;
