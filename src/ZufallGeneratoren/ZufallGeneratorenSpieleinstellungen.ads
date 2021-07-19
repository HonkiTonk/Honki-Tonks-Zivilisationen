pragma SPARK_Mode (Off);

with Ada.Numerics.Discrete_Random;

with GlobaleDatentypen;

package ZufallGeneratorenSpieleinstellungen is

   function Spieleinstellungen
     (WelcheEinstellungExtern : in Positive)
      return Positive
     with
       Pre =>
         (WelcheEinstellungExtern <= 6);

private
   
   -- Generatoren für zufällige Spieleinstellungen
   subtype ZufälligeKartengröße is Positive range 1 .. 9;
   subtype ZufälligeKartenart is Positive range 1 .. 5;
   subtype ZufälligeKartentemperatur is Positive range 1 .. 5;
   subtype ZufälligerSchwierigkeitsgrad is Positive range 1 .. 3;

   package ZufälligeKartengrößeWählen is new Ada.Numerics.Discrete_Random (ZufälligeKartengröße);
   package ZufälligeKartenartWählen is new Ada.Numerics.Discrete_Random (ZufälligeKartenart);
   package ZufälligeKartentemperaturWählen is new Ada.Numerics.Discrete_Random (ZufälligeKartentemperatur);   
   package ZufälligeSpieleranzahlRasseWählen is new Ada.Numerics.Discrete_Random (GlobaleDatentypen.Rassen_Verwendet_Enum);
   package ZufälligenSchwierigkeitsgradWählen is new Ada.Numerics.Discrete_Random (ZufälligerSchwierigkeitsgrad);

   ZufälligeKartengrößeGewählt : ZufälligeKartengrößeWählen.Generator;
   ZufälligeKartenartGewählt : ZufälligeKartenartWählen.Generator;
   ZufälligeKartentemperaturGewählt : ZufälligeKartentemperaturWählen.Generator;
   ZufälligeSpieleranzahlRasseGewählt : ZufälligeSpieleranzahlRasseWählen.Generator;
   ZufälligerSchwierigkeitsgradGewählt : ZufälligenSchwierigkeitsgradWählen.Generator;
   -- Generatoren für zufällige Spieleinstellungen

end ZufallGeneratorenSpieleinstellungen;
