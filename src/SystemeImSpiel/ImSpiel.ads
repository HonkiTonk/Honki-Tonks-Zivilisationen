pragma SPARK_Mode (On);

with SonstigeDatentypen; use SonstigeDatentypen;
with GlobaleVariablen;
with SystemKonstanten;

package ImSpiel is

   function ImSpiel
     return Integer
     with
       Post =>
         (ImSpiel'Result in -1 .. 0);

private

   RassenSchleifeVerlassenKonstante : constant Integer := -300;

   AktuellerBefehlSpieler : Integer;
   RückgabeWert : Integer;
   RückgabeOptionen : Integer;
   RückgabeRassen : Integer;

   procedure KISpieler
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SonstigeDatentypen.Spieler_KI);



   function RasseImSpiel
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return Integer;

   function RasseDurchgehen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return Integer;

   function MenschlicherSpieler
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return Integer
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SonstigeDatentypen.Spieler_Mensch),
         Post =>
           (MenschlicherSpieler'Result in SystemKonstanten.RundeBeendenKonstante .. 5);

   function MenschAmZug
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return Integer;

   function NochSpielerVorhanden
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return Boolean;

end ImSpiel;
