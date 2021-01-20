with GlobaleVariablen, EinheitenDatenbank, ForschungsDatenbank, KartenDatenbank, VerbesserungenDatenbank, GebaeudeDatenbank, InDerStadt, SchleifenPruefungen, KIPruefungen, InDerStadt, GlobaleDatentypen, Karten, KIBewegung,
     KIRecords;
use GlobaleDatentypen;

package KI is

   procedure KI (RasseExtern : in GlobaleDatentypen.Rassen);

private

   EinheitExistiertNoch : Boolean;
   StadtErfolgreichGebaut : Boolean;

   EinheitStatus : KIRecords.EinheitStatusRecord;

   procedure KIAktivität (RasseExtern : in GlobaleDatentypen.Rassen);
   procedure KIStadtBauen (RasseExtern : in GlobaleDatentypen.Rassen; EinheitStatus : KIRecords.EinheitStatusRecord);
   procedure KIVerbesserungAnlegen (RasseExtern : in GlobaleDatentypen.Rassen; EinheitStatus : KIRecords.EinheitStatusRecord);
   procedure KIGebäudeBauen (RasseExtern : in GlobaleDatentypen.Rassen; EinheitStatus : KIRecords.EinheitStatusRecord);
   procedure KIBefestigen (RasseExtern : in GlobaleDatentypen.Rassen; EinheitStatus : KIRecords.EinheitStatusRecord);
   procedure KIAngreifen (RasseExtern : in GlobaleDatentypen.Rassen; EinheitStatus : KIRecords.EinheitStatusRecord);

end KI;
