package body KIBewegung is

   procedure KIBewegung (Rasse : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord) is
   begin
      
      GlobaleVariablen.EinheitenGebaut (Rasse, EinheitStatus.EinheitNummer).AktuelleBewegungspunkte := 0.00;
      
   end KIBewegung;

end KIBewegung;
