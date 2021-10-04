pragma SPARK_Mode (On);

package SonstigeDatentypen is

   -- Für Rassen
   type Rassen_Enum is (Leer, Menschen, Kasrodiah, Lasupin, Lamustra, Manuky, Suroka, Pryolon, Talbidahr, Moru_Phisihl, Larinos_Lotaris, Carupex, Alary, Tesorahn, Natries_Zermanis, Tridatus, Senelari, Aspari_2, Ekropa);
   for Rassen_Enum use (Leer => 0, Menschen => 1, Kasrodiah => 2, Lasupin => 3, Lamustra => 4, Manuky => 5, Suroka => 6, Pryolon => 7, Talbidahr => 8, Moru_Phisihl => 9, Larinos_Lotaris => 10, Carupex => 11, Alary => 12,
                        Tesorahn => 13, Natries_Zermanis => 14, Tridatus => 15, Senelari => 16, Aspari_2 => 17, Ekropa => 18);
   pragma Ordered (Rassen_Enum);
   subtype Rassen_Verwendet_Enum is Rassen_Enum range Menschen .. Rassen_Enum'Last;

   type Spieler_Enum is (Leer, Spieler_Mensch, Spieler_KI);
   type RassenImSpielArray is array (Rassen_Verwendet_Enum'Range) of Spieler_Enum;

   type Staatsform_Enum is (Anarchie,
                            Demokratie);

   type StaatsformenArray is array (1 .. 5) of Staatsform_Enum;
   -- Für Rassen



   -- Für Diplomatie
   type Status_Untereinander_Enum is (Unbekannt, Neutral, Nichtangriffspakt, Krieg);
   subtype Status_Untereinander_Bekannt_Enum is Status_Untereinander_Enum range Neutral .. Status_Untereinander_Enum'Last;
   -- Für Diplomatie

end SonstigeDatentypen;
