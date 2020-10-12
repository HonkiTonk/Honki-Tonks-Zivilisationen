with GlobaleVariablen, BewegungssystemEinheiten, EinheitenDatenbank, ForschungsDatenbank, KartenDatenbank, VerbesserungenDatenbank, GebaeudeDatenbank, InDerStadt;

package KI is

   RassenAbgearbeitet : Integer;

   procedure KI;
   procedure KIAktivität (Rasse : in Integer);
   procedure KIBewegung (Rasse : in Integer);
   procedure KIStadtBauen (Rasse : in Integer);
   procedure KIVerbesserungAnlegen (Rasse : in Integer);
   procedure KIGebäudeBauen (Rasse : in Integer);

end KI;
