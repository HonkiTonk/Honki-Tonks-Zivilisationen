pragma SPARK_Mode (On);

with SonstigeDatentypen; use SonstigeDatentypen;
with SystemDatentypen;
with GlobaleVariablen;
with SystemKonstanten;

package ImSpiel is

   function ImSpiel
     return SystemDatentypen.Rückgabe_Werte_Enum;

private

   RassenSchleifeVerlassenKonstante : constant Integer := -300;

   AktuellerBefehlSpieler : Integer;
   RückgabeWert : Integer;
   RückgabeOptionen : Integer;
   RückgabeRassen : Integer;

   procedure KISpieler
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SonstigeDatentypen.Spieler_KI);



   function RasseImSpiel
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Integer;

   function RasseDurchgehen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Integer;

   function MenschlicherSpieler
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Integer
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SonstigeDatentypen.Spieler_Mensch),
         Post =>
           (MenschlicherSpieler'Result in SystemKonstanten.RundeBeendenKonstante .. 5);

   function MenschAmZug
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Integer;

   function NochSpielerVorhanden
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Boolean;

end ImSpiel;
