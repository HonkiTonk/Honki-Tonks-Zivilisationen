pragma SPARK_Mode (On);

with GlobaleVariablen, Karten;

package body AllesAufAnfangSetzen is

   procedure AllesAufAnfangSetzen is
   begin
      
      GlobaleVariablen.RassenImSpiel := (others => 0);
      GlobaleVariablen.EinheitenGebaut := (others => (others => GlobaleVariablen.LeererWertEinheit));
      GlobaleVariablen.StadtGebaut := (others => (others => GlobaleVariablen.LeererWertStadt));
      GlobaleVariablen.Wichtiges := (others => GlobaleVariablen.LeererWertWichtigesZeug);
      GlobaleVariablen.Diplomatie := (others => (others => GlobaleVariablen.Kein_Kontakt));
      GlobaleVariablen.RundenAnzahl := 1;
      GlobaleVariablen.RasseAmZugNachLaden := 0;
      GlobaleVariablen.CursorImSpiel := (others => GlobaleVariablen.LeererWertCursor);

      Karten.Karten := (others => (others => (others => Karten.LeererWertKarte)));
      
   end AllesAufAnfangSetzen;

end AllesAufAnfangSetzen;
