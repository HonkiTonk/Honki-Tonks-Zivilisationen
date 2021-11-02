pragma SPARK_Mode (On);

with SystemDatentypen;

package SonstigeDatentypen is

   type Spieler_Enum is (Leer, Spieler_Mensch, Spieler_KI);
   type RassenImSpielArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range) of Spieler_Enum;

   type Staatsform_Enum is (Anarchie,
                            Demokratie);

   type StaatsformenArray is array (1 .. 5) of Staatsform_Enum;
   -- Für Rassen



   -- Für Diplomatie
   type Status_Untereinander_Enum is (Unbekannt, Neutral, Nichtangriffspakt, Krieg);
   subtype Status_Untereinander_Bekannt_Enum is Status_Untereinander_Enum range Neutral .. Status_Untereinander_Enum'Last;
   -- Für Diplomatie

end SonstigeDatentypen;
