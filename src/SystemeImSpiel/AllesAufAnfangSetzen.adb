pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleVariablen, GlobaleKonstanten, GlobaleDatentypen;

with Karten, Cheat, ZwischenDenRunden;

package body AllesAufAnfangSetzen is

   procedure AllesAufAnfangSetzen
   is begin
      
      GlobaleVariablen.RassenImSpiel := (others => GlobaleDatentypen.Leer);
      GlobaleVariablen.EinheitenGebaut := (others => (others => GlobaleKonstanten.LeerEinheit));
      GlobaleVariablen.StadtGebaut := (others => (others => GlobaleKonstanten.LeerStadt));
      GlobaleVariablen.Wichtiges := (others => GlobaleKonstanten.LeerWichtigesZeug);
      GlobaleVariablen.Diplomatie := (others => (others => GlobaleKonstanten.LeerDiplomatie));
      GlobaleVariablen.RundenAnzahl := Positive'First;
      GlobaleVariablen.RasseAmZugNachLaden := GlobaleDatentypen.Leer;
      GlobaleVariablen.CursorImSpiel := (others => GlobaleKonstanten.LeerCursor);
      GlobaleVariablen.Gewonnen := False;
      GlobaleVariablen.IronmanName := To_Unbounded_Wide_Wide_String (Source => "");
      Cheat.GewonnenDurchCheat := False;
      ZwischenDenRunden.WeiterSpielen := False;

      Karten.Weltkarte := (others => (others => (others => GlobaleKonstanten.LeerWeltkarte)));
      Karten.Kartengrößen := ((20, 20), (40, 40), (80, 80), (120, 80), (120, 160), (160, 160), (240, 240), (320, 320), (GlobaleDatentypen.KartenfeldPositiv'Last, GlobaleDatentypen.KartenfeldPositiv'Last),
                                (GlobaleDatentypen.KartenfeldPositiv'First, GlobaleDatentypen.KartenfeldPositiv'First));
            
   end AllesAufAnfangSetzen;

end AllesAufAnfangSetzen;
