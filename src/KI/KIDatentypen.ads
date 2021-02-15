pragma SPARK_Mode (On);

package KIDatentypen is

   type Aufgabe is (Stadt_Bauen, Flucht, Erkunden, Verbesserung_Anlegen, Angreifen, Verteidigen);

   -- 1 = Norden = (-1, 0), 2 = Nord_Ost = (-1, 1), 3 = Osten = (0, 1), 4 = Süd_Osten = (1, 1), 5 = Süden = (1, 0), 6 = Süd_West = (1, -1), 7 = Westen = (0, -1), 8 = Nord_West = (-1, -1)
   type Richtung is (Leer, Norden, Nord_Ost, Osten, Süd_Ost, Süden, Süd_West, Westen, Nord_West);

end KIDatentypen;
