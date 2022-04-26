pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SonstigeVariablen;
with WichtigesKonstanten;
with TextKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;
with RassenDatentypen;
with SpielVariablen;

with DebugPlatzhalter;

package body AllesAufAnfangSetzen is

   procedure AllesAufAnfangSetzen
   is begin
      
      SonstigeVariablen.RassenImSpiel := (others => RassenDatentypen.Leer_Spieler_Enum);
      SpielVariablen.EinheitenGebaut := (others => (others => EinheitenKonstanten.LeerEinheit));
      SpielVariablen.StadtGebaut := (others => (others => StadtKonstanten.LeerStadt));
      SpielVariablen.Wichtiges := (others => WichtigesKonstanten.LeerWichtigesZeug);
      SpielVariablen.Diplomatie := (others => (others => WichtigesKonstanten.LeerDiplomatie));
      SpielVariablen.RundenAnzahl := Positive'First;
      SonstigeVariablen.RasseAmZugNachLaden := EinheitenKonstanten.LeerRasse;
      SpielVariablen.CursorImSpiel := (others => WichtigesKonstanten.LeerCursor);
      SonstigeVariablen.Gewonnen := False;
      SpielVariablen.IronmanName := TextKonstanten.LeerUnboundedString;
      SonstigeVariablen.WeiterSpielen := False;
      
      DebugPlatzhalter.DebugSieg := False;
      DebugPlatzhalter.FeindlicheInformationenSehen := False;
            
   end AllesAufAnfangSetzen;

end AllesAufAnfangSetzen;
