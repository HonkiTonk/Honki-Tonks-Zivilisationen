with GlobaleVariablen, EinheitenDatenbank, ForschungsDatenbank, KartenDatenbank, VerbesserungenDatenbank, GebaeudeDatenbank, InDerStadt, SchleifenPruefungen, KIPruefungen, InDerStadt, GlobaleDatentypen, Karten, KIBewegung;
use GlobaleDatentypen;

package KI is

   procedure KI (RasseExtern : in Integer)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;

private

   EinheitExistiertNoch : Boolean;
   StadtErfolgreichGebaut : Boolean;

   EinheitStatus : GlobaleDatentypen.EinheitStatusRecord;

   procedure KIAktivität (RasseExtern : in Integer)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;
   procedure KIStadtBauen (RasseExtern : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;
   procedure KIVerbesserungAnlegen (RasseExtern : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;
   procedure KIGebäudeBauen (RasseExtern : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;
   procedure KIBefestigen (RasseExtern : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;
   procedure KIAngreifen (RasseExtern : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;

end KI;
