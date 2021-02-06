pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleVariablen, Karten, KIVariablen;

package body AllesAufAnfangSetzen is

   procedure AllesAufAnfangSetzen is
   begin
      
      GlobaleVariablen.RassenImSpiel := (others => 0);
      GlobaleVariablen.EinheitenGebaut := (others => (others => (0, 0,    0, (0, 1, 1),    0, 0.00, 0, 0,    0, 0)));
      GlobaleVariablen.StadtGebaut := (others =>
                                         (others =>
                                            ((0, (0, 1, 1),    False,    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,    "000000000000000000000000", To_Unbounded_Wide_Wide_String (Source => ""),    (others => (others => False)), 0, 1))));
      GlobaleVariablen.Wichtiges := (others => (0, 0, 0, 0, 0, 0, (others => 0)));
      GlobaleVariablen.Diplomatie := (others => (others => 0));
      GlobaleVariablen.RundenAnzahl := 1;
      GlobaleVariablen.RasseAmZugNachLaden := 0;

      Karten.Karten := (others => (others => (others => (0, False, (others => False), 0, 0, 0, 0, 0, 0))));

      KIVariablen.LetzteBewegungen := (others => (others => (others => (0, 0, 0))));
      KIVariablen.ZielBewegung := (others => (others => (others => (0, 0, 0))));
      
   end AllesAufAnfangSetzen;

end AllesAufAnfangSetzen;
