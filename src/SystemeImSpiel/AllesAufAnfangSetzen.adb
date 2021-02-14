pragma SPARK_Mode (On);

with GlobaleVariablen, Karten, KIVariablen;

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

      KIVariablen.LetzteBewegungen := (others => (others => (others => (0, 0, 0))));
      KIVariablen.ZielBewegung := (others => (others => (others => (0, 0, 0))));
      
   end AllesAufAnfangSetzen;

end AllesAufAnfangSetzen;
