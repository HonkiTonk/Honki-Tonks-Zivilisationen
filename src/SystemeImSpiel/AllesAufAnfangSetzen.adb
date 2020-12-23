package body AllesAufAnfangSetzen is

   procedure AllesAufAnfangSetzen is
   begin
      
      GlobaleVariablen.RassenImSpiel := (others => 0);
      GlobaleVariablen.EinheitenGebaut := (others => (others => (0, 0,    0, 1, 1,    0, 0.00, 0, 0,    0, 0)));
      GlobaleVariablen.StadtGebaut := (others =>
                                         (others =>
                                            ((0, 1, 1,    False,    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,    "000000000000000000000000", To_Unbounded_Wide_Wide_String (Source => ""),    (others => (others => False)), 0, 1))));
      GlobaleVariablen.Wichtiges := (others => (0, 0, 0, 0, 0, 0, (others => 0)));
      GlobaleVariablen.Diplomatie := (others => (others => 0));
      GlobaleVariablen.RundenAnzahl := 1;

      Karten.Karten := (others => (others => (others => (0, False, False, 0, 0, 0, 0, 0, 0))));
      Karten.Stadtkarte := (others => (others => (0)));
      
   end AllesAufAnfangSetzen;

end AllesAufAnfangSetzen;
