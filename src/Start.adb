pragma SPARK_Mode (On);

with GrafikStartEnde;
with SchreibenVerzeichnisse;
with Einlesen;
with Intro;
with Hauptmenue;
with EinlesenEinstellungen;
-- with WelcheSFMLAnzeige;

procedure Start
is

   task Logik;

   task body Logik
   is begin

      SchreibenVerzeichnisse.SchreibenVerzeichnisse;
      EinlesenEinstellungen.EinlesenEinstellungen;

      GrafikStartEnde.FensterErzeugen;

      Einlesen.Einlesen;

      Intro.Intro;

      Hauptmenue.Hauptmenü;

      GrafikStartEnde.FensterEntfernen;

   end Logik;

begin

   null;
   -- WelcheSFMLAnzeige.WelcheSFMLAnzeige;

end Start;
